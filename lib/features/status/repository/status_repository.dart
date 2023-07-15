import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:whatsapp_clone/common/repositories/common_firebase_storage_repository.dart';
import 'package:whatsapp_clone/common/utils/utils.dart';
import 'package:whatsapp_clone/models/status_model.dart';
import 'package:whatsapp_clone/models/user_model.dart';

final statusRepositoryProvider = Provider((ref) => StatusRepository(
    firestore: FirebaseFirestore.instance,
    auth: FirebaseAuth.instance,
    ref: ref));

class StatusRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  final ProviderRef ref;

  StatusRepository({
    required this.firestore,
    required this.auth,
    required this.ref,
  });

  void uploadStatus({
    required String username,
    required String profilePic,
    required String phoneNumber,
    required File statusImage,
    required BuildContext context,
  }) async {
    try {
      var statusId = const Uuid().v1();
      String uid = auth.currentUser!.uid;

      // creating a collection in firebase if there already doesn't exists
      // and storing pictures
      String imageUrl = await ref
          .read(commonFirebaseStorageReopsitoryProvider)
          .storeFileToFirebase('/status/$statusId$uid', statusImage);

      // getting the contacts from phone cause only people in users contacts can see the status
      List<Contact> contacts = [];
      if (await FlutterContacts.requestPermission()) {
        contacts = await FlutterContacts.getContacts(withProperties: true);
      }

      List<String> uidWhoCanSee = [];

      // looping over each contacts to see if they exist in firebase
      for (var i = 0; i < contacts.length; i++) {
        var userDataFirebase = await firestore
            .collection('users')
            .where('phoneNumber',
                isEqualTo: contacts[i].phones[0].number.replaceAll(' ', ''))
            .get();

        if (userDataFirebase.docs.isNotEmpty) {
          // converting into model cause it is in json format
          // if you are sending data to json convert it
          // if you are getting data from json convert it
          var userData = UserModel.fromMap(userDataFirebase.docs[0].data());
          uidWhoCanSee.add(userData.uid);
        }
      }

      // after getting contacts list, now we can send the images
      // creating a list that contains all the image urls
      List<String> statusImageUrls = [];

      // looking if any status image already exists
      // if not add new one, if does(which has to be within 24 hours) then add to the list that already contains images
      var statusesSnapshot = await firestore
          .collection('status')
          .where('uid', isEqualTo: auth.currentUser!.uid)
          .where('createdAt',
              isLessThan: DateTime.now().subtract(const Duration(hours: 24)))
          .get();

      // if images do exists
      if (statusesSnapshot.docs.isNotEmpty) {
        StatusModel status =
            StatusModel.fromMap(statusesSnapshot.docs[0].data());

        // then add them to the list
        statusImageUrls = status.photoUrl;
        // and add new ones too
        statusImageUrls.add(imageUrl);
        // to the firestore collection
        await firestore
            .collection('status')
            .doc(statusesSnapshot.docs[0].id)
            .update({
          'photoUrl': statusImageUrls,
        });
        return;
      } else {
        // if this is the first image then just put in the list
        statusImageUrls = [imageUrl];
      }

      // whenever we are putting the file to firebase then we have to create here
      // if it has already been kept then the uid and everythings has already been given so no need to make
      StatusModel status = StatusModel(
        uid: uid,
        username: username,
        phoneNumber: phoneNumber,
        photoUrl: statusImageUrls,
        createdAt: DateTime.now(),
        profilePic: profilePic,
        statusId: statusId,
        whoCanSee: uidWhoCanSee,
      );

      // putting in the image to firebase so passing through json
      await firestore.collection('status').doc(statusId).set(status.toMap());
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }
}
