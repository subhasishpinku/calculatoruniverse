import 'dart:async';
import 'dart:math';

import 'package:calculatoruniverse/component/inputFieldRow.dart';
import 'package:calculatoruniverse/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AmortizationCalculator extends StatefulWidget {
  const AmortizationCalculator({super.key});

  @override
  State<AmortizationCalculator> createState() => _AmortizationCalculatorState();
}

class _AmortizationCalculatorState extends State<AmortizationCalculator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.defaultWhite,
        centerTitle: true,
        elevation: 0,
        title: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Amortization Calculator',
              style: TextStyle(
                color: AppColor.defaultBlack,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
      backgroundColor: AppColor.defaultWhite,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: const Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  "Amortization schedule",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: AppColor.defaultBlack,
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [AmortizationCalculatorCard()],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AmortizationCalculatorCard extends StatefulWidget {
  const AmortizationCalculatorCard({super.key});
  @override
  State<AmortizationCalculatorCard> createState() =>
      _AmortizationCalculatorCardState();
}

class _AmortizationCalculatorCardState
    extends State<AmortizationCalculatorCard> {
  final TextEditingController loanAmountController = TextEditingController();
  final TextEditingController loanTermController = TextEditingController();
  final TextEditingController interestRateController = TextEditingController();

  double monthlyPayment = 0.0;
  double totalPayment = 0.0;
  double totalInterest = 0.0;

  void calculateAmortization() {
    double loanAmount = double.tryParse(loanAmountController.text) ?? 0.0;
    int loanTerm = int.tryParse(loanTermController.text) ?? 0;
    double interestRate = double.tryParse(interestRateController.text) ?? 0.0;

    if (loanAmount > 0 && loanTerm > 0 && interestRate > 0) {
      double monthlyInterestRate = interestRate / 100 / 12;
      int numberOfPayments = loanTerm * 12;

      // Monthly payment formula
      double numerator = monthlyInterestRate * pow((1 + monthlyInterestRate), numberOfPayments);
      double denominator = pow((1 + monthlyInterestRate), numberOfPayments) - 1;

      monthlyPayment = loanAmount * (numerator / denominator);
      totalPayment = monthlyPayment * numberOfPayments;
      totalInterest = totalPayment - loanAmount;
      startTimer();
      setState(() {});
    } else {
      setState(() {
        monthlyPayment = 0.0;
        totalPayment = 0.0;
        totalInterest = 0.0;
        startTimer();
      });
      startTimer();
    }
  }
  bool isLoading = false;

  void startTimer() {
    Duration fiveSeconds = Duration(seconds: 5);
    Timer.periodic(fiveSeconds, (timer) {
      print("Timer triggered! This happens every 5 seconds.");
      setState(() {
        isLoading = false;
        print("Loading End");
      });
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      width: 390,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: AppColor.lightGrayColor),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: InputFieldRow(
                labelText: "Loan amount",
                hintText: "Enter Loan amount",
                controller: loanAmountController,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 0),
              child: InputFieldRow(
                labelText: "Loan term",
                hintText: "Enter Loan term",
                controller: loanTermController,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 0),
              child: InputFieldRow(
                labelText: "Interest rate",
                hintText: "Enter Interest rate",
                controller: interestRateController,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16, top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 50,
                    width: 140,
                    child: GestureDetector(
                      onTap: () async {
                        // Show the loader

                        String loanAmount = loanAmountController.text;
                        String loanTerm = loanTermController.text;
                        String interestRate = interestRateController.text;

                        if (loanAmount!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter Loan amount",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        } else if (loanTerm!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter Loan Term",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        } else if (interestRate!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter Interest Rate",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        } else {
                          setState(() {
                            isLoading = true;
                            print("Loading started");
                            calculateAmortization();
                          });
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              AppColor.primaryColor,
                              AppColor.primaryColor,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        alignment: Alignment.center,
                        child: isLoading
                            ? const CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              )
                            : const Text(
                                "CALCULATOR",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    height: 50,
                    width: 100,
                    child: GestureDetector(
                      onTap: () async {
                        // Add your onTap functionality here
                        loanAmountController.clear();
                        interestRateController.clear();
                        loanTermController.clear();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              AppColor
                                  .lightGrayColor, // Replace AppColor.primaryColor
                              AppColor
                                  .lightGrayColor, // Replace AppColor.primaryColor
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          "CLEAR",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Monthly Payment:\u{20B9}${monthlyPayment.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'Total Payment: \u{20B9}${totalPayment.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'Total Interest: \u{20B9}${totalInterest.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            
          ],
        ),
      ),
    );
  }
}
