import 'dart:math';

import 'package:calculatoruniverse/InterestCalculator/component/CompoundRow.dart';
import 'package:calculatoruniverse/InterestCalculator/component/MonthCompoundRow.dart';
import 'package:calculatoruniverse/InterestCalculator/component/YearsCompoundRow.dart';
import 'package:calculatoruniverse/component/inputFieldRow.dart';
import 'package:calculatoruniverse/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class InflationCalculatorScreen extends StatefulWidget {
  const InflationCalculatorScreen({super.key});

  @override
  State<InflationCalculatorScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<InflationCalculatorScreen> {
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
              'Inflation Calculator',
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
                  "Inflation Calculator with U.S. CPI Data",
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
                      InflationCalculatorCard(),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Text(
                          "Forward Flat Rate Inflation Calculator",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: AppColor.defaultBlack,
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      FlatRateInflationCard(),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Text(
                          "Backward Flat Rate Inflation Calculator",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: AppColor.defaultBlack,
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      BackwardFlatRateCard()
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

class InflationCalculatorCard extends StatefulWidget {
  const InflationCalculatorCard({super.key});
  @override
  State<InflationCalculatorCard> createState() =>
      _InflationCalculatorCardState();
}

class _InflationCalculatorCardState extends State<InflationCalculatorCard> {
  final TextEditingController loanAmountController = TextEditingController();

  final TextEditingController _controllermonth = TextEditingController();
  final TextEditingController _controlleryears = TextEditingController();

  final TextEditingController _controllermonth1 = TextEditingController();
  final TextEditingController _controlleryears1 = TextEditingController();
  String? _selectedValueMonth;
  String? _selectedValueyears;

  String? _selectedValueMonth1;
  String? _selectedValueyears1;
  String _result = '';
  bool isLoading = false;
  void _calculate() {
    final double? amount = double.tryParse(loanAmountController.text);
    if (amount == null) {
      setState(() {
        _result = "Please enter a valid amount.";
      });
      return;
    }
    final int fromYearInt = int.parse(_selectedValueyears!);
    final int toYearInt = int.parse(_selectedValueyears1!);
    double adjustedAmount = amount * (1 + (toYearInt - fromYearInt) * 0.02);
    setState(() {
      _result =
          "${amount.toStringAsFixed(2)} in $_selectedValueyears is equivalent to \u{20B9}${adjustedAmount.toStringAsFixed(2)} in $_selectedValueyears1.";
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant InflationCalculatorCard oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600,
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
                labelText: "amount",
                hintText: "Enter amount",
                controller: loanAmountController,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            MonthCompoundRow(
              controller: _controllermonth,
              selectedValue: _selectedValueMonth,
              onValueChanged: (value) {
                setState(() {
                  _selectedValueMonth = value;
                  // _controller.text = value!;
                });
              },
            ),
            const SizedBox(
              height: 10,
            ),
            YearsCompoundRow(
              controller: _controlleryears,
              selectedValue: _selectedValueyears,
              onValueChanged: (value) {
                setState(() {
                  _selectedValueyears = value;
                  // _controller.text = value!;
                });
              },
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "=	?	in ",
              style: TextStyle(
                fontSize: 20,
                color: AppColor.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            MonthCompoundRow(
              controller: _controllermonth1,
              selectedValue: _selectedValueMonth1,
              onValueChanged: (value) {
                setState(() {
                  _selectedValueMonth1 = value;
                  // _controller.text = value!;
                });
              },
            ),
            const SizedBox(
              height: 10,
            ),
            YearsCompoundRow(
              controller: _controlleryears1,
              selectedValue: _selectedValueyears1,
              onValueChanged: (value) {
                setState(() {
                  _selectedValueyears1 = value;
                  // _controller.text = value!;
                });
              },
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
                        // String loanTerm = loanTermController.text;
                        // String interestRate = interestRateController.text;
                        print("_selectedValueMonth $_selectedValueMonth");
                        if (loanAmount!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter Loan amount",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        }
                        if (_selectedValueMonth == null) {
                          Fluttertoast.showToast(
                            msg: "Select From Months",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        }
                        if (_selectedValueyears == null) {
                          Fluttertoast.showToast(
                            msg: "Select From Years",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        }
                        if (_selectedValueMonth == null) {
                          Fluttertoast.showToast(
                            msg: "Select To Months",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        }
                        if (_selectedValueyears1 == null) {
                          Fluttertoast.showToast(
                            msg: "Select To Years",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        } else {
                          setState(() {
                            isLoading = true;
                            print("Loading started");
                            _calculate();
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
                        loanAmountController.clear();
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
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Monthly Payment:\u{20B9}${_result}',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FlatRateInflationCard extends StatefulWidget {
  const FlatRateInflationCard({super.key});
  @override
  State<FlatRateInflationCard> createState() => _FlatRateInflationCardState();
}

class _FlatRateInflationCardState extends State<FlatRateInflationCard> {
  final TextEditingController flatAmountController = TextEditingController();

  final TextEditingController flatRateController = TextEditingController();
  final TextEditingController yearsRateController = TextEditingController();

  bool isLoading = false;
  String result = '';

  calculateInflation() {
    // Parse inputs
    double? amount = double.tryParse(flatAmountController.text);
    double? rate = double.tryParse(flatRateController.text);
    int? years = int.tryParse(yearsRateController.text);

    if (amount == null || rate == null || years == null) {
      Fluttertoast.showToast(
        msg: "Please enter valid inputs!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return;
    }

    // Calculate inflation
    double finalAmount = amount * pow((1 + (rate / 100)), years);

    // Format result
    setState(() {
      result = NumberFormat.currency(locale: 'en_US', symbol: '\u{20B9}')
          .format(finalAmount);
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant FlatRateInflationCard oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 520,
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
                labelText: "amount",
                hintText: "Enter amount",
                controller: flatAmountController,
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            const Text(
              "With inflation rate",
              style: TextStyle(
                fontSize: 20,
                color: AppColor.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 0),
              child: InputFieldRow(
                labelText: "Rate",
                hintText: "Enter Rate",
                controller: flatRateController,
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            const Text(
              "after",
              style: TextStyle(
                fontSize: 20,
                color: AppColor.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 0),
              child: InputFieldRow(
                labelText: "Years",
                hintText: "Enter Years",
                controller: yearsRateController,
              ),
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
                        String flatAmount = flatAmountController.text;
                        String flatRate = flatRateController.text;
                        String flatYears = yearsRateController.text;
                        if (flatAmount!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter amount",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        }
                        if (flatRate!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter Rate",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        }
                        if (flatYears!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Select  Years",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        } else {
                          isLoading = true;
                          calculateInflation();
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
                        flatAmountController.clear();
                        flatRateController.clear();
                        yearsRateController.clear();
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
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Flat Rate Inflation Calculator:${result}',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BackwardFlatRateCard extends StatefulWidget {
  const BackwardFlatRateCard({super.key});
  @override
  State<BackwardFlatRateCard> createState() => _BackwardFlatRateCardState();
}

class _BackwardFlatRateCardState extends State<BackwardFlatRateCard> {
  final TextEditingController flatAmountController1 = TextEditingController();

  final TextEditingController flatRateController1 = TextEditingController();
  final TextEditingController yearsRateController1 = TextEditingController();

  bool isLoading = false;
  String result = '';
  void calculateBackwardInflation() {
    // Parse inputs
    double? amount = double.tryParse(flatAmountController1.text);
    double? rate = double.tryParse(flatRateController1.text);
    int? years = int.tryParse(yearsRateController1.text);

    if (amount == null || rate == null || years == null) {
      Fluttertoast.showToast(
        msg: "Please enter valid inputs!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return;
    }

    // Calculate backward inflation
    double finalAmount = amount / pow((1 + (rate / 100)), years);

    // Format result
    setState(() {
       isLoading = false;
      result = NumberFormat.currency(locale: 'en_US', symbol: '\u{20B9}')
          .format(finalAmount);
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant BackwardFlatRateCard oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 520,
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
                labelText: "amount",
                hintText: "Enter amount",
                controller: flatAmountController1,
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            const Text(
              "With inflation rate",
              style: TextStyle(
                fontSize: 20,
                color: AppColor.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 0),
              child: InputFieldRow(
                labelText: "Rate",
                hintText: "Enter Rate",
                controller: flatRateController1,
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            const Text(
              "=	?",
              style: TextStyle(
                fontSize: 20,
                color: AppColor.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 0),
              child: InputFieldRow(
                labelText: "Years",
                hintText: "Enter Years",
                controller: yearsRateController1,
              ),
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
                        String flatAmount = flatAmountController1.text;
                        String flatRate = flatRateController1.text;
                        String flatYears = yearsRateController1.text;
                        if (flatAmount!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter amount",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        }
                        if (flatRate!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter Rate",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        }
                        if (flatYears!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Select  Years",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        } else {
                          isLoading = true;
                          calculateBackwardInflation();
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
                        flatAmountController1.clear();
                        flatRateController1.clear();
                        yearsRateController1.clear();
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
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Backward Flat Rate Inflation Calculator:${result}',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
