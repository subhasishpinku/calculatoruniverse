import 'dart:async';
import 'dart:math';

import 'package:calculatoruniverse/InterestCalculator/component/CompoundRow.dart';
import 'package:calculatoruniverse/component/inputFieldRow.dart';
import 'package:calculatoruniverse/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class InvestmentCalculator extends StatefulWidget {
  const InvestmentCalculator({super.key});

  @override
  State<InvestmentCalculator> createState() => _InvestmentCalculatorState();
}

class _InvestmentCalculatorState extends State<InvestmentCalculator> {
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
              'Investment Calculator',
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
                  "The Investment Calculator can be used to calculate a specific parameter for an investment plan. The tabs represent the desired parameter to be found. For example, to calculate the return rate needed to reach an investment goal with particular inputs, click the 'Return Rate' tab.",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: AppColor.defaultBlack,
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                  ),
                ),
              ),
              PaymentCalculatorCard(),
              PaymentCalculatorCards()
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
  final TextEditingController startingAmountController =
      TextEditingController();
  final TextEditingController afterController = TextEditingController();

  final TextEditingController returnRateController = TextEditingController();
  final TextEditingController compoundController = TextEditingController();
  final TextEditingController additionalContributionController =
      TextEditingController();
  String? compoundFrequency;
  String contributionTime = 'Beginning of Month';
  double futureValue = 0.0;
  String _contributeAt = 'end'; // Tracks radio button state
  String _timeFrame = 'month';
  @override
  void initState() {
    super.initState();
    compoundFrequency = 'annually';
  }

  void calculateFutureValue() {
    double startingAmount =
        double.tryParse(startingAmountController.text) ?? 0.0;
    int years = int.tryParse(afterController.text) ?? 0;
    double rate = (double.tryParse(returnRateController.text) ?? 0.0) / 100;
    double additionalContribution =
        double.tryParse(additionalContributionController.text) ?? 0.0;

    // Map compoundFrequency string to an integer value
    int compoundPeriods = _getCompoundPeriods(compoundFrequency!);
    if (_contributeAt == 'beginning') {
      bool contributeAtBeginning = _contributeAt == 'beginning';
      double effectiveRate = rate / compoundPeriods;
      int totalPeriods = years * compoundPeriods;

      double contributionMultiplier =
          contributeAtBeginning ? (1 + effectiveRate) : 1;
      double futureValueContributions = additionalContribution *
          contributionMultiplier *
          ((pow(1 + effectiveRate, totalPeriods) - 1) / effectiveRate);

      double futureValuePrincipal =
          startingAmount * pow(1 + effectiveRate, totalPeriods);
      setState(() {
        futureValue = futureValuePrincipal + futureValueContributions;
        print(futureValue);
      });
    } else if (_timeFrame == 'end of each') {
      bool contributeAtBeginning = _contributeAt == 'end of each';
      double effectiveRate = rate / compoundPeriods;
      int totalPeriods = years * compoundPeriods;

      double contributionMultiplier =
          contributeAtBeginning ? (1 + effectiveRate) : 1;
      double futureValueContributions = additionalContribution *
          contributionMultiplier *
          ((pow(1 + effectiveRate, totalPeriods) - 1) / effectiveRate);

      double futureValuePrincipal =
          startingAmount * pow(1 + effectiveRate, totalPeriods);
      setState(() {
        futureValue = futureValuePrincipal + futureValueContributions;
        print(futureValue);
      });
    } else if (_timeFrame == 'month') {
      bool contributeAtBeginning = _timeFrame == 'month';
      double effectiveRate = rate / compoundPeriods;
      int totalPeriods = years * compoundPeriods;

      double contributionMultiplier =
          contributeAtBeginning ? (1 + effectiveRate) : 1;
      double futureValueContributions = additionalContribution *
          contributionMultiplier *
          ((pow(1 + effectiveRate, totalPeriods) - 1) / effectiveRate);

      double futureValuePrincipal =
          startingAmount * pow(1 + effectiveRate, totalPeriods);
      setState(() {
        futureValue = futureValuePrincipal + futureValueContributions;
        print(futureValue);
      });
    } else if (_timeFrame == 'year') {
      bool contributeAtBeginning = _timeFrame == 'year';
      double effectiveRate = rate / compoundPeriods;
      int totalPeriods = years * compoundPeriods;

      double contributionMultiplier =
          contributeAtBeginning ? (1 + effectiveRate) : 1;
      double futureValueContributions = additionalContribution *
          contributionMultiplier *
          ((pow(1 + effectiveRate, totalPeriods) - 1) / effectiveRate);

      double futureValuePrincipal =
          startingAmount * pow(1 + effectiveRate, totalPeriods);
      setState(() {
        futureValue = futureValuePrincipal + futureValueContributions;
        print(futureValue);
      });
    }
  }
//

  final TextEditingController yourTargetController = TextEditingController();
  final TextEditingController startingAmountController1 =
      TextEditingController();
  final TextEditingController afterController1 = TextEditingController();
  final TextEditingController returnRateController1 = TextEditingController();
  final TextEditingController compoundController1 = TextEditingController();

  bool isLoading = false;
  double requiredContribution = 0.0;
  double totalContributions = 0.0;
  double totalInterest = 0.0;
  double endBalance = 0.0;

  void calculateRequiredContribution() {
    double target = double.tryParse(yourTargetController.text) ?? 0.0;
    double startingAmount =
        double.tryParse(startingAmountController1.text) ?? 0.0;
    int years = int.tryParse(afterController1.text) ?? 0;
    double rate = (double.tryParse(returnRateController1.text) ?? 0.0) / 100;

    int compoundPeriods = _getCompoundPeriods(compoundController1.text.trim());
    bool contributeAtBeginning = _contributeAt == 'beginning';

    if (target == 0 || rate == 0 || years == 0 || compoundPeriods == 0) {
      // Handle invalid input
      setState(() {
        requiredContribution = 0.0;
        totalContributions = 0.0;
        totalInterest = 0.0;
        endBalance = 0.0;
      });
      return;
    }

    double effectiveRate = rate / compoundPeriods;
    int totalPeriods = years * compoundPeriods;

    // Future value of the starting amount
    double futureValuePrincipal =
        startingAmount * pow(1 + effectiveRate, totalPeriods);

    // Contribution multiplier for timing adjustment
    double contributionMultiplier =
        contributeAtBeginning ? (1 + effectiveRate) : 1;

    // Future value needed from contributions
    double futureValueNeeded = target - futureValuePrincipal;

    if (futureValueNeeded > 0) {
      requiredContribution = futureValueNeeded /
          (contributionMultiplier *
              ((pow(1 + effectiveRate, totalPeriods) - 1) / effectiveRate));
    } else {
      requiredContribution = 0.0;
    }

    // Total contributions made over time
    totalContributions = requiredContribution * totalPeriods;

    // End balance is the target (future value)
    endBalance = target;

    // Total interest earned
    totalInterest = target - (startingAmount + totalContributions);

    setState(() {});
  }

  //
  final TextEditingController yourTargetController1 = TextEditingController();
  final TextEditingController startingAmountController2 =
      TextEditingController();
  final TextEditingController afterController2 = TextEditingController();
  final TextEditingController additionalContributionController1 =
      TextEditingController();
  int selectedMode = 0;

  double? requiredRate;

  void calculateRate() {
    final target = double.tryParse(yourTargetController1.text) ?? 0;
    final starting = double.tryParse(startingAmountController2.text) ?? 0;
    final years = int.tryParse(afterController2.text) ?? 0;
    final contribution =
        double.tryParse(additionalContributionController1.text) ?? 0;

    if (target <= 0 || starting <= 0 || years <= 0) {
      Fluttertoast.showToast(
        msg: "Please fill all fields with valid values",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return;
    }

    final periods = _timeFrame == "month" ? years * 12 : years;
    final tolerance = 1e-6;
    double low = 0.0;
    double high = 1.0;
    double rate = 0.0;

    while (high - low > tolerance) {
      rate = (low + high) / 2;
      double balance = starting;

      for (int i = 0; i < periods; i++) {
        balance *= (1 + rate / (_timeFrame == "month" ? 12 : 1));
        if (_contributeAt == "beginning") balance += contribution;
        if (_contributeAt == "end") balance += i > 0 ? contribution : 0;
      }

      if (balance > target) {
        high = rate;
      } else {
        low = rate;
      }
    }

    setState(() {
      requiredRate = rate * 100; // Convert to percentage
      print("rate $requiredRate");
    });
  }

  // Tracks second radio button state
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
        side: const BorderSide(color: AppColor.lightGrayColor),
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                3, // Number of modes
                (index) => Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: ElevatedButton(
                      onPressed: () => setState(() {
                        selectedMode = index;
                      }),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedMode == index
                            ? AppColor.primaryColor
                            : Colors.grey[300],
                        foregroundColor: Colors.white,
                        minimumSize: const Size(0, 40), // Minimum button size
                      ),
                      child: Text(
                        index == 0
                            ? "End Amount"
                            : index == 1
                                ? "Additional Contribution"
                                : "Return Rate",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (selectedMode == 0)
              buildEditAmount()
            else if (selectedMode == 1)
              buildAdditionalContribution()
            else
              buildReturnRate(),
          ],
        ),
      ),
    );
  }

  buildEditAmount() {
    yourTargetController.clear();
    startingAmountController1.clear();
    afterController1.clear();
    returnRateController1.clear();
    //
    yourTargetController1.clear();
    startingAmountController2.clear();
    afterController2.clear();
    additionalContributionController1.clear();
    return buildEditAmountLayout();
  }

  buildAdditionalContribution() {
    startingAmountController.clear();
    afterController.clear();
    returnRateController.clear();
    additionalContributionController.clear();
    //
    yourTargetController1.clear();
    startingAmountController2.clear();
    afterController2.clear();
    additionalContributionController1.clear();
    return buildAdditionalContributionLayout();
  }

  buildReturnRate() {
    yourTargetController1.clear();
    startingAmountController2.clear();
    afterController2.clear();
    additionalContributionController1.clear();
    return buildReturnRateLayout();
  }

  Widget buildEditAmountLayout() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            InputFieldRow(
              labelText: "Starting Amount",
              hintText: "Enter Starting Amount",
              controller: startingAmountController,
            ),
            const SizedBox(height: 20),
            InputFieldRow(
              labelText: "After",
              hintText: "Enter After",
              controller: afterController,
            ),
            const SizedBox(height: 20),
            InputFieldRow(
              labelText: "Return Rate",
              hintText: "Enter Return Rate",
              controller: returnRateController,
            ),
            const SizedBox(height: 20),
            // InputFieldRow(
            //   labelText: "Compound",
            //   hintText: "Enter Compound",
            //   controller: compoundController,
            // ),
            CompoundRow(
              controller: compoundController,
              selectedValue: compoundFrequency,
              onValueChanged: (value) {
                setState(() {
                  compoundFrequency = value;
                  // _controller.text = value!;
                });
              },
            ),
            const SizedBox(height: 20),
            InputFieldRow(
              labelText: "Additional Contribution",
              hintText: "Enter Additional Contribution",
              controller: additionalContributionController,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Contribute at the:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'beginning',
                        groupValue: _contributeAt,
                        onChanged: (value) {
                          setState(() {
                            _contributeAt = value!;
                          });
                        },
                      ),
                      const Text('beginning'),
                      Radio<String>(
                        value: 'end',
                        groupValue: _contributeAt,
                        onChanged: (value) {
                          setState(() {
                            _contributeAt = value!;
                          });
                        },
                      ),
                      const Text('end of each'),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'month',
                        groupValue: _timeFrame,
                        onChanged: (value) {
                          setState(() {
                            _timeFrame = value!;
                          });
                        },
                      ),
                      const Text('month'),
                      Radio<String>(
                        value: 'year',
                        groupValue: _timeFrame,
                        onChanged: (value) {
                          setState(() {
                            _timeFrame = value!;
                          });
                        },
                      ),
                      const Text('year'),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: 50,
                  width: 140,
                  child: GestureDetector(
                    onTap: () async {
                      // Show the loader
                      String startingAmount = startingAmountController.text;
                      String after = afterController.text;
                      String returnRate = returnRateController.text;
                      String additional = additionalContributionController.text;
                      if (startingAmount!.trim().isEmpty) {
                        Fluttertoast.showToast(
                          msg: "Enter starting Amount",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          backgroundColor: AppColor.black,
                          textColor: AppColor.defaultWhite,
                        );
                      } else if (after!.trim().isEmpty) {
                        Fluttertoast.showToast(
                          msg: "Enter After",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          backgroundColor: AppColor.black,
                          textColor: AppColor.defaultWhite,
                        );
                      } else if (returnRate!.trim().isEmpty) {
                        Fluttertoast.showToast(
                          msg: "Enter return Rate",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          backgroundColor: AppColor.black,
                          textColor: AppColor.defaultWhite,
                        );
                      } else if (additional!.trim().isEmpty) {
                        Fluttertoast.showToast(
                          msg: "Enter Additional",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          backgroundColor: AppColor.black,
                          textColor: AppColor.defaultWhite,
                        );
                      } else {
                        calculateFutureValue();
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
                      startingAmountController.clear();
                      afterController.clear();
                      returnRateController.clear();
                      additionalContributionController.clear();
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Future Value: \$${futureValue}",
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAdditionalContributionLayout() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            InputFieldRow(
              labelText: "Your Target",
              hintText: "Enter Your Target",
              controller: yourTargetController,
            ),
            InputFieldRow(
              labelText: "Starting Amount	",
              hintText: "Enter Starting Amount",
              controller: startingAmountController1,
            ),
            InputFieldRow(
              labelText: "After",
              hintText: "Enter After",
              controller: afterController1,
            ),
            const SizedBox(height: 20),
            InputFieldRow(
              labelText: "Return Rate",
              hintText: "Enter Return Rate",
              controller: returnRateController1,
            ),
            const SizedBox(height: 20),
            // InputFieldRow(
            //   labelText: "Compound",
            //   hintText: "Enter Compound",
            //   controller: compoundController1,
            // ),
            CompoundRow(
              controller: compoundController,
              selectedValue: compoundFrequency,
              onValueChanged: (value) {
                setState(() {
                  compoundFrequency = value;
                  // _controller.text = value!;
                });
              },
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Contribute at the:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'beginning',
                        groupValue: _contributeAt,
                        onChanged: (value) {
                          setState(() {
                            _contributeAt = value!;
                          });
                        },
                      ),
                      const Text('beginning'),
                      Radio<String>(
                        value: 'end',
                        groupValue: _contributeAt,
                        onChanged: (value) {
                          setState(() {
                            _contributeAt = value!;
                          });
                        },
                      ),
                      const Text('end of each'),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'month',
                        groupValue: _timeFrame,
                        onChanged: (value) {
                          setState(() {
                            _timeFrame = value!;
                          });
                        },
                      ),
                      const Text('month'),
                      Radio<String>(
                        value: 'year',
                        groupValue: _timeFrame,
                        onChanged: (value) {
                          setState(() {
                            _timeFrame = value!;
                          });
                        },
                      ),
                      const Text('year'),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: 50,
                  width: 140,
                  child: GestureDetector(
                    onTap: () async {
                      // Show the loader
                      String yourTarget = yourTargetController.text;
                      String startingAmount = startingAmountController1.text;
                      String after = afterController1.text;
                      String returnRate = returnRateController1.text;
                      if (yourTarget!.trim().isEmpty) {
                        Fluttertoast.showToast(
                          msg: "Enter your Target",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          backgroundColor: AppColor.black,
                          textColor: AppColor.defaultWhite,
                        );
                      } else if (startingAmount!.trim().isEmpty) {
                        Fluttertoast.showToast(
                          msg: "Enter Starting Amount",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          backgroundColor: AppColor.black,
                          textColor: AppColor.defaultWhite,
                        );
                      } else if (after!.trim().isEmpty) {
                        Fluttertoast.showToast(
                          msg: "Enter After",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          backgroundColor: AppColor.black,
                          textColor: AppColor.defaultWhite,
                        );
                      } else if (returnRate!.trim().isEmpty) {
                        Fluttertoast.showToast(
                          msg: "Enter Return Rate",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          backgroundColor: AppColor.black,
                          textColor: AppColor.defaultWhite,
                        );
                      } else {
                        calculateRequiredContribution();
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
                    onTap: () async {},
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'End Balance: \$${endBalance.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Starting Amount: \$${startingAmountController1.text}',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'Total Contributions: \$${totalContributions.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'Total Interest: \$${totalInterest.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildReturnRateLayout() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            InputFieldRow(
              labelText: "Your Target",
              hintText: "Enter Your Target",
              controller: yourTargetController1,
            ),
            InputFieldRow(
              labelText: "Starting Amount	",
              hintText: "Enter Starting Amount",
              controller: startingAmountController2,
            ),
            InputFieldRow(
              labelText: "After",
              hintText: "Enter After",
              controller: afterController2,
            ),
            const SizedBox(height: 20),
            InputFieldRow(
              labelText: "Additional Contribution	",
              hintText: "Enter Additional Contribution	",
              controller: additionalContributionController1,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Contribute at the:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'beginning',
                        groupValue: _contributeAt,
                        onChanged: (value) {
                          setState(() {
                            _contributeAt = value!;
                          });
                        },
                      ),
                      const Text('beginning'),
                      Radio<String>(
                        value: 'end',
                        groupValue: _contributeAt,
                        onChanged: (value) {
                          setState(() {
                            _contributeAt = value!;
                          });
                        },
                      ),
                      const Text('end of each'),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'month',
                        groupValue: _timeFrame,
                        onChanged: (value) {
                          setState(() {
                            _timeFrame = value!;
                          });
                        },
                      ),
                      const Text('month'),
                      Radio<String>(
                        value: 'year',
                        groupValue: _timeFrame,
                        onChanged: (value) {
                          setState(() {
                            _timeFrame = value!;
                          });
                        },
                      ),
                      const Text('year'),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: 50,
                  width: 140,
                  child: GestureDetector(
                    onTap: () async {
                      String yourTarget = yourTargetController1.text;
                      String startingAmount = startingAmountController2.text;
                      String after = afterController2.text;
                      String additionalContribution =
                          additionalContributionController1.text;
                      if (yourTarget!.trim().isEmpty) {
                        Fluttertoast.showToast(
                          msg: "Enter your Target",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          backgroundColor: AppColor.black,
                          textColor: AppColor.defaultWhite,
                        );
                      } else if (startingAmount!.trim().isEmpty) {
                        Fluttertoast.showToast(
                          msg: "Enter Starting Amount",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          backgroundColor: AppColor.black,
                          textColor: AppColor.defaultWhite,
                        );
                      } else if (after!.trim().isEmpty) {
                        Fluttertoast.showToast(
                          msg: "Enter After",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          backgroundColor: AppColor.black,
                          textColor: AppColor.defaultWhite,
                        );
                      } else if (additionalContribution!.trim().isEmpty) {
                        Fluttertoast.showToast(
                          msg: "Enter Additional Contribution",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          backgroundColor: AppColor.black,
                          textColor: AppColor.defaultWhite,
                        );
                      } else {
                        calculateRate();
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
                      yourTargetController1.clear();
                      startingAmountController2.clear();
                      afterController2.clear();
                      additionalContributionController1.clear();
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Required Rate: \$${requiredRate}",
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  int _getCompoundPeriods(String frequency) {
    switch (frequency.toLowerCase()) {
      case 'monthly':
        return 12;
      case 'quarterly':
        return 4;
      case 'annually':
      default:
        return 1;
    }
  }
}

class PaymentCalculatorCards extends StatefulWidget {
  const PaymentCalculatorCards({super.key});
  @override
  State<PaymentCalculatorCards> createState() => _PaymentCalculatorCardsState();
}

class _PaymentCalculatorCardsState extends State<PaymentCalculatorCards> {
  final TextEditingController yourTargetController3 = TextEditingController();
  final TextEditingController afterController3 = TextEditingController();
  final TextEditingController returnRateController3 = TextEditingController();
  final TextEditingController additionalContributionController3 =
      TextEditingController();
  final TextEditingController compoundController3 = TextEditingController();
  String? compoundFrequency;
  bool isLoading = false;
  int selectedMode = 0;
  String _contributeAt = 'end'; // Tracks radio button state
  String _timeFrame = 'month';
  // Tracks second radio button state

  // String? compoundFrequency = "annually"; // Default to annually
  String contributeAt = "end"; // Default to contributions at the end
  double? requiredStartingAmount;
  void calculateInitialInvestment() {
    // Parse inputs
    final target = double.tryParse(yourTargetController3.text) ?? 0;
    final years = int.tryParse(afterController3.text) ?? 0;
    final rate = double.tryParse(returnRateController3.text) ?? 0;
    final additionalContribution =
        double.tryParse(additionalContributionController3.text) ?? 0;

    // Validate inputs
    if (target <= 0 || years <= 0 || rate <= 0) {
      Fluttertoast.showToast(
        msg: "Please fill all fields with valid values",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      setState(() {
        requiredStartingAmount = 0.0;
      });
      return;
    }

    int periods;
    double ratePerPeriod;

    // Determine compound frequency
    switch (compoundFrequency) {
      case "monthly":
        periods = years * 12;
        ratePerPeriod = rate / 12 / 100;
        break;
      case "quarterly":
        periods = years * 4;
        ratePerPeriod = rate / 4 / 100;
        break;
      case "semi-annually":
        periods = years * 2;
        ratePerPeriod = rate / 2 / 100;
        break;
      case "annually":
      default:
        periods = years;
        ratePerPeriod = rate / 100;
    }

    // Log inputs for debugging
    print("Inputs:");
    print("Target: $target");
    print("Years: $years");
    print("Rate: $rate");
    print("Additional Contribution: $additionalContribution");
    print("Compound Frequency: $compoundFrequency");
    print("Periods: $periods");
    print("Rate per Period: $ratePerPeriod");

    try {
      // Calculate future value factor
      final futureValueFactor = pow(1 + ratePerPeriod, periods).toDouble();
      print("Future Value Factor: $futureValueFactor");

      // Calculate contribution factor
      final contributionFactor = (_contributeAt == "beginning")
          ? ((1 + ratePerPeriod) * (futureValueFactor - 1) / ratePerPeriod)
          : ((futureValueFactor - 1) / ratePerPeriod);
      print("Contribution Factor: $contributionFactor");

      // Prevent division by zero or negative future value
      if (futureValueFactor == 0) {
        Fluttertoast.showToast(
          msg: "Calculation error: future value factor is zero",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
        setState(() {
          requiredStartingAmount = 0.0;
        });
        return;
      }

      // Calculate starting amount
      final startingAmount =
          (target - (additionalContribution * contributionFactor)) /
              futureValueFactor;

      // Update state
      setState(() {
        requiredStartingAmount = startingAmount > 0 ? startingAmount : 0;
        print("Calculated Starting Amount: $requiredStartingAmount");
      });
    } catch (e) {
      // Handle errors
      Fluttertoast.showToast(
        msg: "Error in calculation: ${e.toString()}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      print("Error in calculation: ${e.toString()}");
      setState(() {
        requiredStartingAmount = 0.0;
      });
    }
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
        side: const BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                2, // Number of modes
                (index) => Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: ElevatedButton(
                      onPressed: () => setState(() {
                        selectedMode = index;
                      }),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedMode == index
                            ? AppColor.primaryColor
                            : Colors.grey[300],
                        foregroundColor:
                            selectedMode == index ? Colors.white : Colors.black,
                        minimumSize: const Size(0, 40),
                      ),
                      child: Text(
                        index == 0 ? "Starting Amount" : "Investment Length",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (selectedMode == 0) buildStartingAmount(),
            if (selectedMode == 1) buildInvestmentLength(),
          ],
        ),
      ),
    );
  }

  Widget buildStartingAmount() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            InputFieldRow(
              labelText: "Your Target",
              hintText: "Enter Your Target",
              controller: yourTargetController3,
            ),
            const SizedBox(height: 20),
            InputFieldRow(
              labelText: "After",
              hintText: "Enter After",
              controller: afterController3,
            ),
            const SizedBox(height: 20),
            InputFieldRow(
              labelText: "Return Rate",
              hintText: "Enter Return Rate",
              controller: returnRateController3,
            ),
            const SizedBox(height: 20),
            CompoundRow(
              controller: compoundController3,
              selectedValue: compoundFrequency,
              onValueChanged: (value) {
                setState(() {
                  compoundFrequency = value;
                  // _controller.text = value!;
                });
              },
            ),
            // InputFieldRow(
            //   labelText: "Compound",
            //   hintText: "Enter Compound",
            //   controller: interestRateController,
            // ),
            const SizedBox(height: 20),
            InputFieldRow(
              labelText: "Additional Contribution",
              hintText: "Enter Additional Contribution",
              controller: additionalContributionController3,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Contribute at the:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'beginning',
                        groupValue: _contributeAt,
                        onChanged: (value) {
                          setState(() {
                            _contributeAt = value!;
                          });
                        },
                      ),
                      const Text('beginning'),
                      Radio<String>(
                        value: 'end',
                        groupValue: _contributeAt,
                        onChanged: (value) {
                          setState(() {
                            _contributeAt = value!;
                          });
                        },
                      ),
                      const Text('end of each'),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'month',
                        groupValue: _timeFrame,
                        onChanged: (value) {
                          setState(() {
                            _timeFrame = value!;
                          });
                        },
                      ),
                      const Text('month'),
                      Radio<String>(
                        value: 'year',
                        groupValue: _timeFrame,
                        onChanged: (value) {
                          setState(() {
                            _timeFrame = value!;
                          });
                        },
                      ),
                      const Text('year'),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: 50,
                  width: 140,
                  child: GestureDetector(
                    onTap: () async {
                      calculateInitialInvestment();
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
                      yourTargetController3.clear();
                      afterController3.clear();
                      returnRateController3.clear();
                      compoundController3.clear();
                      additionalContributionController3.clear();
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Required Rate: \$${requiredStartingAmount}",
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInvestmentLength() {
    yourTargetController3.clear();
    afterController3.clear();
    returnRateController3.clear();
    compoundController3.clear();
    additionalContributionController3.clear();
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            InputFieldRow(
              labelText: "Your Target",
              hintText: "Enter Starting Amount",
              controller: yourTargetController3,
            ),
            const SizedBox(height: 20),
            InputFieldRow(
              labelText: "Starting Amount",
              hintText: "Enter After",
              controller: afterController3,
            ),
            const SizedBox(height: 20),
            InputFieldRow(
              labelText: "Return Rate",
              hintText: "Enter Return Rate",
              controller: returnRateController3,
            ),
            const SizedBox(height: 20),
            InputFieldRow(
              labelText: "Compound",
              hintText: "Enter Compound",
              controller: additionalContributionController3,
            ),
            const SizedBox(height: 20),
            InputFieldRow(
              labelText: "Additional Contribution",
              hintText: "Enter Additional Contribution",
              controller: additionalContributionController3,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Contribute at the:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'beginning',
                        groupValue: _contributeAt,
                        onChanged: (value) {
                          setState(() {
                            _contributeAt = value!;
                          });
                        },
                      ),
                      const Text('beginning'),
                      Radio<String>(
                        value: 'end',
                        groupValue: _contributeAt,
                        onChanged: (value) {
                          setState(() {
                            _contributeAt = value!;
                          });
                        },
                      ),
                      const Text('end of each'),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'month',
                        groupValue: _timeFrame,
                        onChanged: (value) {
                          setState(() {
                            _timeFrame = value!;
                          });
                        },
                      ),
                      const Text('month'),
                      Radio<String>(
                        value: 'year',
                        groupValue: _timeFrame,
                        onChanged: (value) {
                          setState(() {
                            _timeFrame = value!;
                          });
                        },
                      ),
                      const Text('year'),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: 50,
                  width: 140,
                  child: GestureDetector(
                    onTap: () async {
                      // Show the loader
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
          ],
        ),
      ),
    );
  }
}
