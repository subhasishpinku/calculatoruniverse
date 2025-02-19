import 'dart:math';

import 'package:calculatoruniverse/component/inputFieldRow.dart';
import 'package:calculatoruniverse/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FinanceCalculator extends StatefulWidget {
  const FinanceCalculator({super.key});

  @override
  State<FinanceCalculator> createState() => _FinanceCalculatorState();
}

class _FinanceCalculatorState extends State<FinanceCalculator> {
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
              'Finance Calculator',
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
                  "This finance calculator can be used to calculate the future value (FV), periodic payment (PMT), interest rate (I/Y), number of compounding periods (N), and PV (Present Value). Each of the following tabs represents the parameters to be calculated. It works the same way as the 5-key time value of money calculators, such as BA II Plus or HP 12CP calculator.",
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
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "FV CALCULATOR",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: AppColor.defaultBlack,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      FvCalculatorCard(),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "PMT CALCULATOR",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: AppColor.defaultBlack,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      PmtCalculatorCard(),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "I/Y CALCULATOR",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: AppColor.defaultBlack,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      IyCalculatorCard(),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Interest Per Years CALCULATOR",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: AppColor.defaultBlack,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      NCalculatorCard(),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Per Years CALCULATOR",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: AppColor.defaultBlack,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      PvCalculatorCard(),
                      SizedBox(
                        height: 10,
                      ),
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

class FvCalculatorCard extends StatefulWidget {
  const FvCalculatorCard({super.key});
  @override
  State<FvCalculatorCard> createState() => _FvCalculatorCardState();
}

class _FvCalculatorCardState extends State<FvCalculatorCard> {
  final TextEditingController periodsController = TextEditingController();
  final TextEditingController interestController = TextEditingController();
  final TextEditingController presentValueController = TextEditingController();
  final TextEditingController periodicPaymentController =
      TextEditingController();
  bool isLoading = false;
  String futureValue = "";
  void calculateFV() {
    final double? N = double.tryParse(periodsController.text);
    final double? annualInterest = double.tryParse(interestController.text);
    final double? PV = double.tryParse(presentValueController.text);
    final double? PMT = double.tryParse(periodicPaymentController.text);

    if (N == null || annualInterest == null || PV == null || PMT == null) {
      setState(() {
        futureValue = "Please enter valid numbers.";
        isLoading = false;
      });
      return;
    }

    double i = annualInterest / 100; // Convert annual interest to a decimal
    double FV = PV * pow(1 + i, N) + PMT * ((pow(1 + i, N) - 1) / i);

    setState(() {
      futureValue = "FV = \u{20B9}${FV.toStringAsFixed(2)}";
      print("loading vvv $futureValue");
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
  void didUpdateWidget(covariant FvCalculatorCard oldWidget) {
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
                labelText: "N (# of periods)",
                hintText: "Enter N (# of periods)",
                controller: periodsController,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: InputFieldRow(
                labelText: "I/Y (Interest per year)	",
                hintText: "Enter I/Y (Interest per year)",
                controller: interestController,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: InputFieldRow(
                labelText: "PV (Present Value)",
                hintText: "Enter PV (Present Value)",
                controller: presentValueController,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: InputFieldRow(
                labelText: "PMT (Periodic Payment)",
                hintText: "Enter PMT (Periodic Payment)",
                controller: periodicPaymentController,
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

                        String periods = periodsController.text;
                        String interest = interestController.text;
                        String presentValue = presentValueController.text;
                        String periodicPayment = periodicPaymentController.text;

                        if (periods!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter periods",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        }
                        if (interest!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter interest",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        }
                        if (presentValue!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter present Value",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        }
                        if (periodicPayment!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter periodic Payment",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        } else {
                          setState(() {
                            calculateFV();
                            isLoading = true;
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
                        periodsController.clear();
                        interestController.clear();
                        presentValueController.clear();
                        periodicPaymentController.clear();
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
                'Monthly Payment:\u{20B9}${futureValue}',
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

class PmtCalculatorCard extends StatefulWidget {
  const PmtCalculatorCard({super.key});
  @override
  State<PmtCalculatorCard> createState() => _PmtCalculatorCardState();
}

class _PmtCalculatorCardState extends State<PmtCalculatorCard> {
  final TextEditingController periodsController = TextEditingController();
  final TextEditingController interestController = TextEditingController();
  final TextEditingController presentValueController = TextEditingController();
  final TextEditingController futureValueController = TextEditingController();

  bool isLoading = false;
  double? pmtResult;

void calculatePMT() async {
  setState(() {
    isLoading = true; // Show loading indicator
  });

  // Introduce a small delay (simulate processing time, e.g., 2 seconds)
  await Future.delayed(Duration(seconds: 2));

  final int n = int.tryParse(periodsController.text) ?? 0;
  final double r = (double.tryParse(interestController.text) ?? 0) / 100; // Divide by 100 for percentage
  final double pv = double.tryParse(presentValueController.text) ?? 0;
  final double fv = double.tryParse(futureValueController.text) ?? 0;

  if (n > 0 && r > 0) {
    pmtResult = (pv * r + fv * r) / (1 - pow(1 + r, -n));
  } else {
    pmtResult = null;
  }

  setState(() {
    isLoading = false; // Hide loading indicator
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
  void didUpdateWidget(covariant PmtCalculatorCard oldWidget) {
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
                labelText: "N (# of periods)",
                hintText: "Enter N (# of periods)",
                controller: periodsController,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: InputFieldRow(
                labelText: "I/Y (Interest per year)	",
                hintText: "Enter I/Y (Interest per year)",
                controller: interestController,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: InputFieldRow(
                labelText: "PV (Present Value)",
                hintText: "Enter PV (Present Value)",
                controller: presentValueController,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: InputFieldRow(
                labelText: "FV (Future Value)	",
                hintText: "Enter FV (Future Value)	",
                controller: futureValueController,
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

                        String periods = periodsController.text;
                        String interest = interestController.text;
                        String presentValue = presentValueController.text;
                        String futureValue = futureValueController.text;

                        if (periods!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter periods",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        }
                        if (interest!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter interest",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        }
                        if (presentValue!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter present Value",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        }
                        if (futureValue!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter Future Value",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        } else {
                          setState(() {
                            calculatePMT();
                            isLoading = true;
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
                        periodsController.clear();
                        interestController.clear();
                        presentValueController.clear();
                        futureValueController.clear();
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
                'Monthly Payment:\u{20B9}${pmtResult}',
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

class IyCalculatorCard extends StatefulWidget {
  const IyCalculatorCard({super.key});
  @override
  State<IyCalculatorCard> createState() => _IyCalculatorCardState();
}

class _IyCalculatorCardState extends State<IyCalculatorCard> {
  final TextEditingController periodsController = TextEditingController();
  final TextEditingController presentValueController = TextEditingController();
  final TextEditingController periodicPaymentController =
      TextEditingController();
  final TextEditingController futureValueController = TextEditingController();
   double? interestRateResult;
  bool isLoading = false;

  void calculateInterestRate() async {
    setState(() {
      isLoading = true; // Show loading indicator
    });

    // Introduce a delay (optional, for simulating real computation)
    await Future.delayed(Duration(seconds: 1));

    final int n = int.tryParse(periodsController.text) ?? 0;
    final double pv = double.tryParse(presentValueController.text) ?? 0;
    final double pmt = double.tryParse(periodicPaymentController.text) ?? 0;
    final double fv = double.tryParse(futureValueController.text) ?? 0;

    if (n > 0) {
      // Use an iterative approach to find the interest rate (Newton-Raphson method)
      double guessRate = 0.05; // Initial guess: 5%
      double tolerance = 1e-6; // Convergence tolerance
      int maxIterations = 100; // Maximum iterations

      for (int i = 0; i < maxIterations; i++) {
        double denominator = pow(1 + guessRate, n) - 1;
        double functionValue = pv * pow(1 + guessRate, n) +
            pmt * denominator / guessRate +
            fv;
        double derivativeValue = n * pv * pow(1 + guessRate, n - 1) +
            pmt * (denominator / pow(guessRate, 2) - n * pow(1 + guessRate, n - 1) / guessRate);

        double newGuess = guessRate - functionValue / derivativeValue;

        // Check for convergence
        if ((newGuess - guessRate).abs() < tolerance) {
          guessRate = newGuess;
          break;
        }

        guessRate = newGuess;
      }

      setState(() {
        interestRateResult = guessRate * 100; // Convert to percentage
        isLoading = false;
      });
    } else {
      setState(() {
        interestRateResult = null;
        isLoading = false;
      });
    }
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
  void didUpdateWidget(covariant IyCalculatorCard oldWidget) {
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
                labelText: "N (# of periods)",
                hintText: "Enter N (# of periods)",
                controller: periodsController,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: InputFieldRow(
                labelText: "PV (Present Value)",
                hintText: "Enter PV (Present Value)",
                controller: presentValueController,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: InputFieldRow(
                labelText: "PMT (Periodic Payment)",
                hintText: "Enter PMT (Periodic Payment)",
                controller: periodicPaymentController,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: InputFieldRow(
                labelText: "FV (Future Value)	",
                hintText: "Enter FV (Future Value)	",
                controller: futureValueController,
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

                        String periods = periodsController.text;
                        String presentValue = presentValueController.text;

                        String periodicPayment = periodicPaymentController.text;
                        String futureValue = futureValueController.text;

                        if (periods!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter periods",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        }
                        if (presentValue!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter present Value",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        }
                        if (periodicPayment!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter PMT periodic Payment",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        }

                        if (futureValue!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter Future Value",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        } else {
                          setState(() {
                            isLoading = true;

                            calculateInterestRate();
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
                        periodsController.clear();
                        presentValueController.clear();
                        periodicPaymentController.clear();
                        futureValueController.clear();
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
                'Monthly Payment:\u{20B9}${interestRateResult}',
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

class NCalculatorCard extends StatefulWidget {
  const NCalculatorCard({super.key});
  @override
  State<NCalculatorCard> createState() => _NCalculatorCardState();
}

class _NCalculatorCardState extends State<NCalculatorCard> {
  final TextEditingController interestPerYearController =
      TextEditingController();
  final TextEditingController presentValueController = TextEditingController();
  final TextEditingController periodicPaymentController =
      TextEditingController();
  final TextEditingController futureValueController = TextEditingController();
  double? futureValueResult;
  bool isLoading = false;

  void calculateFutureValue() async {
    setState(() {
      isLoading = true; // Show loading indicator
    });

    // Simulate a delay (optional)
    await Future.delayed(Duration(seconds: 1));

    final double i = (double.tryParse(interestPerYearController.text) ?? 0) / 100; // Interest rate as a decimal
    final double pv = double.tryParse(presentValueController.text) ?? 0; // Present value
    final double pmt = double.tryParse(periodicPaymentController.text) ?? 0; // Periodic payment
    final int n = int.tryParse(futureValueController.text) ?? 0; // Number of periods

    if (n > 0 && i > 0) {
      // Formula for Future Value
      final double fv = pv * pow(1 + i, n) + pmt * ((pow(1 + i, n) - 1) / i);

      setState(() {
        futureValueResult = fv; // Store the result
        isLoading = false; // Hide loading indicator
      });
    } else {
      setState(() {
        futureValueResult = null;
        isLoading = false; // Hide loading indicator
      });
    }
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
  void didUpdateWidget(covariant NCalculatorCard oldWidget) {
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
                labelText: "I/Y (Interest per year)	",
                hintText: "Enter I/Y (Interest per year)",
                controller: interestPerYearController,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: InputFieldRow(
                labelText: "PV (Present Value)",
                hintText: "Enter PV (Present Value)",
                controller: presentValueController,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: InputFieldRow(
                labelText: "PMT (Periodic Payment)",
                hintText: "Enter PMT (Periodic Payment)",
                controller: periodicPaymentController,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: InputFieldRow(
                labelText: "FV (Future Value)	",
                hintText: "Enter FV (Future Value)	",
                controller: futureValueController,
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

                        String nterestPerYear = interestPerYearController.text;
                        String presentValue = presentValueController.text;

                        String periodicPayment = periodicPaymentController.text;
                        String futureValue = futureValueController.text;

                        if (nterestPerYear!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter Nterest PerYear",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        }
                        if (presentValue!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter present Value",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        }
                        if (periodicPayment!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter PMT periodic Payment",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        }

                        if (futureValue!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter Future Value",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        } else {
                          setState(() {
                            calculateFutureValue();
                            isLoading = true;
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
                        interestPerYearController.clear();
                        presentValueController.clear();
                        periodicPaymentController.clear();
                        futureValueController.clear();
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
                'Monthly Payment:\u{20B9}${futureValueResult}',
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

class PvCalculatorCard extends StatefulWidget {
  const PvCalculatorCard({super.key});
  @override
  State<PvCalculatorCard> createState() => _PvCalculatorCardState();
}

class _PvCalculatorCardState extends State<PvCalculatorCard> {
  final TextEditingController ofPeriodsController = TextEditingController();
  final TextEditingController interestPerYearController =
      TextEditingController();
  final TextEditingController periodicPaymentController =
      TextEditingController();
  final TextEditingController futureValueController = TextEditingController();
  bool isLoading = false;
  double? presentValue;

  void calculatePV() {
    setState(() {
      isLoading = true;
    });

    final int n = int.tryParse(ofPeriodsController.text) ?? 0;
    final double iY = (double.tryParse(interestPerYearController.text) ?? 0) / 100;
    final double pmt = double.tryParse(periodicPaymentController.text) ?? 0;
    final double fv = double.tryParse(futureValueController.text) ?? 0;

    // Present Value Calculation
    final double pv =
        (pmt * (1 - (1 / pow(1 + iY, n))) / iY) + (fv / pow(1 + iY, n));

    setState(() {
      presentValue = pv;
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
  void didUpdateWidget(covariant PvCalculatorCard oldWidget) {
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
                labelText: "N (# of periods)	",
                hintText: "Enter N (# of periods)",
                controller: ofPeriodsController,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: InputFieldRow(
                labelText: "I/Y (Interest per year)	",
                hintText: "Enter I/Y (Interest per year)",
                controller: interestPerYearController,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: InputFieldRow(
                labelText: "PMT (Periodic Payment)",
                hintText: "Enter PMT (Periodic Payment)",
                controller: periodicPaymentController,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: InputFieldRow(
                labelText: "FV (Future Value)	",
                hintText: "Enter FV (Future Value)	",
                controller: futureValueController,
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

                        String ofPeriods = ofPeriodsController.text;
                        String interestPerYear = interestPerYearController.text;

                        String periodicPayment = periodicPaymentController.text;
                        String futureValue = futureValueController.text;

                        if (ofPeriods!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter of Periods",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        }
                        if (interestPerYear!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter Interest PerYear",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        }
                        if (periodicPayment!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter PMT periodic Payment",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        }

                        if (futureValue!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter Future Value",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        } else {
                          setState(() {
                            calculatePV();
                            isLoading = true;
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
                        ofPeriodsController.clear();
                        interestPerYearController.clear();
                        periodicPaymentController.clear();
                        futureValueController.clear();
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
                'Monthly Payment:\u{20B9}${presentValue}',
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
