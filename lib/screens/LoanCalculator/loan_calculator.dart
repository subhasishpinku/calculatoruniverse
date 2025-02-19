import 'dart:async';
import 'dart:math';

import 'package:calculatoruniverse/loaders/color_loader.dart';
import 'package:calculatoruniverse/loaders/color_loader_2.dart';
import 'package:calculatoruniverse/loaders/loading_animation.dart';
import 'package:calculatoruniverse/loaders/myPainter.dart';
import 'package:calculatoruniverse/screens/LoanCalculator/component/compoundRow.dart';
import 'package:calculatoruniverse/component/inputFieldRow.dart';
import 'package:calculatoruniverse/constants/colors.dart';
import 'package:calculatoruniverse/screens/LoanCalculator/component/payback_text/paybackRow.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoanCalculator extends StatefulWidget {
  const LoanCalculator({super.key});

  @override
  State<LoanCalculator> createState() => _LoanCalculatorState();
}

class _LoanCalculatorState extends State<LoanCalculator> {
  final TextEditingController _controller = TextEditingController();
  String? _selectedValue;
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
              'Loan Calculator',
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
              Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  "Deferred Payment Loan: Paying Back a Lump Sum Due at Maturity",
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
                      DeferredCard(),
                       LoanDetailCardResult(),
                    ],
                  ),
                ],
              ),
               Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  "Bond: Paying Back a Predetermined Amount Due at Loan Maturity",
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
                      PayingBackCardCard(),
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

// class LoanDetailCard extends StatelessWidget {
//   const LoanDetailCard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 500,
//       width: 390,
//       child: Card(
//         elevation: 4,
//         shape: RoundedRectangleBorder(
//           side: const BorderSide(color: AppColor.lightGrayColor),
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Column(
//           children: [
//             const Padding(
//               padding: EdgeInsets.only(left: 16, right: 16, top: 16),
//               child: InputFieldRow(
//                 labelText: "Loan Amount",
//                 hintText: "Enter Loan Amount",
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 16, right: 16, bottom: 0),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Expanded(
//                     child: Padding(
//                       padding: EdgeInsets.only(top: 10),
//                       child: Text(
//                         "Loan Term",
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 16,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: SizedBox(
//                       height: 80,
//                       child: TextField(
//                         decoration: InputDecoration(
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           enabledBorder: const OutlineInputBorder(
//                             borderSide: BorderSide(
//                               color: AppColor.lightGrayColor,
//                               width: 1.0,
//                             ),
//                           ),
//                           focusedBorder: const OutlineInputBorder(
//                             borderSide: BorderSide(
//                               color: AppColor.lightGrayColor,
//                               width: 1.0,
//                             ),
//                           ),
//                           hintText: "Years",
//                           contentPadding: const EdgeInsets.symmetric(
//                             vertical: 10,
//                             horizontal: 16,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     width: 10,
//                   ),
//                   Expanded(
//                     child: SizedBox(
//                       height: 80,
//                       child: TextField(
//                         decoration: InputDecoration(
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           enabledBorder: const OutlineInputBorder(
//                             borderSide: BorderSide(
//                               color: AppColor.lightGrayColor,
//                               width: 1.0,
//                             ),
//                           ),
//                           focusedBorder: const OutlineInputBorder(
//                             borderSide: BorderSide(
//                               color: AppColor.lightGrayColor,
//                               width: 1.0,
//                             ),
//                           ),
//                           hintText: "Months",
//                           contentPadding: const EdgeInsets.symmetric(
//                             vertical: 10,
//                             horizontal: 16,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const Padding(
//               padding: EdgeInsets.only(left: 16, right: 16, top: 0),
//               child: InputFieldRow(
//                 labelText: "Interest Rate",
//                 hintText: "Enter Interest Rate	",
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class LoanDetailCard extends StatefulWidget {
  const LoanDetailCard({super.key});

  @override
  State<LoanDetailCard> createState() => _LoanDetailCardState();
}

class _LoanDetailCardState extends State<LoanDetailCard> {
  final TextEditingController loanAmountController = TextEditingController();
  final TextEditingController interestRateController = TextEditingController();
  final TextEditingController loanYearsController = TextEditingController();
  final TextEditingController loanMonthsController = TextEditingController();
  final TextEditingController _controller = TextEditingController();
  String? _selectedValue;
  final TextEditingController _paybackcontroller = TextEditingController();
  String? _paybackselectedValue;
  // String compoundValue = "";
  // String paybackValue = "";
  double monthlyPayment = 0.0;
  double dailyPayment = 0.0;
  bool isLoading = false;

  // void calculateLoan(String loanAmount, String interestRate, String loanYears,
  //     String loanMonths, int compoundValue, int paybackValue) {
  //   print('Loan Details: $compoundValue  $paybackValue');

  //   double loanAmount = double.tryParse(loanAmountController.text) ?? 0;
  //   int loanYears = int.tryParse(loanYearsController.text) ?? 0;
  //   int loanMonths = int.tryParse(loanMonthsController.text) ?? 0;
  //   double interestRate =
  //       (double.tryParse(interestRateController.text) ?? 0) / 100;

  //   // Total months and monthly interest rate calculation
  //   int totalMonths = (loanYears * compoundValue) + loanMonths;
  //   double monthlyInterestRate = interestRate / compoundValue;

  //   if (loanAmount > 0 && totalMonths > 0 && monthlyInterestRate > 0) {
  //     // Loan calculation formula
  //     double numerator = loanAmount *
  //         monthlyInterestRate *
  //         pow((1 + monthlyInterestRate), totalMonths);
  //     double denominator = pow((1 + monthlyInterestRate), totalMonths) - 1;

  //     setState(() {
  //       monthlyPayment = numerator / denominator;
  //     });
  //   } else {
  //     setState(() {
  //       monthlyPayment = 0.0;
  //     });
  //   }
  // }

  void calculateLoan(
      String loanAmountStr,
      String interestRateStr,
      String loanYearsStr,
      String loanMonthsStr,
      int compoundValue,
      int paybackValue) {
    // Parse input values
    double loanAmount = double.tryParse(loanAmountStr) ?? 0;
    int loanYears = int.tryParse(loanYearsStr) ?? 0;
    int loanMonths = int.tryParse(loanMonthsStr) ?? 0;
    double interestRate = (double.tryParse(interestRateStr) ?? 0) / 100;

    // Total loan term in days (considering paybackValue in days)
    int totalDays = (loanYears * 365) + (loanMonths * 30); // Approximation
    int totalPayments = totalDays ~/ paybackValue; // Total repayment periods
    double dailyInterestRate = interestRate / compoundValue;

    // Validate input values
    if (loanAmount > 0 && totalPayments > 0 && dailyInterestRate > 0) {
      // Loan calculation formula adjusted for daily repayments
      double numerator = loanAmount *
          dailyInterestRate *
          pow((1 + dailyInterestRate), totalPayments);
      double denominator = pow((1 + dailyInterestRate), totalPayments) - 1;

      setState(() {
        monthlyPayment = numerator / denominator;
      });
    } else {
      setState(() {
        monthlyPayment = 0.0;
      });
    }
  }

  void calculateDailyPayment(
      String loanAmountStr,
      String interestRateStr,
      String loanYearsStr,
      String loanMonthsStr,
      int compoundFrequency,
      int paybackFrequency) {
    // Parse input values
    double loanAmount = double.tryParse(loanAmountStr) ?? 0;
    int loanYears = int.tryParse(loanYearsStr) ?? 0;
    int loanMonths = int.tryParse(loanMonthsStr) ?? 0;
    double annualInterestRate = (double.tryParse(interestRateStr) ?? 0) / 100;

    // Calculate total loan term in days (365 days per year, 30 days per month)
    int totalLoanDays = (loanYears * 365) +
        (loanMonths * 30); // Approximate the loan term in days
    int totalPayments =
        totalLoanDays; // Total payments = total loan days for daily payments
    double dailyInterestRate =
        annualInterestRate / 365; // Daily interest rate (divide by 365)

    // Validate inputs to ensure no zero or invalid values
    if (loanAmount > 0 && totalPayments > 0 && dailyInterestRate > 0) {
      // Loan calculation formula for daily payments
      double numerator = loanAmount *
          dailyInterestRate *
          pow((1 + dailyInterestRate), totalPayments);
      double denominator = pow((1 + dailyInterestRate), totalPayments) - 1;

      setState(() {
        // Store the daily payment as the result
        dailyPayment = numerator / denominator;
        startTimer();
      });
    } else {
      setState(() {
        // If inputs are invalid or zero, set daily payment to 0
        dailyPayment = 0.0;
      });
    }
  }

  void startTimer() {
    // Define a 5-second interval
    Duration fiveSeconds = Duration(seconds: 5);

    // Schedule the timer to trigger every 5 seconds
    Timer.periodic(fiveSeconds, (timer) {
      // This code will run every 5 seconds
      print("Timer triggered! This happens every 5 seconds.");
      // You can place any function you want to call every 5 seconds here
      setState(() {
        isLoading = false;
        print("Loading End");
      });
    });
  }

  @override
  void initState() {
    super.initState();
    // Set the default value
    _selectedValue = 'Annually (APY)';
    _paybackselectedValue = 'Every Day';
    // _controller.text = _selectedValue!; // Sync the controller with the default value
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 610,
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
                labelText: "Loan Amount",
                hintText: "Enter Loan Amount",
                controller: loanAmountController,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            LoanTermRow(
              yearsController: loanYearsController,
              monthsController: loanMonthsController,
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
              height: 30,
            ),
            CompoundRow(
              controller: _controller,
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
            PayBackRow(
              controller: _paybackcontroller,
              selectedValue: _paybackselectedValue,
              onValueChanged: (value) {
                setState(() {
                  _paybackselectedValue = value;
                  // _controller.text = value!;
                });
              },
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
                        String interestRate = interestRateController.text;
                        String loanYears = loanYearsController.text;
                        String loanMonths = loanMonthsController.text;
                        String compound = _selectedValue!;
                        String payback = _paybackselectedValue!;

                        if (loanAmount!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter Loan Amount",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        } else if (loanYears!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter Loan Years",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        } else if (loanMonths!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter Loan Month",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        } else if (interestRate!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter Loan Interest Rate",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        } else if (compound!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter Compound",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        } else if (payback!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter Pay Back",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        } else {
                          print('Loan Amount: $loanAmount');
                          print('Loan Interest Rate: $interestRate%');
                          print(
                              'Loan Term: $loanYears years, $loanMonths months');
                          int compoundValue = getCompoundValue(compound);
                          print("Compound Value: $compoundValue");
                          int paybackValue = getPaybackValue(payback);
                          print("Payback Value: $paybackValue");
                          setState(() {
                            isLoading = true;
                            print("Loading started");
                          });
                          calculateLoan(loanAmount, interestRate, loanYears,
                              loanMonths, compoundValue, paybackValue);
                          calculateDailyPayment(
                              loanAmount,
                              interestRate,
                              loanYears,
                              loanMonths,
                              compoundValue,
                              paybackValue);
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
                        loanYearsController.clear();
                        loanMonthsController.clear();
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
              'Monthly Payment: \u{20B9}${monthlyPayment.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'Daily Payment: \u{20B9}${dailyPayment.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 16, right: 16, top: 0),
            //   child: Row(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       const Padding(
            //         padding: EdgeInsets.only(top: 10),
            //         child: Text(
            //           "Compound",
            //           style: TextStyle(
            //             color: Colors.black,
            //             fontWeight: FontWeight.bold,
            //             fontSize: 16,
            //           ),
            //         ),
            //       ),
            //       Expanded(
            //         child: Padding(
            //           padding: const EdgeInsets.only(left: 30),
            //           child: TextField(
            //             controller: _controller,
            //             decoration: InputDecoration(
            //               labelText: 'Select a Compound',
            //               floatingLabelBehavior: FloatingLabelBehavior
            //                   .always, // Ensure label is always visible
            //               border: OutlineInputBorder(
            //                 borderRadius: BorderRadius.circular(6),
            //                 borderSide: const BorderSide(
            //                   color: AppColor.lightGrayColor,
            //                   width: 1.0,
            //                 ),
            //               ),
            //               suffixIcon: DropdownButton<String>(
            //                 value: _selectedValue,
            //                 underline: const SizedBox(), // Remove underline
            //                 icon: const Icon(
            //                     Icons.arrow_drop_down), // Dropdown icon
            //                 items: const [
            //                   DropdownMenuItem(
            //                     value: 'Annually (APY)',
            //                     child: Text('Annually (APY)'),
            //                   ),
            //                   DropdownMenuItem(
            //                     value: 'Semi-annually',
            //                     child: Text('Semi-annually'),
            //                   ),
            //                   DropdownMenuItem(
            //                     value: 'Quarterly',
            //                     child: Text('Quarterly'),
            //                   ),
            //                   DropdownMenuItem(
            //                     value: 'Monthly (APR)',
            //                     child: Text('Monthly (APR)'),
            //                   ),
            //                   DropdownMenuItem(
            //                     value: 'Semi-monthly',
            //                     child: Text('Semi-monthly'),
            //                   ),
            //                   DropdownMenuItem(
            //                     value: 'Biweekly',
            //                     child: Text('Biweekly'),
            //                   ),
            //                   DropdownMenuItem(
            //                     value: 'Weekly',
            //                     child: Text('Weekly'),
            //                   ),
            //                   DropdownMenuItem(
            //                     value: 'Daily',
            //                     child: Text('Daily'),
            //                   ),
            //                   DropdownMenuItem(
            //                     value: 'Continuously',
            //                     child: Text('Continuously'),
            //                   ),
            //                 ],
            //                 onChanged: (value) {
            //                   setState(() {
            //                     _selectedValue = value;
            //                     // _controller.text = value!; // Update the TextField
            //                   });
            //                 },
            //               ),
            //             ),
            //             readOnly: true, // Makes the TextField non-editable
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
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

  // Helper function to build PieChart sections
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

class DeferredCard extends StatefulWidget {
  const DeferredCard({super.key});
  @override
  State<DeferredCard> createState() => _DeferredCardState();
}

class _DeferredCardState extends State<DeferredCard> {
  final TextEditingController loanAmountController = TextEditingController();
  final TextEditingController interestRateController = TextEditingController();
  final TextEditingController loanYearsController = TextEditingController();
  final TextEditingController loanMonthsController = TextEditingController();
  final TextEditingController _controller = TextEditingController();
  String? _selectedValue;
  double monthlyPayment = 0.0;
  double dailyPayment = 0.0;
  double totalDueAtMaturity = 0.0;
  double totalInterest = 0.0;
  bool isLoading = false;
  void calculateDeferredLoan(
    String loanAmountStr,
    String interestRateStr,
    String loanYearsStr,
    String loanMonthsStr,
    int compoundValue, // e.g., 12 for monthly compounding
  ) {
    // Parse input values
    double loanAmount = double.tryParse(loanAmountStr) ?? 0;
    int loanYears = int.tryParse(loanYearsStr) ?? 0;
    int loanMonths = int.tryParse(loanMonthsStr) ?? 0;
    double annualInterestRate = (double.tryParse(interestRateStr) ?? 0) / 100;

    // Calculate total loan term in months
    int totalMonths = (loanYears * 12) + loanMonths; // Total term in months

    // Calculate the compounded amount (final loan amount with interest)
    double compoundedAmount = loanAmount *
        pow(1 + annualInterestRate / compoundValue, compoundValue * loanYears);

    // Calculate the total lump sum due at maturity (principal + interest)
    totalDueAtMaturity = compoundedAmount;

    // Calculate total interest
    totalInterest = totalDueAtMaturity - loanAmount;

    setState(() {
      monthlyPayment = 0.0; // No monthly payments
      dailyPayment = 0.0; // No daily payments
      startTimer();
    });

    // Log the results
    print('Total Due at Maturity: \u{20B9}${totalDueAtMaturity.toStringAsFixed(2)}');
    print('Total Interest: \u{20B9}${totalInterest.toStringAsFixed(2)}');
  }

  void startTimer() {
    // Define a 5-second interval
    Duration fiveSeconds = Duration(seconds: 5);

    // Schedule the timer to trigger every 5 seconds
    Timer.periodic(fiveSeconds, (timer) {
      // This code will run every 5 seconds
      print("Timer triggered! This happens every 5 seconds.");
      // You can place any function you want to call every 5 seconds here
      setState(() {
        isLoading = false;
        print("Loading End");
      });
    });
  }

  @override
  void initState() {
    super.initState();
    // Set the default value
    _selectedValue = 'Annually (APY)';
    // _controller.text = _selectedValue!; // Sync the controller with the default value
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 580,
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
                labelText: "Loan Amount",
                hintText: "Enter Loan Amount",
                controller: loanAmountController,
              ),
            ),
             const SizedBox(
              height: 10,
            ),
            LoanTermRow(
              yearsController: loanYearsController,
              monthsController: loanMonthsController,
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
              height: 20,
            ),
            CompoundRow(
              controller: _controller,
              selectedValue: _selectedValue,
              onValueChanged: (value) {
                setState(() {
                  _selectedValue = value;
                  // _controller.text = value!;
                });
              },
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
                        String interestRate = interestRateController.text;
                        String loanYears = loanYearsController.text;
                        String loanMonths = loanMonthsController.text;
                        String compound = _selectedValue!;

                        if (loanAmount!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter Loan Amount",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        } else if (loanYears!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter Loan Years",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        } else if (loanMonths!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter Loan Month",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        } else if (interestRate!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter Loan Interest Rate",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        } else if (compound!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter Compound",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        } else {
                          print('Loan Amount: $loanAmount');
                          print('Loan Interest Rate: $interestRate%');
                          print(
                              'Loan Term: $loanYears years, $loanMonths months');
                          int compoundValue = getCompoundValue(compound);
                          print("Compound Value: $compoundValue");
                          setState(() {
                            isLoading = true;
                            print("Loading started");
                          });
                          calculateDeferredLoan(loanAmount, interestRate,
                              loanYears, loanMonths, compoundValue);
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
                        loanYearsController.clear();
                        loanMonthsController.clear();
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
              'Total Due at Maturity: \u{20B9}${totalDueAtMaturity.toStringAsFixed(2)}',
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

class PayingBackCardCard extends StatefulWidget {
  const PayingBackCardCard({super.key});
  @override
  State<PayingBackCardCard> createState() => _PayingBackCardCardState();
}
class _PayingBackCardCardState extends State<PayingBackCardCard> {
  final TextEditingController loanAmountController = TextEditingController();
  final TextEditingController interestRateController = TextEditingController();
  final TextEditingController loanYearsController = TextEditingController();
  final TextEditingController loanMonthsController = TextEditingController();
  final TextEditingController _controller = TextEditingController();
  String? _selectedValue;
  double totalDueAtMaturity = 0.0;
  double totalInterest = 0.0;
  double monthlyPayment = 0.0;
  double dailyPayment = 0.0;
  bool isLoading = false;

  // Method to calculate the deferred loan
  void calculateDeferredLoan(
    String loanAmountStr,
    String interestRateStr,
    String loanYearsStr,
    String loanMonthsStr,
    int compoundValue, // e.g., 12 for monthly compounding
  ) {
    // Parse input values
    double loanAmount = double.tryParse(loanAmountStr) ?? 0;
    int loanYears = int.tryParse(loanYearsStr) ?? 0;
    int loanMonths = int.tryParse(loanMonthsStr) ?? 0;
    double annualInterestRate = (double.tryParse(interestRateStr) ?? 0) / 100;

    // Calculate total loan term in months
    int totalMonths = (loanYears * 12) + loanMonths; // Total term in months

    // Calculate the compounded amount (final loan amount with interest)
    double compoundedAmount = loanAmount *
        pow(1 + annualInterestRate / compoundValue, compoundValue * loanYears);

    // Calculate the total lump sum due at maturity (principal + interest)
    totalDueAtMaturity = compoundedAmount;

    // Calculate total interest
    totalInterest = totalDueAtMaturity - loanAmount;

    // Set state of loading process
    setState(() {
      monthlyPayment = 0.0; // No monthly payments
      dailyPayment = 0.0; // No daily payments
      startTimer(); // Start timer for loading simulation
    });

    // Log the results
    print('Total Due at Maturity: \$${totalDueAtMaturity.toStringAsFixed(2)}');
    print('Total Interest: \$${totalInterest.toStringAsFixed(2)}');
  }

  void startTimer() {
    // Define a 5-second interval
    Duration fiveSeconds = Duration(seconds: 5);

    // Schedule the timer to trigger every 5 seconds
    Timer.periodic(fiveSeconds, (timer) {
      // This code will run every 5 seconds
      print("Timer triggered! This happens every 5 seconds.");
      // You can place any function you want to call every 5 seconds here
      setState(() {
        isLoading = false;
        print("Loading End");
      });
    });
  }

  @override
  void initState() {
    super.initState();
    // Set the default value
    _selectedValue = 'Annually (APY)';
    // _controller.text = _selectedValue!; // Sync the controller with the default value
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 580,
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
                labelText: "Due Amount",
                hintText: "Enter Loan Amount",
                controller: loanAmountController,
              ),
            ),
             const SizedBox(
              height: 10,
            ),
            LoanTermRow(
              yearsController: loanYearsController,
              monthsController: loanMonthsController,
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
              height: 30,
            ),
            CompoundRow(
              controller: _controller,
              selectedValue: _selectedValue,
              onValueChanged: (value) {
                setState(() {
                  _selectedValue = value;
                  // _controller.text = value!;
                });
              },
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
                        String interestRate = interestRateController.text;
                        String loanYears = loanYearsController.text;
                        String loanMonths = loanMonthsController.text;
                        String compound = _selectedValue!;

                        if (loanAmount!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter Loan Amount",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        } else if (loanYears!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter Loan Years",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        } else if (loanMonths!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter Loan Month",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        } else if (interestRate!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter Loan Interest Rate",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        } else if (compound!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter Compound",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        } else {
                          print('Loan Amount: $loanAmount');
                          print('Loan Interest Rate: $interestRate%');
                          print(
                              'Loan Term: $loanYears years, $loanMonths months');
                          int compoundValue = getCompoundValue(compound);
                          print("Compound Value: $compoundValue");
                          setState(() {
                            isLoading = true;
                            print("Loading started");
                          });
                          calculateDeferredLoan(loanAmount, interestRate,
                              loanYears, loanMonths, compoundValue);
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
                        loanYearsController.clear();
                        loanMonthsController.clear();
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
              'Total Due at Maturity: \u{20B9}${totalDueAtMaturity.toStringAsFixed(2)}',
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
int getCompoundValue(String compound) {
  if (compound == "Annually (APY)") {
    return 12;
  } else if (compound == "Semi-annually") {
    return 6;
  } else if (compound == "Quarterly") {
    return 4;
  } else if (compound == "Monthly (APR)") {
    return 1;
  } else if (compound == "Semi-monthly") {
    return 2;
  } else if (compound == "Biweekly") {
    return 26;
  } else if (compound == "Weekly") {
    return 52;
  } else if (compound == "Daily") {
    return 365;
  } else if (compound == "Continuously") {
    return 1; // Continuous compounding treated as monthly for simplicity
  }
  return 0; // Default if none matches
}

int getPaybackValue(String payback) {
  int paybackValue = 0;
  if (payback == "Every Day") {
    paybackValue = 1;
  } else if (payback == "Every Week") {
    paybackValue = 7;
  } else if (payback == "Every 2 Weeks") {
    paybackValue = 14;
  } else if (payback == "Every Half Month") {
    paybackValue = 15;
  } else if (payback == "Every Month") {
    paybackValue = 30;
  } else if (payback == "Every Quarter") {
    paybackValue = 90;
  } else if (payback == "Every 6 Months") {
    paybackValue = 180;
  } else if (payback == "Every Years") {
    paybackValue = 365;
  }
  return paybackValue;
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
