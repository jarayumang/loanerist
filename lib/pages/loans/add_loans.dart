import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toastification/toastification.dart';
import 'package:loanerist/constants/colors.dart';

class AddLoanModal extends StatefulWidget {
  const AddLoanModal({Key? key}) : super(key: key);

  @override
  _AddLoanModalState createState() => _AddLoanModalState();
}

class _AddLoanModalState extends State<AddLoanModal> {
  final TextEditingController loanNameController = TextEditingController();
  final TextEditingController loanAmountController = TextEditingController();
  final TextEditingController loanCountController = TextEditingController();
  final TextEditingController loanMonthlyAmountController = TextEditingController();
  final TextEditingController loanMonthlyPaymentController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();

  late int? loanAmountExact = int.tryParse(loanAmountController.text);
  late int? loanMonthlyAmountExact = int.tryParse(loanMonthlyAmountController.text);
  late int? loanCountExact = int.tryParse(loanCountController.text);

  final bool _loanNameController = false;
  final bool _loanAmountController = false;
  final bool _loanCountController = false;
  final bool _loanMonthlyAmountController = false;
  final bool _loanMonthlyPaymentController = false;
  final bool _startDateController = false;

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed
    loanNameController.dispose();
    loanAmountController.dispose();
    loanCountController.dispose();
    loanMonthlyAmountController.dispose();
    loanMonthlyPaymentController.dispose();
    startDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          color: ColorConstants.whiteAccentColor,
        ),
        padding: EdgeInsets.fromLTRB(10, 20, 10, MediaQuery.of(context).viewInsets.bottom + 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Add loans',
                style: TextStyle(
                    color: ColorConstants.blackColor,
                    fontFamily: 'NoirPro',
                    fontSize: 16,
                    fontWeight: FontWeight.w800)),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.48,
                    padding: const EdgeInsets.all(10.0), // Add padding manually if needed
                    child: TextField(
                      inputFormatters: [],
                      style: TextStyle(fontSize: 13),
                      controller: loanNameController,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color(0xFF76ABAE), width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Color(0xFF76ABAE), width: 1),
                        ),
                        errorText: _loanNameController ? "Field can't be empty" : null,
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Color(0xFFD86951), width: 1),
                        ),
                        labelText: 'Loan Name',
                        labelStyle: TextStyle(color: Color(0xFFb2b7bf), fontSize: 13.0),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.47,
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onTap: () async {
                        DateTime? selectedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                        if (selectedDate != null) {
                          String formattedDate = "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}";
                          setState(() {
                            startDateController.text = formattedDate; // Update the controller's text within setState
                          });
                        }
                      },
                      child: AbsorbPointer(
                        child: TextField(
                          inputFormatters: [],
                          style: TextStyle(fontSize: 13),
                          controller: startDateController,
                          readOnly: true, // Make the text field read-only
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Color(0xFF76ABAE), width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Color(0xFF76ABAE), width: 1),
                            ),
                            errorText: _startDateController ? "Field can't be empty" : null,
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Color(0xFFD86951), width: 1),
                            ),
                            labelText: 'Loan Start Date',
                            labelStyle: TextStyle(color: Color(0xFFb2b7bf), fontSize: 13.0),
                            suffixIcon: Align(
                              widthFactor: 1.0,
                              heightFactor: 1.0,
                              child: FaIcon(
                                FontAwesomeIcons.calendar, // Use the desired icon
                                color: Colors.grey,
                                size: 15,// Define the color of the icon
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.48,
                    padding: const EdgeInsets.all(10.0), // Add padding manually if needed
                    child: TextField(
                      inputFormatters: [],
                      style: TextStyle(fontSize: 13),
                      controller: loanAmountController,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color(0xFF76ABAE), width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Color(0xFF76ABAE), width: 1),
                        ),
                        errorText: _loanAmountController ? "Field can't be empty" : null,
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Color(0xFFD86951), width: 1),
                        ),
                        labelText: 'Loan Amount',
                        labelStyle: TextStyle(color: Color(0xFFb2b7bf), fontSize: 13.0),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.47,
                    padding: const EdgeInsets.all(10.0), // Add padding manually if needed
                    child: TextField(
                      inputFormatters: [],
                      style: TextStyle(fontSize: 13),
                      controller: loanCountController,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color(0xFF76ABAE), width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Color(0xFF76ABAE), width: 1),
                        ),
                        errorText: _loanCountController ? "Field can't be empty" : null,
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Color(0xFFD86951), width: 1),
                        ),
                        labelText: 'Loan Count',
                        labelStyle: TextStyle(color: Color(0xFFb2b7bf), fontSize: 13.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.48,
                    padding: const EdgeInsets.all(10.0), // Add padding manually if needed
                    child: TextField(
                      inputFormatters: [],
                      style: TextStyle(fontSize: 13),
                      controller: loanMonthlyAmountController,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color(0xFF76ABAE), width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Color(0xFF76ABAE), width: 1),
                        ),
                        errorText: _loanMonthlyAmountController ? "Field can't be empty" : null,
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Color(0xFFD86951), width: 1),
                        ),
                        labelText: 'Monthly Amount',
                        labelStyle: TextStyle(color: Color(0xFFb2b7bf), fontSize: 13.0),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.47,
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onTap: () async {
                        DateTime? selectedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                        if (selectedDate != null) {
                          String formattedDate = "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}";
                          setState(() {
                            loanMonthlyPaymentController.text = formattedDate; // Update the controller's text within setState
                          });
                        }
                      },
                      child: AbsorbPointer(
                        child: TextField(
                          style: TextStyle(fontSize: 13),
                          controller: loanMonthlyPaymentController,
                          readOnly: true, // Make the text field read-only
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Color(0xFF76ABAE), width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Color(0xFF76ABAE), width: 1),
                            ),
                            errorText: _loanMonthlyPaymentController ? "Field can't be empty" : null,
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Color(0xFFD86951), width: 1),
                            ),
                            labelText: 'Monthly Payment Date',
                            labelStyle: TextStyle(color: Color(0xFFb2b7bf), fontSize: 13.0),
                            suffixIcon: Align(
                              widthFactor: 1.0,
                              heightFactor: 1.0,
                              child: FaIcon(
                                FontAwesomeIcons.calendar, // Use the desired icon
                                color: Colors.grey,
                                size: 15,// Define the color of the icon
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              child: TextButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                  await addLoans(
                    loanNameController,
                    loanAmountExact!,
                    loanCountExact!,
                    loanMonthlyAmountExact!,
                    loanMonthlyPaymentController,
                    startDateController,
                    context,
                  );
                },
                child: Text('Add Loan'),
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(ColorConstants.blackColor),
                  backgroundColor: MaterialStateProperty.all<Color>(ColorConstants.blueAccentColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> addLoans(
    TextEditingController loanNameController,
    int loanAmountController,
    int loanCountController,
    int loanMonthlyAmountController,
    TextEditingController loanMonthlyPaymentController,
    TextEditingController startDateController,
    BuildContext context,
    ) async {
  try {
    // Get the current user
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      CollectionReference loans = FirebaseFirestore.instance.collection('user_info/${user.uid}/loans');

      await loans.add({
        'is_active': true,
        'end_date': '2024-01-01',
        'loan_amount': loanAmountController,
        'loan_count': loanCountController,
        'loan_monthly_amount': loanMonthlyAmountController,
        'loan_monthly_payment': loanMonthlyPaymentController.text,
        'loan_name': loanNameController.text,
        'start_date': startDateController.text,
      });

      // Show success toast notification
      toastification.show(
        context: context,
        type: ToastificationType.success,
        style: ToastificationStyle.flatColored,
        icon: FaIcon(
          FontAwesomeIcons.circleCheck,
          size: 20,
        ),
        title: Text('Successfully added loan'),
        autoCloseDuration: const Duration(seconds: 5),
      );
    } else {
      print('User not signed in!');
    }
  } catch (e) {
    toastification.show(
      context: context,
      type: ToastificationType.error,
      style: ToastificationStyle.flatColored,
      icon: FaIcon(
        FontAwesomeIcons.circleExclamation,
        size: 20,
      ),
      title: Text('Error adding data to Firestore: $e'),
      autoCloseDuration: const Duration(seconds: 5),
    );
  }
}