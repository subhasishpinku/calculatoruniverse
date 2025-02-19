import 'dart:async';
import 'dart:math';

import 'package:calculatoruniverse/component/inputFieldRow.dart';
import 'package:calculatoruniverse/constants/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PaymentCalculator extends StatefulWidget {
  const PaymentCalculator({super.key});

  @override
  State<PaymentCalculator> createState() => _PaymentCalculatorState();
}

class _PaymentCalculatorState extends State<PaymentCalculator> {
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
              'Payment Calculator',
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
                  "The Payment Calculator can determine the monthly payment amount or loan term for a fixed interest loan. Use the Fixed Term tab to calculate the monthly payment of a fixed-term loan. Use the Fixed Payments tab to calculate the time to pay off a loan with a fixed monthly payment. For more information about or to do calculations specifically for car payments, please use the Auto Loan Calculator. To find net payment of salary after taxes and deductions, use the Take-Home-Pay Calculator.",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: AppColor.defaultBlack,
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                  ),
                ),
              ),
              PaymentCalculatorCard(),
              PaymentCardResult()
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentCalculatorCard extends StatefulWidget {
  const PaymentCalculatorCard({super.key});
  @override
  State<PaymentCalculatorCard> createState() => _PaymentCalculatorCardState();
}

class _PaymentCalculatorCardState extends State<PaymentCalculatorCard> {
  final TextEditingController loanAmountController = TextEditingController();
  final TextEditingController loanAmountController1 = TextEditingController();

  final TextEditingController loanTermController = TextEditingController();
  final TextEditingController interestRateController = TextEditingController();
  final TextEditingController monthlyPayController = TextEditingController();
  final TextEditingController interestRateController1 = TextEditingController();

  String monthlyPayment = '0.0';
  String totalPayments = '0.0';
  String totalInterest = '0.0';
  bool isLoading = false;
  int selectedMode = 0;

  void calculatePayment(
      String loanAmount, String loanTerm, String interestRate) {
    final double loanAmounts = double.tryParse(loanAmount) ?? 0;
    final int loanTerms = int.tryParse(loanTerm) ?? 0;
    final double interestRates = (double.tryParse(interestRate) ?? 0) / 100;

    if (loanAmounts > 0 && loanTerms > 0 && interestRates > 0) {
      final double monthlyRate = interestRates / 12;
      final int totalMonths = loanTerms * 12;
      final double payment = loanAmounts *
          (monthlyRate * pow(1 + monthlyRate, totalMonths)) /
          (pow(1 + monthlyRate, totalMonths) - 1);

      final double totalPaid = payment * totalMonths;
      final double totalInt = totalPaid - loanAmounts;

      setState(() {
        monthlyPayment = payment.toStringAsFixed(2);
        totalPayments = totalPaid.toStringAsFixed(2);
        totalInterest = totalInt.toStringAsFixed(2);
        isLoading = false;
        startTimer();
      });
    } else {
      setState(() {
        monthlyPayment = 'Invalid input';
        totalPayments = '';
        totalInterest = '';
        isLoading = false;
        startTimer();
      });
    }
  }

  String _result = "";
  late int months = 0; // Loan term in months
  late double totalInterests = 0.0; // Total interest (double)
  late double totalPaid = 0.0; // Total amount paid (double)

  void _calculateLoanFixedPayment(
      String loanAmountInput, String monthlyInput, String interestRateInput) {
    // Parse the input strings into numbers
    final double loanAmount = double.tryParse(loanAmountInput) ?? 0.0;
    final double monthlyPayment = double.tryParse(monthlyInput) ?? 0.0;
    final double annualInterestRate = double.tryParse(interestRateInput) ?? 0.0;

    // Validate the inputs
    if (loanAmount <= 0 || monthlyPayment <= 0 || annualInterestRate <= 0) {
      setState(() {
        _result = 'Please enter valid values greater than 0.';
      });
      return;
    }

    final double monthlyRate = annualInterestRate / 12 / 100;

    // Check if the monthly payment is sufficient to cover interest
    if (monthlyPayment <= loanAmount * monthlyRate) {
      setState(() {
        _result = 'Monthly payment is too low to cover the interest.';
      });
      return;
    }

    // Calculate the number of months required to pay off the loan
    final double numerator =
        log(monthlyPayment / (monthlyPayment - loanAmount * monthlyRate));
    final double denominator = log(1 + monthlyRate);
    months = (numerator / denominator).ceil();

    // Calculate total interest paid
    totalPaid = months * monthlyPayment;
    totalInterests = totalPaid - loanAmount;
    print('Months: $months');
    print('Total Paid: $totalPaid');
    print('Total Interests: $totalInterests');
    // Update the result (convert to String when displaying)
    setState(() {
      _result =
          'Loan Term: $months months (${(months / 12).toStringAsFixed(1)} years)\n'
          'Total Interest: \$${totalInterests.toStringAsFixed(2)}\n'
          'Total Paid: \$${totalPaid.toStringAsFixed(2)}';
          startTimer();
    });
  }

  void clearInputs() {
    loanAmountController.clear();
    loanTermController.clear();
    interestRateController.clear();
    setState(() {
      monthlyPayment = '0.0';
      totalPayments = '0.0';
      totalInterest = '0.0';
    });
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
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: AppColor.lightGrayColor),
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => setState(() {
                    selectedMode = 0;
                  }),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedMode == 0
                        ? AppColor.primaryColor
                        : Colors.grey[300],
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("Fixed Term"),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => setState(() {
                    selectedMode = 1;
                  }),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedMode == 1
                        ? AppColor.primaryColor
                        : Colors.grey[300],
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("Fixed Payments"),
                ),
              ],
            ),
            const SizedBox(height: 20),
            selectedMode == 0
                ? buildFixedTermLayout()
                : buildFixedPaymentLayout(),
          ],
        ),
      ),
    );
  }

  buildFixedTermLayout() {
    return buildLayout();
  }

  buildFixedPaymentLayout() {
    return buildLayout1();
  }

  Widget buildLayout() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            InputFieldRow(
              labelText: "Loan Amount",
              hintText: "Enter Loan Amount",
              controller: loanAmountController,
            ),
            InputFieldRow(
              labelText: "Loan Term	",
              hintText: "Enter Term	",
              controller: loanTermController,
            ),
            InputFieldRow(
              labelText: "Interest Rate",
              hintText: "Enter Interest Rate",
              controller: interestRateController,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // ElevatedButton(
                //   onPressed: () {
                //     setState(() {
                //       isLoading = true;
                //     });
                //     calculatePayment(
                //       loanAmountController.text,
                //       loanTermController.text,
                //       interestRateController.text,
                //     );
                //   },
                //   child: isLoading
                //       ? const CircularProgressIndicator(
                //           valueColor: AlwaysStoppedAnimation<Color>(
                //               AppColor.primaryColor),
                //         )
                //       : const Text(
                //           "CALCULATOR",
                //           style: TextStyle(
                //             color: Colors.white,
                //             fontSize: 16.0,
                //             fontWeight: FontWeight.bold,
                //           ),
                //         ),
                // ),
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
                          msg: "Enter Loan Amount",
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
                        });
                        calculatePayment(
                          loanAmount,
                          loanTerm,
                          interestRate,
                        );
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
                const SizedBox(width: 10),
                SizedBox(
                  height: 50,
                  width: 100,
                  child: GestureDetector(
                    onTap: () async {
                      // Add your onTap functionality here

                      loanAmountController.clear();
                      loanTermController.clear();
                      interestRateController.clear();
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
            const SizedBox(height: 20),
            Text(
              'Monthly Payment: \u{20B9}$monthlyPayment',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              'Total Payment: \u{20B9}$totalPayments',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              'Total Interest: \u{20B9}$totalInterest',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLayout1() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            InputFieldRow(
              labelText: "Loan Amount",
              hintText: "Enter Loan Amount",
              controller: loanAmountController1,
            ),
            InputFieldRow(
              labelText: "Monthly Pay",
              hintText: "Enter Monthly",
              controller: monthlyPayController,
            ),
            InputFieldRow(
              labelText: "Interest Rate",
              hintText: "Enter Interest Rate",
              controller: interestRateController1,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // ElevatedButton(
                //   onPressed: () {
                //     setState(() {
                //       isLoading = true;
                //     });
                //     calculatePayment(
                //       loanAmountController.text,
                //       loanTermController.text,
                //       interestRateController.text,
                //     );
                //   },
                //   child: isLoading
                //       ? const CircularProgressIndicator(
                //           valueColor: AlwaysStoppedAnimation<Color>(
                //               AppColor.primaryColor),
                //         )
                //       : const Text(
                //           "CALCULATOR",
                //           style: TextStyle(
                //             color: Colors.white,
                //             fontSize: 16.0,
                //             fontWeight: FontWeight.bold,
                //           ),
                //         ),
                // ),
                SizedBox(
                  height: 50,
                  width: 140,
                  child: GestureDetector(
                    onTap: () async {
                      // Show the loader

                      String loanAmount = loanAmountController1.text;
                      String monthly = monthlyPayController.text;
                      String interestRate = interestRateController1.text;

                      if (loanAmount!.trim().isEmpty) {
                        Fluttertoast.showToast(
                          msg: "Enter Loan Amount",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          backgroundColor: AppColor.black,
                          textColor: AppColor.defaultWhite,
                        );
                      } else if (monthly!.trim().isEmpty) {
                        Fluttertoast.showToast(
                          msg: "Enter Monthly Pay",
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
                        });
                        _calculateLoanFixedPayment(
                          loanAmount,
                          monthly,
                          interestRate,
                        );
                        
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
                const SizedBox(width: 10),
                SizedBox(
                  height: 50,
                  width: 100,
                  child: GestureDetector(
                    onTap: () async {
                      // Add your onTap functionality here3
                      loanAmountController1.clear();
                      monthlyPayController.clear();
                      interestRateController1.clear();
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
            const SizedBox(height: 20),
            Text(
              'Loan Term: $months months (${(months / 12).toStringAsFixed(1)} years)\n',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              'Total Interest: \u{20B9}${totalInterests.toStringAsFixed(2)}\n',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              'Total Paid: \u{20B9}${totalPaid.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentCardResult extends StatefulWidget {
  const PaymentCardResult({super.key});
  @override
  State<PaymentCardResult> createState() => _LoanDetailCardResultState();
}

class _LoanDetailCardResultState extends State<PaymentCardResult> {
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
