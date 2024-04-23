import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loanerist/constants/colors.dart';

class EditBudget extends StatefulWidget {
  final Map<String, dynamic>? budgetDetails;

  const EditBudget({super.key, this.budgetDetails});

  @override
  State<EditBudget> createState() => _EditBudgetState();
}

class _EditBudgetState extends State<EditBudget>  {
  final TextEditingController budgetNameController = TextEditingController();
  final TextEditingController budgetAmountController = TextEditingController();
  final TextEditingController? budgetCountController = TextEditingController();
  final TextEditingController budgetMonthlyPaymentController = TextEditingController();
  bool budgetRecurringController = false;

  late int? budgetAmountExact = int.tryParse(budgetAmountController.text);
  late int? budgetCountExact = int.tryParse(budgetCountController!.text);

  final bool _budgetNameController = false;
  final bool _budgetAmountController = false;
  final bool _budgetCountController = false;
  final bool _budgetMonthlyPaymentController = false;


  @override
  void initState() {
    super.initState();

    if (widget.budgetDetails != null) {
      final Map<String, dynamic> details = widget.budgetDetails!;
      budgetNameController.text = (details['name'] ?? '');
      budgetAmountController.text = (details['amount']).toString();
      budgetCountController?.text = (details['budget_count'] ?? '').toString();
      budgetRecurringController = (details['is_recurring']);
      budgetMonthlyPaymentController.text = (details['recurring_date'] ?? '');
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
            Text('Edit budget',
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
                      controller: budgetNameController,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color(0xFF76ABAE), width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Color(0xFF76ABAE), width: 1),
                        ),
                        errorText: _budgetNameController ? "Field can't be empty" : null,
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Color(0xFFD86951), width: 1),
                        ),
                        labelText: 'Budget Name',
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
                            budgetMonthlyPaymentController.text = formattedDate; // Update the controller's text within setState
                          });
                        }
                      },
                      child: AbsorbPointer(
                        child: TextField(
                          style: const TextStyle(fontSize: 13),
                          controller: budgetMonthlyPaymentController,
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
                            errorText: _budgetMonthlyPaymentController ? "Field can't be empty" : null,
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Color(0xFFD86951), width: 1),
                            ),
                            labelText: 'Recurring Date',
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
                      controller: budgetAmountController,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color(0xFF76ABAE), width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Color(0xFF76ABAE), width: 1),
                        ),
                        errorText: _budgetAmountController ? "Field can't be empty" : null,
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Color(0xFFD86951), width: 1),
                        ),
                        labelText: 'Budget Amount',
                        labelStyle: const TextStyle(color: Color(0xFFb2b7bf), fontSize: 13.0),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.47,
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      style: const TextStyle(fontSize: 13),
                      controller: budgetCountController,
                      enabled: !budgetRecurringController, // Disable the text field if budgetRecurringController is true
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color(0xFF76ABAE), width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Color(0xFF76ABAE), width: 1),
                        ),
                        errorText: _budgetCountController ? "Field can't be empty" : null,
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Color(0xFFD86951), width: 1),
                        ),
                        labelText: 'Monthly Amount',
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
                    width: MediaQuery.of(context).size.width * 0.47,
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Is recurring?',
                            style: const TextStyle(fontSize: 13),
                          ),
                        ),
                        Switch(
                          value: budgetRecurringController,
                          onChanged: (newValue) {
                            setState(() {
                              budgetRecurringController = newValue; // Update the boolean variable
                            });
                          },
                        ),
                      ],
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
                  await editBudget(
                    widget.budgetDetails?['id'],
                    budgetNameController,
                    budgetAmountExact!,
                    budgetCountExact,
                    budgetRecurringController,
                    budgetMonthlyPaymentController,
                    context,
                  );
                },
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(ColorConstants.blackColor),
                  backgroundColor: MaterialStateProperty.all<Color>(ColorConstants.blueAccentColor),
                ),
                child: const Text('Edit Budget'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> editBudget(
      String budgetId,
      TextEditingController budgetNameController,
      int budgetAmountController,
      int? budgetCountController,
      bool budgetRecurringController,
      TextEditingController budgetMonthlyPaymentController,
      BuildContext context,
      ) async {
    try {
      // Get the current user
      User? user = FirebaseAuth.instance.currentUser;
      DocumentReference budgetDocument = FirebaseFirestore.instance
          .doc('user_info/${user?.uid}/budget/$budgetId');

      DocumentSnapshot loanSnapshot = await budgetDocument.get();

      Map<String, dynamic> budgetData =
      loanSnapshot.data() as Map<String, dynamic>;

      budgetData['amount'] = budgetAmountController;
      budgetData['budget_count'] = budgetCountController;
      budgetData['is_recurring'] = budgetRecurringController;
      budgetData['recurring_date'] = budgetMonthlyPaymentController.text;
      budgetData['name'] = budgetNameController.text;

      await budgetDocument.set(budgetData);
    } catch (e) {
      print('Error: $e');
    }
  }
}