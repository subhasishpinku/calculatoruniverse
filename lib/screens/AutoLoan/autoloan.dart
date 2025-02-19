import 'dart:async';
import 'dart:math';

import 'package:calculatoruniverse/component/inputFieldRow.dart';
import 'package:calculatoruniverse/constants/colors.dart';
import 'package:calculatoruniverse/screens/AutoLoan/component/StateRow.dart';
import 'package:calculatoruniverse/screens/LoanCalculator/component/compoundRow.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AutoLoan extends StatefulWidget {
  const AutoLoan({super.key});

  @override
  State<AutoLoan> createState() => _AutoLoanState();
}

class _AutoLoanState extends State<AutoLoan> {
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
              'Auto Loan Calculator',
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
                  "Amortized Loan: Paying Back a Fixed Amount Periodically",
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
                    children: [
                      LoanDetailCard(),
                      LoanDetailCardResult(),
                    ],
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

class LoanDetailCard extends StatefulWidget {
  const LoanDetailCard({super.key});
  @override
  State<LoanDetailCard> createState() => _LoanDetailCardState();
}

class _LoanDetailCardState extends State<LoanDetailCard> {
  final TextEditingController autoPriceController = TextEditingController();
  final TextEditingController loanTermController = TextEditingController();
  final TextEditingController interestRateController = TextEditingController();
  final TextEditingController cashIncentivesController =
      TextEditingController();
  final TextEditingController downPaymentController = TextEditingController();
  final TextEditingController tradeInValueController = TextEditingController();
  final TextEditingController amountValueController = TextEditingController();
  final TextEditingController salesTaxController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController otherController = TextEditingController();

  String? _selectedValue;
  double monthlyPayment = 0.0;
  double totalLoanAmount = 0.0;
  double totalInterest = 0.0;
  double totalCost = 0.0;
  bool isLoading = false;

  double monthlyPayments = 0.0;
  double totalLoanAmounts = 0.0;
  double totalInterests = 0.0;
  double totalCosts = 0.0;

  void calculateLoan(
    String autoPrice,
    String loanTerm,
    String interestRate,
    String cashIncentives,
    String downPayment,
    String tradeInValue,
    String amountTradeIn,
    String salesTaxRate, // Sales tax as String
  ) {
    // Parse inputs
    final double parsedAutoPrice = double.tryParse(autoPrice) ?? 0.0;
    final int parsedLoanTerm = int.tryParse(loanTerm) ?? 0;
    final double parsedInterestRate = double.tryParse(interestRate) ?? 0.0;
    final double parsedCashIncentives = double.tryParse(cashIncentives) ?? 0.0;
    final double parsedDownPayment = double.tryParse(downPayment) ?? 0.0;
    final double parsedTradeInValue = double.tryParse(tradeInValue) ?? 0.0;
    final double parsedAmountTradeIn = double.tryParse(amountTradeIn) ?? 0.0;
    final double salesTaxRates = double.tryParse(salesTaxRate) ?? 0.0; // Correct parsing

    // Calculate net trade-in value
    final double netTradeInValue = parsedTradeInValue - parsedAmountTradeIn;

    // Calculate sales tax
    final double salesTax = (parsedAutoPrice * salesTaxRates) / 100;

    // Calculate total loan amount (subtract down payment and net trade-in, add sales tax, subtract incentives)
    final double totalLoanAmount = parsedAutoPrice -
        parsedDownPayment -
        netTradeInValue +
        salesTax -
        parsedCashIncentives;

    // Convert annual interest rate to monthly interest rate
    final double monthlyRate = (parsedInterestRate / 100) / 12;

    // Calculate monthly payment (EMI)
    double monthlyPayment;
    if (monthlyRate > 0) {
      monthlyPayment = totalLoanAmount *
          monthlyRate *
          pow(1 + monthlyRate, parsedLoanTerm) /
          (pow(1 + monthlyRate, parsedLoanTerm) - 1);
    } else {
      monthlyPayment = totalLoanAmount / parsedLoanTerm;
    }

    // Calculate total interest and total cost
    final double totalInterest =
        (monthlyPayment * parsedLoanTerm) - totalLoanAmount;
    final double totalCost = parsedAutoPrice + salesTax + totalInterest;
    setState(() {
      monthlyPayments = monthlyPayment;
      totalLoanAmounts = totalLoanAmount;
      totalInterests = totalInterest;
      totalCosts = totalCost;
      startTimer(); // Start timer for loading simulation
    });
    // Display results
    print("Monthly Payment: \$${monthlyPayment.toStringAsFixed(2)}");
    print("Total Loan Amount: \$${totalLoanAmount.toStringAsFixed(2)}");
    print("Total Interest: \$${totalInterest.toStringAsFixed(2)}");
    print("Total Cost: \$${totalCost.toStringAsFixed(2)}");
  }

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
    _selectedValue = 'Andhra Pradesh';
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1200,
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
                labelText: "Auto Price",
                hintText: "Enter Price",
                controller: autoPriceController,
              ),
            ),
             const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 0),
              child: InputFieldRow(
                labelText: "Loan Term",
                hintText: "Enter Term",
                controller: loanTermController,
              ),
            ),
             const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 0),
              child: InputFieldRow(
                labelText: "Interest Rate",
                hintText: "Enter Interest Rate",
                controller: interestRateController,
              ),
            ),
             const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 0),
              child: InputFieldRow(
                labelText: "Cash Incentives",
                hintText: "Enter Incentives",
                controller: cashIncentivesController,
              ),
            ),
             const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 0),
              child: InputFieldRow(
                labelText: "Down Payment",
                hintText: "Enter Down Payment",
                controller: downPaymentController,
              ),
            ),
             const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 0),
              child: InputFieldRow(
                labelText: "Trade-in Value",
                hintText: "Enter Trade-in Value",
                controller: tradeInValueController,
              ),
            ),
             const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 0),
              child: InputFieldRow(
                labelText: "Amount Trade-in",
                hintText: "Enter Trade-in Value",
                controller: amountValueController,
              ),
            ),
             const SizedBox(
              height: 20,
            ),
            StateRow(
              controller: _stateController,
              selectedValue: _selectedValue,
              onValueChanged: (value) {
                setState(() {
                  _selectedValue = value;
                  // _controller.text = value!;
                });
              },
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 0),
              child: InputFieldRow(
                labelText: "Sales Tax",
                hintText: "Enter Sales Tax",
                controller: salesTaxController,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 0),
              child: InputFieldRow(
                labelText: " Other Fees",
                hintText: "Enter  Other Fees",
                controller: otherController,
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

                        String autoPrice = autoPriceController.text;
                        String loanTerm = loanTermController.text;
                        String interestRate = interestRateController.text;
                        String cashIncentives = cashIncentivesController.text;
                        String dowenPayment = downPaymentController.text;
                        String tradeinValue = tradeInValueController.text;
                        String amounttradein = amountValueController.text!;
                        String stateValue = _selectedValue!;
                        String salesTax = salesTaxController.text!;
                        if (autoPrice!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter Auto Price",
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
                        } else if (cashIncentives!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter Cash Incentives",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        } else if (dowenPayment!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter Dowen payment",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        } else if (tradeinValue!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter Trade in Value",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        } else if (amounttradein!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter Amount Trade in Value",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        } else if (amounttradein!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter Amount Trade in Value",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        } else if (amounttradein!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter Amount Trade in Value",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        } else {
                          setState(() {
                            isLoading = true;
                            print("Loading started");
                          });
                          int stateValue = getStateValue(_selectedValue!);
                          print("State Value: $stateValue $_selectedValue");
                          calculateLoan(
                              autoPrice,
                              loanTerm,
                              interestRate,
                              cashIncentives,
                              dowenPayment,
                              tradeinValue,
                              amounttradein,
                              salesTax);
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
                        autoPriceController.clear();
                        interestRateController.clear();
                        cashIncentivesController.clear();
                        downPaymentController.clear();
                        tradeInValueController.clear();
                        amountValueController.clear();
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
            // print("Monthly Payment: \$${monthlyPayment.toStringAsFixed(2)}");
            // print("Total Loan Amount: \$${totalLoanAmount.toStringAsFixed(2)}");
            // print("Total Interest: \$${totalInterest.toStringAsFixed(2)}");
            // print("Total Cost: \$${totalCost.toStringAsFixed(2)}");
            Text(
              'Monthly Payment: \u{20B9}${monthlyPayments.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'Total Loan Amount: \u{20B9}${totalLoanAmounts.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'Total Interest: \u{20B9}${totalInterests.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'Total Cost: \u{20B9}${totalCosts.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class LoanDetailCardResult extends StatefulWidget {
  const LoanDetailCardResult({super.key});
  @override
  State<LoanDetailCardResult> createState() => _LoanDetailCardResultState();
}

class _LoanDetailCardResultState extends State<LoanDetailCardResult> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      width: 390, // Adjust card width
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: AppColor.lightGrayColor),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Result:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Payment Every Month'),
                  Text(
                    '\u{20B9}1,110.21',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Total of 120 Payments'),
                  Text(
                    '\u{20B9}133,224.60',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Total Interest'),
                  Text(
                    '\u{20B9}33,224.60',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Center(
                  child: PieChart(
                    PieChartData(
                      sections: _buildPieChartSections(),
                      centerSpaceRadius: 40,
                      sectionsSpace: 2,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> _buildPieChartSections() {
    return [
      PieChartSectionData(
        color: Colors.red,
        value: 50,
        title: '50%',
        radius: 60,
        titleStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      PieChartSectionData(
        color: Colors.blue,
        value: 25,
        title: '25%',
        radius: 60,
        titleStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      PieChartSectionData(
        color: Colors.yellow,
        value: 25,
        title: '25%',
        radius: 60,
        titleStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    ];
  }
}

int getStateValue(String compound) {
  switch (compound) {
    case "Andhra Pradesh":
      return 1;
    case "Arunachal Pradesh":
      return 2;
    case "Assam":
      return 3;
    case "Bihar":
      return 4;
    case "Chhattisgarh":
      return 5;
    case "Goa":
      return 6;
    case "Gujarat":
      return 7;
    case "Haryana":
      return 8;
    case "Himachal Pradesh":
      return 9;
    case "Jharkhand":
      return 10;
    case "Karnataka":
      return 11;
    case "Kerala":
      return 12;
    case "Madhya Pradesh":
      return 13;
    case "Maharashtra":
      return 14;
    case "Manipur":
      return 15;
    case "Meghalaya":
      return 16;
    case "Mizoram":
      return 17;
    case "Nagaland":
      return 18;
    case "Odisha":
      return 19;
    case "Punjab":
      return 20;
    case "Rajasthan":
      return 21;
    case "Sikkim":
      return 22;
    case "Tamil Nadu":
      return 23;
    case "Telangana":
      return 24;
    case "Tripura":
      return 25;
    case "Uttar Pradesh":
      return 26;
    case "Uttarakhand":
      return 27;
    case "West Bengal":
      return 28;
    default:
      return 0; // Default if none matches
  }
}

class LoanTermRow extends StatelessWidget {
  final TextEditingController yearsController;
  final TextEditingController monthsController;

  const LoanTermRow({
    required this.yearsController,
    required this.monthsController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                "Loan Term",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          Expanded(
            child: LoanTermField(
              hintText: "Years",
              controller: yearsController,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: LoanTermField(
              hintText: "Months",
              controller: monthsController,
            ),
          ),
        ],
      ),
    );
  }
}

class LoanTermField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;

  const LoanTermField({
    required this.hintText,
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFFDDDDDD), // Replace AppColor.lightGrayColor
              width: 1.0,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFFDDDDDD), // Replace AppColor.lightGrayColor
              width: 1.0,
            ),
          ),
          hintText: hintText,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 16,
          ),
        ),
      ),
    );
  }
}
