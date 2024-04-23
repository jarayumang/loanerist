import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

List months = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December'
];

List<String> getMonthsInRange(Map<String, dynamic> dateRange) {
  int startMonth = int.parse(dateRange['start']!.split('-')[1]);
  int endMonth = int.parse(dateRange['end']!.split('-')[1]);

  List<String> monthsInRange = [];
  for (int i = startMonth; i <= endMonth; i++) {
    monthsInRange.add(months[i - 1]);
  }
  return monthsInRange;
}

Future<List<Map<String, dynamic>>> getAllLoans() async {
  User? user = FirebaseAuth.instance.currentUser;
  CollectionReference loans = FirebaseFirestore.instance.collection('user_info/${user?.uid}/loans');

  List<Map<String, dynamic>> loansArray = [];

  try {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await loans.get() as QuerySnapshot<Map<String, dynamic>>;
    querySnapshot.docs.forEach((doc) {
      var dates = {
        'start': doc.data()['start_date'],
        'end': doc.data()['end_date'],
      };
      // print(doc.data());
      loansArray.add(dates);
    });
    return loansArray;
  } catch (e) {
    print("Error getting loans: $e");
    return []; // or handle the error accordingly
  }
}
