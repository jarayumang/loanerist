import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loanerist/constants/colors.dart';

class EditLoans extends StatefulWidget {
  final Map<String, dynamic>? loanDetails;

  const EditLoans({super.key, this.loanDetails});

  @override
  State<EditLoans> createState() => _EditLoansState();
}

class _EditLoansState extends State<EditLoans>  {
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
  void initState() {
    super.initState();

    if (widget.loanDetails != null) {
      final Map<String, dynamic> details = widget.loanDetails!;
      loanNameController.text = details['loan_name'] ?? '';
      loanAmountController.text = (details['loan_amount'] ?? '').toString();
      loanCountController.text = (details['loan_count'] ?? '').toString();
      loanMonthlyAmountController.text = (details['loan_monthly_amount'] ?? '').toString();
      loanMonthlyPaymentController.text = details['loan_monthly_payment'] ?? '';
      startDateController.text = details['start_date'] ?? '';
    }
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
            Text('Edit loan',
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
                      style: const TextStyle(fontSize: 13),
                      controller: loanNameController,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color(0xFF76ABAE), width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Color(0xFF76ABAE), width: 1),
                        ),
                        errorText: _loanNameController ? "Field can't be empty" : null,
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Color(0xFFD86951), width: 1),
                        ),
                        labelText: 'Loan Name',
                        labelStyle: const TextStyle(color: Color(0xFFb2b7bf), fontSize: 13.0),
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
                          style: const TextStyle(fontSize: 13),
                          controller: startDateController,
                          readOnly: true, // Make the text field read-only
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Color(0xFF76ABAE), width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Color(0xFF76ABAE), width: 1),
                            ),
                            errorText: _startDateController ? "Field can't be empty" : null,
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Color(0xFFD86951), width: 1),
                            ),
                            labelText: 'Loan Start Date',
                            labelStyle: const TextStyle(color: Color(0xFFb2b7bf), fontSize: 13.0),
                            suffixIcon: const Align(
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
            SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.48,
                    padding: const EdgeInsets.all(10.0), // Add padding manually if needed
                    child: TextField(
                      style: const TextStyle(fontSize: 13),
                      controller: loanAmountController,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color(0xFF76ABAE), width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Color(0xFF76ABAE), width: 1),
                        ),
                        errorText: _loanAmountController ? "Field can't be empty" : null,
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Color(0xFFD86951), width: 1),
                        ),
                        labelText: 'Loan Amount',
                        labelStyle: const TextStyle(color: Color(0xFFb2b7bf), fontSize: 13.0),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.47,
                    padding: const EdgeInsets.all(10.0), // Add padding manually if needed
                    child: TextField(
                      style: const TextStyle(fontSize: 13),
                      controller: loanCountController,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color(0xFF76ABAE), width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Color(0xFF76ABAE), width: 1),
                        ),
                        errorText: _loanCountController ? "Field can't be empty" : null,
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Color(0xFFD86951), width: 1),
                        ),
                        labelText: 'Loan Count',
                        labelStyle: const TextStyle(color: Color(0xFFb2b7bf), fontSize: 13.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.48,
                    padding: const EdgeInsets.all(10.0), // Add padding manually if needed
                    child: TextField(
                      style: const TextStyle(fontSize: 13),
                      controller: loanMonthlyAmountController,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color(0xFF76ABAE), width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Color(0xFF76ABAE), width: 1),
                        ),
                        errorText: _loanMonthlyAmountController ? "Field can't be empty" : null,
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Color(0xFFD86951), width: 1),
                        ),
                        labelText: 'Monthly Amount',
                        labelStyle: const TextStyle(color: Color(0xFFb2b7bf), fontSize: 13.0),
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
                          style: const TextStyle(fontSize: 13),
                          controller: loanMonthlyPaymentController,
                          readOnly: true, // Make the text field read-only
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Color(0xFF76ABAE), width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Color(0xFF76ABAE), width: 1),
                            ),
                            errorText: _loanMonthlyPaymentController ? "Field can't be empty" : null,
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Color(0xFFD86951), width: 1),
                            ),
                            labelText: 'Monthly Payment Date',
                            labelStyle: const TextStyle(color: Color(0xFFb2b7bf), fontSize: 13.0),
                            suffixIcon: const Align(
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
            const SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: TextButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                  await editLoan(
                    widget.loanDetails?['id'],
                    loanNameController,
                    loanAmountExact!,
                    loanCountExact!,
                    loanMonthlyAmountExact!,
                    loanMonthlyPaymentController,
                    startDateController,
                    context,
                  );
                },
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(ColorConstants.blackColor),
                  backgroundColor: MaterialStateProperty.all<Color>(ColorConstants.blueAccentColor),
                ),
                child: const Text('Add Loan'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> editLoan(
      String loanId,
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
        DocumentReference loanDocument = FirebaseFirestore.instance
            .doc('user_info/${user?.uid}/loans/$loanId');

        DocumentSnapshot loanSnapshot = await loanDocument.get();

        Map<String, dynamic> loanData =
        loanSnapshot.data() as Map<String, dynamic>;

        loanData['loan_amount'] = loanAmountController;
        loanData['loan_count'] = loanCountController;
        loanData['loan_monthly_amount'] = loanMonthlyAmountController;
        loanData['loan_monthly_payment'] = loanMonthlyPaymentController.text;
        loanData['loan_name'] = loanNameController.text;
        loanData['start_date'] = startDateController.text;

        await loanDocument.set(loanData);
    } catch (e) {
      print('Error: $e');
    }
  }
}