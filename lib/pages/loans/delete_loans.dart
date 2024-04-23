import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loanerist/pages/loans.dart';

import '../../constants/colors.dart';

AlertDialog buildAlertDialog(BuildContext context, String collectionId) {
  return AlertDialog(
    backgroundColor: ColorConstants.whiteColor,
    title: const Text("Confirm Delete"),
    content: const Text("Are you sure you want to delete this loan?"),
    actions: [
      ElevatedButton(
        style: ButtonStyle(
          side: MaterialStateProperty.all(BorderSide(
            width: 1,
            color: ColorConstants.textAccentColor,
          )),
          backgroundColor: MaterialStateProperty.all(ColorConstants.whiteColor),
        ),
        child: Text(
          'Cancel',
          style: GoogleFonts.prozaLibre(
              color: ColorConstants.textAccentColor,
              fontSize: 15,
              fontWeight: FontWeight.w500),
        ),
        onPressed: () {
          Navigator.of(context).pop(); // Dismiss the dialog
        },
      ),
      ElevatedButton(
        style: ButtonStyle(
          side: MaterialStateProperty.all(const BorderSide(
            width: 1,
            color: Colors.red,
          )),
          backgroundColor: MaterialStateProperty.all(ColorConstants.whiteColor),
        ),
        child: Text(
          'Delete',
          style: GoogleFonts.prozaLibre(
              color: Colors.red,
              fontSize: 15,
              fontWeight: FontWeight.w500),
        ),
        onPressed: () async {
          await deleteLoan(collectionId);
          Navigator.of(context).pop(); // Dismiss the dialog
          Navigator.of(context).pop(); // Dismiss the modal
        },
      ),
    ],
  );
}

Future<void> deleteLoan(String loanId) async {
  try {
    User? user = FirebaseAuth.instance.currentUser;

    DocumentReference loanDocument = FirebaseFirestore.instance
        .doc('user_info/${user?.uid}/loans/$loanId');

    DocumentSnapshot loanSnapshot = await loanDocument.get();

    if (loanSnapshot.exists) {
      Map<String, dynamic> loanData =
      loanSnapshot.data() as Map<String, dynamic>;

      // Update is_active to false
      loanData['is_active'] = false;

      // Update loanDocument with modified loanData
      await loanDocument.set(loanData);
    } else {
      print('Document does not exist');
    }
  } catch (e) {
    print('Error: $e');
  }
}
