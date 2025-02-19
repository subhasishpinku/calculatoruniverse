import 'dart:async';
import 'dart:math';
import 'package:calculatoruniverse/InterestCalculator/InterestCalculator.dart';
import 'package:calculatoruniverse/InterestCalculator/component/CompoundRow.dart';
import 'package:calculatoruniverse/component/inputFieldRow.dart';
import 'package:calculatoruniverse/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RetirementCalculator extends StatefulWidget {
  const RetirementCalculator({super.key});

  @override
  State<RetirementCalculator> createState() => _RetirementCalculatorState();
}

class _RetirementCalculatorState extends State<RetirementCalculator> {
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
              'Retirement Calculator',
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
                  "This calculator can help with planning the financial aspects of your retirement, such as providing an idea where you stand in terms of retirement savings, how much to save to reach your target, and what your retrievals will look like in retiremen",
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
                      InterestCalculatorCard(),
                      SaveRetirementCard(),
                      YourMoneyLastCard(),
                      WithdrawAfterRetirementCard()
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

class InterestCalculatorCard extends StatefulWidget {
  const InterestCalculatorCard({super.key});
  @override
  State<InterestCalculatorCard> createState() => _InterestCalculatorCardState();
}

class _InterestCalculatorCardState extends State<InterestCalculatorCard> {
  final TextEditingController currentAgeController = TextEditingController();
  final TextEditingController plannedRetirementAgeController =
      TextEditingController();
  final TextEditingController lifeExpectancyController =
      TextEditingController();
  final TextEditingController currentPreTaxIncomeController =
      TextEditingController();
  final TextEditingController currentIncomeIncreaseController =
      TextEditingController();
  final TextEditingController incomeNeededAfterRetirementController =
      TextEditingController();
  final TextEditingController averageInvestmentReturnController =
      TextEditingController();
  final TextEditingController inflationRateController = TextEditingController();

  final TextEditingController otherIncomeAfterRetirementController =
      TextEditingController();
  final TextEditingController currentRetirementSavingsController =
      TextEditingController();
  final TextEditingController futureRetirementSavingsController =
      TextEditingController();

  String result = "";

  void calculateRetirementSavings() {
    try {
      // Input values
      int currentAge = int.parse(currentAgeController.text);
      int plannedRetirementAge = int.parse(plannedRetirementAgeController.text);
      int lifeExpectancy = int.parse(lifeExpectancyController.text);
      double currentPreTaxIncome =
          double.parse(currentPreTaxIncomeController.text);
      double currentIncomeIncrease =
          double.parse(currentIncomeIncreaseController.text) / 100;
      double incomeNeededAfterRetirement =
          double.parse(incomeNeededAfterRetirementController.text) / 100;
      double averageInvestmentReturn =
          double.parse(averageInvestmentReturnController.text) / 100;
      double inflationRate = double.parse(inflationRateController.text) / 100;
      double otherIncomeAfterRetirement =
          double.parse(otherIncomeAfterRetirementController.text);
      double currentRetirementSavings =
          double.parse(currentRetirementSavingsController.text);
      double futureRetirementSavings =
          double.parse(futureRetirementSavingsController.text) / 100;

      // Calculations
      int yearsUntilRetirement = plannedRetirementAge - currentAge;
      int yearsInRetirement = lifeExpectancy - plannedRetirementAge;

      // Projected income at retirement
      double projectedIncomeAtRetirement = currentPreTaxIncome *
          pow(1 + currentIncomeIncrease, yearsUntilRetirement);

      // Income needed after retirement per year
      double retirementIncomeNeededPerYear =
          projectedIncomeAtRetirement * incomeNeededAfterRetirement;

      // Adjust for inflation during retirement
      double inflationAdjustedIncomeNeeded = retirementIncomeNeededPerYear *
          ((pow(1 + inflationRate, yearsInRetirement) - 1) / inflationRate);

      // Total retirement savings required
      double totalSavingsNeeded = inflationAdjustedIncomeNeeded -
          (otherIncomeAfterRetirement * 12 * yearsInRetirement);

      // Savings growth over time
      double futureSavings = currentRetirementSavings *
              pow(1 + averageInvestmentReturn, yearsUntilRetirement) +
          (currentPreTaxIncome *
              futureRetirementSavings *
              (pow(1 + averageInvestmentReturn, yearsUntilRetirement) - 1) /
              averageInvestmentReturn);

      setState(() {
        result =
            "You will need \u{20B9}${totalSavingsNeeded.toStringAsFixed(2)} and you will have \$${futureSavings.toStringAsFixed(2)} by retirement.";
        startTimer();
        print("You will need \u{20B9}${result}");
      });
    } catch (e) {
      setState(() {
        result = "Please enter valid numbers for all fields.";
      });
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
      height: 1600,
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 380,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.blue, // Background color
                      padding: const EdgeInsets.all(
                          8.0), // Padding inside the background
                      child: const Text(
                        "How much do you need to retire?",
                        style: TextStyle(
                          color: Colors.white, // Text color
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: InputFieldRow(
                labelText: "Your current age",
                hintText: "Enter Your current age",
                controller: currentAgeController,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 0),
              child: InputFieldRow(
                labelText: "Your planned retirement age",
                hintText: "Enter Your planned retirement age",
                controller: plannedRetirementAgeController,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 0),
              child: InputFieldRow(
                labelText: "Your life expectancy",
                hintText: "Enter Your life expectancy",
                controller: lifeExpectancyController,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 0),
              child: InputFieldRow(
                labelText: "Your current pre-tax income",
                hintText: "Enter Your current pre-tax income",
                controller: currentPreTaxIncomeController,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 380,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.blue, // Background color
                      padding: const EdgeInsets.all(
                          8.0), // Padding inside the background
                      child: const Text(
                        "Assumptions",
                        style: TextStyle(
                          color: Colors.white, // Text color
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 0),
              child: InputFieldRow(
                labelText: "Your current income increase",
                hintText: "Enter Your current income increase",
                controller: currentIncomeIncreaseController,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 0),
              child: InputFieldRow(
                labelText: "Income needed after retirement",
                hintText: "Enter Income needed after retirement",
                controller: incomeNeededAfterRetirementController,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 0),
              child: InputFieldRow(
                labelText: "Average investment return",
                hintText: "Enter Average investment return",
                controller: averageInvestmentReturnController,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 0),
              child: InputFieldRow(
                labelText: "Inflation rate",
                hintText: "Enter Inflation rate",
                controller: inflationRateController,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 380,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.blue, // Background color
                      padding: const EdgeInsets.all(
                          8.0), // Padding inside the background
                      child: const Text(
                        "Optional",
                        style: TextStyle(
                          color: Colors.white, // Text color
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 0),
              child: InputFieldRow(
                labelText: "Other income after retirement",
                hintText: "Enter Other income after retirement",
                controller: otherIncomeAfterRetirementController,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 0),
              child: InputFieldRow(
                labelText: "Your current retirement savings",
                hintText: "Enter Your current retirement savings",
                controller: currentRetirementSavingsController,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 0),
              child: InputFieldRow(
                labelText: "Your Future retirement savings",
                hintText: "Enter Future retirement savings",
                controller: futureRetirementSavingsController,
              ),
            ),
            const SizedBox(
              height: 30,
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
                        String currentAge = currentAgeController.text;
                        String plannedRetirementAge =
                            plannedRetirementAgeController.text;
                        String lifeExpectancy = lifeExpectancyController.text;
                        String currentPreTaxIncome =
                            currentPreTaxIncomeController.text;
                        String currentIncomeIncrease =
                            currentIncomeIncreaseController.text;
                        String incomeNeededAfterRetirement =
                            incomeNeededAfterRetirementController.text;
                        String averageInvestmentReturn =
                            averageInvestmentReturnController.text!;
                        String inflationRate = inflationRateController.text!;
                        String otherIncomeAfterRetirement =
                            otherIncomeAfterRetirementController.text!;

                        String currentRetirementSavings =
                            currentRetirementSavingsController.text!;
                        String futureRetirementSavings =
                            futureRetirementSavingsController.text!;

                        if (currentAge!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter Current Age",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        } else if (plannedRetirementAge!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter  planned retirement age",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        } else if (lifeExpectancy!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter life expectancy",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        } else if (currentPreTaxIncome!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter current pre-tax income",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        } else if (currentIncomeIncrease!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter current income increase",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        } else if (incomeNeededAfterRetirement!
                            .trim()
                            .isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter ncome needed after retirement",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        } else if (averageInvestmentReturn!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter Average investment return",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        } else if (inflationRate!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter Inflation rate",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        } else if (otherIncomeAfterRetirement!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter Other income after retirement",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        } else if (currentRetirementSavings!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter current retirement savings",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        } else if (futureRetirementSavings!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter Future retirement savings",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        } else {
                          setState(() {
                            isLoading = true;
                            print("Loading started");
                            calculateRetirementSavings();
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
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${result}',
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SaveRetirementCard extends StatefulWidget {
  const SaveRetirementCard({super.key});
  @override
  State<SaveRetirementCard> createState() => _SaveRetirementCardState();
}

class _SaveRetirementCardState extends State<SaveRetirementCard> {
  final TextEditingController ageNowController = TextEditingController();
  final TextEditingController plannedRetirementAgeController =
      TextEditingController();
  final TextEditingController retirementSavingsNowController =
      TextEditingController();
  final TextEditingController averageInvestmentController =
      TextEditingController();
  final TextEditingController amountNeededController = TextEditingController();

  bool isLoading = false;
  String result = '';

  void calculateSavings() {
    final int currentAge = int.tryParse(ageNowController.text) ?? 0;
    final int retirementAge =
        int.tryParse(plannedRetirementAgeController.text) ?? 0;
    final double currentSavings =
        double.tryParse(retirementSavingsNowController.text) ?? 0.0;
    final double amountNeeded =
        double.tryParse(amountNeededController.text) ?? 0.0;
    final double averageReturn =
        double.tryParse(averageInvestmentController.text) ?? 0.0;

    final int yearsToInvest = retirementAge - currentAge;

    if (yearsToInvest <= 0) {
      setState(() {
        result = "Invalid input. Check the ages.";
      });
      return;
    }

    // Use pow function from dart:math
    final double annualContribution = (amountNeeded -
            currentSavings * pow(1 + averageReturn / 100, yearsToInvest)) /
        ((pow(1 + averageReturn / 100, yearsToInvest) - 1) /
            (averageReturn / 100));

    setState(() {
      result = annualContribution.isFinite
          ? "You need to save \$${annualContribution.toStringAsFixed(2)} per year."
          : "Calculation error. Check inputs.";
      startTimer();
    });
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
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 700,
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 380,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.blue, // Background color
                      padding: const EdgeInsets.all(
                          8.0), // Padding inside the background
                      child: const Text(
                        "How much can you withdraw after retirement?",
                        style: TextStyle(
                          color: Colors.white, // Text color
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: InputFieldRow(
                labelText: "Your age now",
                hintText: "Enter Your age now",
                controller: ageNowController,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 0),
              child: InputFieldRow(
                labelText: "Your planned retirement age",
                hintText: "Enter planned retirement age",
                controller: plannedRetirementAgeController,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 0),
              child: InputFieldRow(
                labelText: "Amount needed at the retirement age	",
                hintText: "Enter Amount needed at the retirement age	",
                controller: amountNeededController,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 0),
              child: InputFieldRow(
                labelText: "Your retirement savings now",
                hintText: "Enter retirement savings now",
                controller: retirementSavingsNowController,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 0),
              child: InputFieldRow(
                labelText: "Average investment return",
                hintText: "Enter Average investment",
                controller: averageInvestmentController,
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

                        String ageNow = ageNowController.text;
                        String plannedRetirementAge =
                            plannedRetirementAgeController.text;

                        String amountNeeded = amountNeededController.text;
                        String retirementSavingsNow =
                            retirementSavingsNowController.text;
                        String averageInvestment =
                            averageInvestmentController.text;

                        if (ageNow!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter Age Now",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        } else if (plannedRetirementAge!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter Planned Retirement Age",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        } else if (amountNeeded!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter Amount needed at the retirement age",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        } else if (retirementSavingsNow!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter Retirement Savings Now",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        } else if (averageInvestment!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter Average Investment",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        } else {
                          setState(() {
                            isLoading = true;
                            print("Loading started");
                            calculateSavings();
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
                        ageNowController.clear();
                        plannedRetirementAgeController.clear();
                        retirementSavingsNowController.clear();
                        averageInvestmentController.clear();
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${result}',
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class YourMoneyLastCard extends StatefulWidget {
  const YourMoneyLastCard({super.key});
  @override
  State<YourMoneyLastCard> createState() => _YourMoneyLastCardState();
}

class _YourMoneyLastCardState extends State<YourMoneyLastCard> {
  final TextEditingController amountYouHaveController = TextEditingController();
  final TextEditingController planToWithdrawController =
      TextEditingController();
  final TextEditingController averageInvestmentController =
      TextEditingController();

  String result = "";
  bool isLoading = false;
  void calculateDuration() {
    final double? amountYouHave = double.tryParse(amountYouHaveController.text);
    final double? planToWithdraw =
        double.tryParse(planToWithdrawController.text);
    final double? averageInvestmentReturn =
        double.tryParse(averageInvestmentController.text);

    if (amountYouHave == null ||
        planToWithdraw == null ||
        averageInvestmentReturn == null ||
        planToWithdraw <= 0) {
      setState(() {
        result = "Please enter valid numbers.";
      });
      return;
    }

    final double monthlyReturnRate = (averageInvestmentReturn / 100) / 12;
    int months = 0;
    double remainingBalance = amountYouHave;
    const int maxIterations = 1000; // Limit to avoid infinite loop

    while (remainingBalance > 0 && months < maxIterations) {
      remainingBalance += remainingBalance * monthlyReturnRate - planToWithdraw;

      // If the withdrawal exceeds the remaining balance, stop calculation
      if (remainingBalance < 0) break;

      months++;
    }

    setState(() {
      if (months >= maxIterations) {
        result = "Calculation exceeded limits. Please adjust inputs.";
      } else if (months > 0) {
        result =
            "Your money will last approximately ${months ~/ 12} years and ${months % 12} months.";
      } else {
        result =
            "Your money will not last even one month with the given parameters.";
      }
      startTimer();
    });
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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 380,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.blue, // Background color
                      padding: const EdgeInsets.all(
                          8.0), // Padding inside the background
                      child: const Text(
                        "How long can your money last?",
                        style: TextStyle(
                          color: Colors.white, // Text color
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: InputFieldRow(
                labelText: "The amount you have",
                hintText: "Enter amount you have",
                controller: amountYouHaveController,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 0),
              child: InputFieldRow(
                labelText: "You plan to withdraw",
                hintText: "Enter plan to withdraw",
                controller: planToWithdrawController,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 0),
              child: InputFieldRow(
                labelText: "Average investment return %",
                hintText: "Enter Average investment",
                controller: averageInvestmentController,
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

                        String amountYouHave = amountYouHaveController.text;
                        String planToWithdraw = planToWithdrawController.text;

                        String averageInvestment =
                            averageInvestmentController.text;

                        if (amountYouHave!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter The amount you have",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        } else if (planToWithdraw!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter You plan to withdraw",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        } else if (averageInvestment!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter Average investment return",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        } else {
                          setState(() {
                            isLoading = true;
                            print("Loading started");
                            calculateDuration();
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
                        amountYouHaveController.clear();
                        planToWithdrawController.clear();
                        averageInvestmentController.clear();
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${result}',
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WithdrawAfterRetirementCard extends StatefulWidget {
  const WithdrawAfterRetirementCard({super.key});
  @override
  State<WithdrawAfterRetirementCard> createState() =>
      _WithdrawAfterRetirementCardState();
}

class _WithdrawAfterRetirementCardState
    extends State<WithdrawAfterRetirementCard> {
  final TextEditingController yourAgeNowController = TextEditingController();
  final TextEditingController plannedRetirementAgeController =
      TextEditingController();
  final TextEditingController lifeExpectancyController =
      TextEditingController();

  final TextEditingController retirementSavingsTodayController =
      TextEditingController();
  final TextEditingController annualContributionController =
      TextEditingController();
  final TextEditingController monthlyContributionController =
      TextEditingController();
  final TextEditingController averageInvestmentController =
      TextEditingController();
  final TextEditingController inflationRateController = TextEditingController();

  String result = "";
  bool isLoading = false;
  double? monthlyWithdrawal;

    double? balanceAtRetirement;
  double? equivalentCurrentBalance;
  double? fixedPurchasingPowerWithdrawal;
  double? equivalentPurchasingPowerWithdrawal;
  double? fixedAmountWithdrawal;
  double? equivalentFixedWithdrawalAt67;
  double? equivalentFixedWithdrawalAt85;

  void calculateWithdrawal() {
    // Parse input values
    final int currentAge = int.tryParse(yourAgeNowController.text) ?? 0;
    final int retirementAge = int.tryParse(plannedRetirementAgeController.text) ?? 0;
    final int lifeExpectancy = int.tryParse(lifeExpectancyController.text) ?? 0;
    final double savingsToday = double.tryParse(retirementSavingsTodayController.text) ?? 0.0;
    final double annualContribution = double.tryParse(annualContributionController.text) ?? 0.0;
    final double monthlyContribution = double.tryParse(monthlyContributionController.text) ?? 0.0;
    final double investmentReturn = (double.tryParse(averageInvestmentController.text) ?? 0.0) / 100;
    final double inflationRate = (double.tryParse(inflationRateController.text) ?? 0.0) / 100;

    int yearsToRetirement = retirementAge - currentAge;
    int retirementYears = lifeExpectancy - retirementAge;

    // Calculate retirement savings at retirement age
    double futureSavings = savingsToday;
    for (int i = 0; i < yearsToRetirement; i++) {
      futureSavings += annualContribution;
      futureSavings += monthlyContribution * 12;
      futureSavings *= (1 + investmentReturn);
    }

    balanceAtRetirement = futureSavings;
    equivalentCurrentBalance = futureSavings / pow(1 + inflationRate, yearsToRetirement);

    // Fixed purchasing power withdrawal
    double inflationAdjustedMonthlyRate = (1 + investmentReturn) / (1 + inflationRate) - 1;
    fixedPurchasingPowerWithdrawal = futureSavings * inflationAdjustedMonthlyRate /
        (1 - (1 / pow(1 + inflationAdjustedMonthlyRate, retirementYears * 12)));
    equivalentPurchasingPowerWithdrawal = fixedPurchasingPowerWithdrawal! / pow(1 + inflationRate, yearsToRetirement);

    // Fixed amount withdrawal
    double monthlyRate = investmentReturn / 12;
    fixedAmountWithdrawal = futureSavings * monthlyRate /
        (1 - (1 / pow(1 + monthlyRate, retirementYears * 12)));
    equivalentFixedWithdrawalAt67 = fixedAmountWithdrawal! / pow(1 + inflationRate, yearsToRetirement);
    equivalentFixedWithdrawalAt85 = fixedAmountWithdrawal! / pow(1 + inflationRate, yearsToRetirement + retirementYears);

    setState(() {});
    startTimer();
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
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1300,
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 380,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.blue, // Background color
                      padding: const EdgeInsets.all(
                          8.0), // Padding inside the background
                      child: const Text(
                        "How much can you withdraw after retirement?",
                        style: TextStyle(
                          color: Colors.white, // Text color
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: InputFieldRow(
                labelText: "Your age now",
                hintText: "Enter Your age now",
                controller: yourAgeNowController,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 0),
              child: InputFieldRow(
                labelText: "Your planned retirement age",
                hintText: "Enter Your planned retirement age",
                controller: plannedRetirementAgeController,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 0),
              child: InputFieldRow(
                labelText: "Your life expectancy",
                hintText: "Enter Your life expectancy",
                controller: lifeExpectancyController,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 0),
              child: InputFieldRow(
                labelText: "Your retirement savings today",
                hintText: "Enter Your retirement savings today",
                controller: retirementSavingsTodayController,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 0),
              child: InputFieldRow(
                labelText: "Annual contribution",
                hintText: "Enter Annual contribution",
                controller: annualContributionController,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 0),
              child: InputFieldRow(
                labelText: "Monthly contribution",
                hintText: "Enter Monthly contribution",
                controller: monthlyContributionController,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 0),
              child: InputFieldRow(
                labelText: "Average investment return",
                hintText: "Enter Average investment return",
                controller: averageInvestmentController,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 0),
              child: InputFieldRow(
                labelText: "Inflation rate (annual)",
                hintText: "Enter Inflation rate (annual)",
                controller: inflationRateController,
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

                        String yourAgeNow = yourAgeNowController.text;
                        String plannedRetirementAge =
                            plannedRetirementAgeController.text;
                        String lifeExpectancy = lifeExpectancyController.text;
                        String retirementSavingsToday =
                            retirementSavingsTodayController.text;
                        String annualContribution =
                            annualContributionController.text;
                        String monthlyContribution =
                            monthlyContributionController.text;
                        String averageInvestment =
                            averageInvestmentController.text;
                        String inflationRate = inflationRateController.text;

                        if (yourAgeNow!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter Your age now	",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        } else if (plannedRetirementAge!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter Your planned retirement age	",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        } else if (lifeExpectancy!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter Your life expectancy	",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        } else if (retirementSavingsToday!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter Your retirement savings today	",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        } else if (annualContribution!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter Annual contribution	",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        } else if (monthlyContribution!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter Monthly contribution	",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        } else if (averageInvestment!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter Average investment return	",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        } else if (inflationRate!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter Inflation rate (annual)	",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        } else {
                          setState(() {
                            isLoading = true;
                            print("Loading started");
                            calculateWithdrawal();
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
                        yourAgeNowController.clear();
                        plannedRetirementAgeController.clear();
                        lifeExpectancyController.clear();
                        retirementSavingsTodayController.clear();
                        annualContributionController.clear();
                        monthlyContributionController.clear();
                        averageInvestmentController.clear();
                        inflationRateController.clear();
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
           if (balanceAtRetirement != null)
                Padding(
                  padding: const EdgeInsets.only(top: 20,left:20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Balance at retirement age: \u{20B9}${balanceAtRetirement!.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        'Equivalent to current purchasing power: \u{20B9}${equivalentCurrentBalance!.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        'Fixed purchasing power withdrawal: \u{20B9}${fixedPurchasingPowerWithdrawal!.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        'Equivalent to current purchasing power: \u{20B9}${equivalentPurchasingPowerWithdrawal!.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        'Fixed amount withdrawal: \u{20B9}${fixedAmountWithdrawal!.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        'At age 67, equivalent to current purchasing power: \u{20B9}${equivalentFixedWithdrawalAt67!.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        'At age 85, equivalent to current purchasing power: \u{20B9}${equivalentFixedWithdrawalAt85!.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
          ],
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';

// class InputFieldRow extends StatelessWidget {
//   final String labelText;
//   final String hintText;
//   final TextEditingController controller;

//   const InputFieldRow({
//     super.key,
//     required this.labelText,
//     required this.hintText,
//     required this.controller,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(top: 10),
//           child: Text(
//             labelText,
//             style: const TextStyle(
//               color: Colors.black,
//               fontWeight: FontWeight.bold,
//               fontSize: 16,
//             ),
//           ),
//         ),
//         const SizedBox(width: 16),
//         Expanded(
//           child: SizedBox(
//             height: 80,
//             child: TextField(
//               controller: controller,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 enabledBorder: const OutlineInputBorder(
//                   borderSide: BorderSide(
//                     color: Color.fromARGB(255, 136, 122, 122), // Replace AppColor.lightGrayColor
//                     width: 1.0,
//                   ),
//                 ),
//                 focusedBorder: const OutlineInputBorder(
//                   borderSide: BorderSide(
//                     color: Color(0xFFDDDDDD), // Replace AppColor.lightGrayColor
//                     width: 1.0,
//                   ),
//                 ),
//                 hintText: hintText,
//                 contentPadding: const EdgeInsets.symmetric(
//                   vertical: 10,
//                   horizontal: 16,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }