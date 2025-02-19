import 'dart:math';

import 'package:calculatoruniverse/Interest%20Calculator/PeriodUnitCompoundField.dart';
import 'package:calculatoruniverse/Interest%20Calculator/PeriodUnitRow.dart';
import 'package:calculatoruniverse/Interest%20Calculator/compoundFrequencyRow.dart';
import 'package:calculatoruniverse/InterestCalculator/component/CompoundRow.dart';
import 'package:calculatoruniverse/component/inputFieldRow.dart';
import 'package:calculatoruniverse/constants/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class InterestCalculators extends StatefulWidget {
  const InterestCalculators({super.key});

  @override
  State<InterestCalculators> createState() => _InterestCalculatorsState();
}

class _InterestCalculatorsState extends State<InterestCalculators> {
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
              'Simple and Compound Interest Calculator',
              style: TextStyle(
                color: AppColor.defaultBlack,
                fontWeight: FontWeight.bold,
                fontSize: 17,
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
              CompoundInterestCalculatorCard(),
              Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  "What is Simple Interest, A = P (1+rt).",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: AppColor.defaultBlack,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  "The rate at which you borrow or lend money is called the simple interest. If a borrower takes money from a lender, an extra amount of money is paid back to the lender. The borrowed money which is given for a specific period is called the principal. The extra amount which is paid back to the lender for using the money is called the interest.You calculate the simple interest by multiplying the principal amount by the number of periods and the interest rate. Simple interest does not compound, and you don’t have to pay interest on interest. In simple interest, the payment applies to the month’s interest, and the remainder of the payment will reduce the principal amount.",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: AppColor.defaultBlack,
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CompoundInterestCalculatorCard extends StatefulWidget {
  const CompoundInterestCalculatorCard({super.key});
  @override
  State<CompoundInterestCalculatorCard> createState() =>
      _CompoundInterestCalculatorCardState();
}

class _CompoundInterestCalculatorCardState
    extends State<CompoundInterestCalculatorCard> {
  final TextEditingController principalAmountController =
      TextEditingController();
  final TextEditingController annualRateController = TextEditingController();
  final TextEditingController periodUnitController = TextEditingController();

  final TextEditingController periodValueController = TextEditingController();
  final TextEditingController compoundFrequencyController =
      TextEditingController();
  bool isLoading = false;
  String selectedPeriodUnit = "Months";
  bool isCompoundInterest = false;
  String result = "";
  String _selectedValue = 'Simple Interest';
  String? _selectedPeriod = "Days";
  String? _selectedCompoundFrequency = "Daily";
  String? _refressValue = "0";
  double interest = 0.0;
  double totalValue = 0.0;
  double principals = 0.0;
  void calculateInterest() {
    principals = double.tryParse(principalAmountController.text) ?? 0.0;
    double rate = double.tryParse(annualRateController.text) ?? 0.0;
    double time = double.tryParse(periodValueController.text) ?? 0.0;
    print("periodUnitController $_selectedPeriod");
    // Convert time to years based on the period unit
    switch (_selectedPeriod) {
      case "Days":
        time = time / 365; // Convert days to years
        break;
      case "Weeks":
        time = time / 52; // Convert weeks to years
        break;
      case "Months":
        time = time / 12; // Convert months to years
        break;
      case "Quarters":
        time = time / 4; // Convert quarters to years
        break;
      case "Years":
        // Already in years, no conversion needed
        break;
      default:
        time = 0.0; // Handle unexpected period unit
    }

    if (isCompoundInterest) {
      // Compound Interest Formula: A = P * (1 + r/n)^(nt)
      totalValue = principals * pow((1 + rate / 100), time);
      interest = totalValue - principals;
    } else {
      // Simple Interest Formula: SI = P * R * T / 100
      interest = (principals * rate * time) / 100;
      totalValue = principals + interest;
    }

    setState(() {
      result =
          "Interest Earned: ₹${interest.toStringAsFixed(2)}\nTotal Value: ₹${totalValue.toStringAsFixed(2)}";
      isLoading = false;
      _refressValue = "1";
    });
  }

  double? interestEarned;
  double totalAmount = 0;
  double principal = 0;
  void calculateCompoundInterest() {
    principal = double.tryParse(principalAmountController.text) ?? 0.0;
    final double rate = double.tryParse(annualRateController.text) ?? 0.0;
    final int timeValue = int.tryParse(periodValueController.text) ?? 0;

    // Convert period to years based on the selected unit
    double timeInYears;
    switch (_selectedPeriod) {
      case "Days":
        timeInYears = timeValue / 365;
        break;
      case "Months":
        timeInYears = timeValue / 12;
        break;
      case "Years":
        timeInYears = timeValue.toDouble();
        break;
      default:
        timeInYears = timeValue.toDouble();
    }

    // Determine compounding frequency
    int n;
    switch (_selectedCompoundFrequency) {
      case "Daily":
        n = 365;
        break;
      case "Monthly":
        n = 12;
        break;
      case "Quarterly":
        n = 4;
        break;
      case "Semi-Annual":
        n = 2;
        break;
      default:
        n = 1;
    }

    // Apply the compound interest formula
    final double ratePerPeriod = rate / 100 / n;
    totalAmount = principal * pow((1 + ratePerPeriod), n * timeInYears);
    setState(() {
      isLoading = false;
      interestEarned = totalAmount - principal;
      _refressValue = "1";
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant CompoundInterestCalculatorCard oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1100,
      width: 390,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: AppColor.lightGrayColor),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Radio<String>(
                      value: 'Simple Interest',
                      groupValue: _selectedValue,
                      onChanged: (value) {
                        setState(() {
                          _selectedValue = value!;
                          principalAmountController.clear();
                          annualRateController.clear();
                          periodUnitController.clear();
                          periodValueController.clear();
                          compoundFrequencyController.clear();
                          _refressValue = "0";
                        });
                      },
                        activeColor:
                          Colors.black,
                    ),
                    const Text('Simple Interest'),
                  ],
                ),
                const SizedBox(width: 20), // Space between the radio buttons
                Row(
                  children: [
                    Radio<String>(
                      value: 'Compound Interest',
                      groupValue: _selectedValue,
                      onChanged: (value) {
                        setState(() {
                          _selectedValue = value!;
                          principalAmountController.clear();
                          annualRateController.clear();
                          periodUnitController.clear();
                          periodValueController.clear();
                          compoundFrequencyController.clear();
                          _refressValue = "0";
                        });
                      },
                        activeColor:
                          Colors.black,
                    ),
                    const Text('Compound Interest'),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: InputFieldRow(
                labelText: "Principal Amount (Rs.)",
                hintText: "Enter Principal Amount (Rs.)",
                controller: principalAmountController,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 0),
              child: InputFieldRow(
                labelText: "Annual rate",
                hintText: "Enter Annual rate",
                controller: annualRateController,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 18.0, bottom: 15.0),
                        child: Text(
                          'Period Unit',
                          style: TextStyle(
                            color: AppColor.defaultBlack,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 130,
                        child: PeriodUnitRow(
                          controller: periodUnitController,
                          selectedValue: _selectedPeriod,
                          onValueChanged: (value) {
                            setState(() {
                              _selectedPeriod = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                if (_selectedValue == "Compound Interest")
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 18, bottom: 15),
                              child: Text(
                                'Compound Frequency',
                                style: TextStyle(
                                  color: AppColor.defaultBlack,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 180,
                          child: compoundFrequencyRow(
                            controller: compoundFrequencyController,
                            selectedValue: _selectedCompoundFrequency,
                            onValueChanged: (value) {
                              setState(() {
                                _selectedCompoundFrequency = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),

            const SizedBox(
              height: 20,
            ),
            // if (_selectedValue == "Compound Interest")
            // const Row(
            //   children: [
            //     Padding(
            //       padding: EdgeInsets.only(left: 18, bottom: 15),
            //       child: Text(
            //         'Compound Frequency',
            //         style: TextStyle(
            //           color: AppColor.defaultBlack,
            //           fontWeight: FontWeight.bold,
            //           fontSize: 15,
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            // if (_selectedValue == "Compound Interest")
            //   compoundFrequencyRow(
            //     controller: compoundFrequencyController,
            //     selectedValue: _selectedCompoundFrequency,
            //     onValueChanged: (value) {
            //       setState(() {
            //         _selectedCompoundFrequency = value;
            //       });
            //     },
            //   ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 150),
              child: SizedBox(
                width: 200,
                child: InputFieldRow(
                  labelText: "Period Value",
                  hintText: "Enter Period Value",
                  controller: periodValueController,
                ),
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

                        String principalAmount = principalAmountController.text;
                        String annualRate = annualRateController.text;
                        String periodUnit = periodUnitController.text;
                        String periodValue = periodValueController.text;
                        String compoundFrequency =
                            compoundFrequencyController.text;

                        if (principalAmount!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter principal Amount",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        } else if (annualRate!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter annual Rate",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        }
                        // else if (periodUnit!.trim().isEmpty) {
                        //   Fluttertoast.showToast(
                        //     msg: "Enter period Unit",
                        //     toastLength: Toast.LENGTH_SHORT,
                        //     gravity: ToastGravity.CENTER,
                        //     backgroundColor: AppColor.black,
                        //     textColor: AppColor.defaultWhite,
                        //   );
                        // }
                        // else if (compoundFrequency!.trim().isEmpty) {
                        //   Fluttertoast.showToast(
                        //     msg: "Enter compound Frequency",
                        //     toastLength: Toast.LENGTH_SHORT,
                        //     gravity: ToastGravity.CENTER,
                        //     backgroundColor: AppColor.black,
                        //     textColor: AppColor.defaultWhite,
                        //   );
                        // }
                        else if (periodValue!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter period Value",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        } else {
                          setState(() {
                            isLoading = true;
                            if (_selectedValue == "Compound Interest") {
                              result = "";
                              calculateCompoundInterest();
                            } else {
                              interestEarned = 0;
                              calculateInterest();
                            }
                            print("Loading started");
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
                        principalAmountController.clear();
                        annualRateController.clear();
                        periodUnitController.clear();
                        periodValueController.clear();
                        compoundFrequencyController.clear();
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
            if (_refressValue == "1")
              CompoundInterestChart(
                initialPrincipalAmount:
                    principals ?? 0.0, // Use 0.0 if principals is null
                initialInterestEarned: interestEarned ?? 0.0,
                // Use 0.0 if interestEarned is null
              ),
            const SizedBox(height: 10),
            const Text(
              'Result:',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            if (_selectedValue == "Simple Interest")
              Text(
                ' \u{20B9}${result}',
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            if (_selectedValue == "Simple Interest")
              Text(
                'Principal Amount: \u{20B9}${principals.toStringAsFixed(2)}',
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            // if (_selectedValue == "Simple Interest")
            //   Text(
            //     'Total Value: \u{20B9}${totalValue}',
            //     style: const TextStyle(
            //         fontSize: 15, fontWeight: FontWeight.bold),
            //   ),
            if (_selectedValue == "Compound Interest")
              Text(
                'Interest Earned: \u{20B9}${interestEarned}',
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            if (_selectedValue == "Compound Interest")
              Text(
                'Principal Amount: \u{20B9}${totalAmount.toStringAsFixed(2)}',
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            if (_selectedValue == "Compound Interest")
              Text(
                'Total Value: \u{20B9}${principal.toStringAsFixed(2)}',
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }
}

// class CompoundInterestChart extends StatelessWidget {
//   final double principalAmount;
//   final double interestEarned;

//   const CompoundInterestChart({
//     Key? key,
//     required this.principalAmount,
//     required this.interestEarned,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final double totalValue = principalAmount + interestEarned;

//     return Column(
//       children: [
//         const Text(
//           "Compound Interest Breakdown",
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 16),
//         SizedBox(
//           height: 200,
//           child: PieChart(
//             PieChartData(
//               sections: [
//                 PieChartSectionData(
//                   value: principalAmount,
//                   color: Colors.green,
//                   title: "Principal",
//                   titleStyle: const TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//                 PieChartSectionData(
//                   value: interestEarned,
//                   color: Colors.blue,
//                   title: "Interest",
//                   titleStyle: const TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//               ],
//               centerSpaceRadius: 40,
//               sectionsSpace: 2,
//             ),
//           ),
//         ),
//         const SizedBox(height: 16),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             LegendItem(color: Colors.green, text: "Principal"),
//             LegendItem(color: Colors.blue, text: "Interest"),
//           ],
//         ),
//         const SizedBox(height: 16),
//         Text(
//           "Total Value: ₹${totalValue.toStringAsFixed(2)}",
//           style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//         ),
//       ],
//     );
//   }
// }

class CompoundInterestChart extends StatefulWidget {
  final double initialPrincipalAmount;
  final double initialInterestEarned;

  const CompoundInterestChart({
    Key? key,
    required this.initialPrincipalAmount,
    required this.initialInterestEarned,
  }) : super(key: key);

  @override
  State<CompoundInterestChart> createState() => _CompoundInterestChartState();
}

class _CompoundInterestChartState extends State<CompoundInterestChart> {
  late double principalAmount;
  late double interestEarned;

  @override
  void initState() {
    super.initState();
    principalAmount = widget.initialPrincipalAmount;
    interestEarned = widget.initialInterestEarned;
  }

  @override
  Widget build(BuildContext context) {
    final double totalValue = principalAmount + interestEarned;

    return Column(
      children: [
        const SizedBox(height: 16),
        const Text(
          "Compound Interest Breakdown",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        SizedBox(
          height: 200,
          child: PieChart(
            PieChartData(
              sections: [
                PieChartSectionData(
                  value: principalAmount,
                  color: Colors.green,
                  title: "Principal",
                  titleStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                PieChartSectionData(
                  value: interestEarned,
                  color: Colors.blue,
                  title: "Interest",
                  titleStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
              centerSpaceRadius: 40,
              sectionsSpace: 2,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            LegendItem(color: Colors.green, text: "Principal"),
            LegendItem(color: Colors.blue, text: "Interest"),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          "Total Value: ₹${totalValue.toStringAsFixed(2)}",
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class LegendItem extends StatelessWidget {
  final Color color;
  final String text;

  const LegendItem({
    Key? key,
    required this.color,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          color: color,
        ),
        const SizedBox(width: 8),
        Text(text),
      ],
    );
  }
}
