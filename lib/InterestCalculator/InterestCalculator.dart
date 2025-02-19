import 'dart:async';
import 'dart:math';

import 'package:calculatoruniverse/InterestCalculator/component/CompoundRow.dart';
import 'package:calculatoruniverse/component/inputFieldRow.dart';
import 'package:calculatoruniverse/constants/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../screens/AutoLoan/component/StateRow.dart';

class InterestCalculator extends StatefulWidget {
  const InterestCalculator({super.key});

  @override
  State<InterestCalculator> createState() => _InterestCalculatorState();
}

class _InterestCalculatorState extends State<InterestCalculator> {
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
              'Interest Calculator',
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
                  "This Compound Interest Calculator can help determine the compound interest accumulation and final balances on both fixed principal amounts and additional periodic contributions. There are also optional factors available for consideration, such as the tax on interest income and inflation.",
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
                      LoanDetailCardResult()
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
  final TextEditingController initalInvesmentController =
      TextEditingController();
  final TextEditingController annualContributionController =
      TextEditingController();
  final TextEditingController monthlyContributionController =
      TextEditingController();
  final TextEditingController interestRateController = TextEditingController();
  final TextEditingController compoundController = TextEditingController();
  final TextEditingController investmentController = TextEditingController();
  final TextEditingController taxRateController = TextEditingController();
  final TextEditingController inflationRateController = TextEditingController();

  final TextEditingController loanYearsController = TextEditingController();
  final TextEditingController loanMonthsController = TextEditingController();
  String? _selectedValue;
  double monthlyPayment = 0.0;
  double totalLoanAmount = 0.0;
  double totalInterest = 0.0;
  double totalCost = 0.0;
  bool isLoading = false;
  late Map<String, double> results;
  String endingBalance = "0.0";
  String totalPrincipal = "0.0";
  String totalContributions = "0.0";
  String totalInterests = "0.0";
  String interestofInitialInvestment = "0.0";
  String interestofContributions = "0.0";
  String buyingPowerAfterInflation = "0.0";
  double calculateInterest(
    String initialInvestment,
    String annual,
    String monthly,
    String interestRate,
    int compoundValue,
    String loanYear,
    String loanMonth,
    String taxRate,
    String inflationRate,
  ) {
    // Parse input strings to double and int where required
    double initialInvestmentValue = double.parse(initialInvestment);
    double annualContribution = double.parse(annual);
    double monthlyContribution = double.parse(monthly);
    double interestRateValue = double.parse(interestRate);
    int loanYears = int.parse(loanYear);
    int loanMonths = int.parse(loanMonth);
    double taxRateValue = double.parse(taxRate);
    double inflationRateValue = double.parse(inflationRate);

    // Total investment period in months
    int totalMonths = loanYears * 12 + loanMonths;

    // Future value starts with the initial investment
    double futureValue = initialInvestmentValue;

    // Calculate periodic rate or handle continuous compounding
    double periodicRate = compoundValue > 0
        ? interestRateValue / (compoundValue * 100)
        : interestRateValue / 100;

    // Total compounding periods
    int totalCompoundingPeriods =
        compoundValue > 0 ? (totalMonths / (12 / compoundValue)).floor() : 0;

    // Continuous compounding formula
    if (compoundValue == -1) {
      futureValue *=
          exp(interestRateValue / 100 * (loanYears + (loanMonths / 12)));
    } else {
      // Regular compound interest for initial investment
      futureValue *= pow(1 + periodicRate, totalCompoundingPeriods);
    }

    // Handle contributions (annual and monthly)
    double totalContributions = 0;
    for (int i = 0; i < totalCompoundingPeriods; i++) {
      double contribution = annualContribution / 12 + monthlyContribution;
      totalContributions += contribution;

      if (compoundValue == -1) {
        // Continuous compounding for contributions
        futureValue += contribution *
            exp(interestRateValue /
                100 *
                (totalMonths - (i * (12 / compoundValue))) /
                12);
      } else {
        // Regular compounding for contributions
        futureValue +=
            contribution * pow(1 + periodicRate, totalCompoundingPeriods - i);
      }
    }

    // Calculate total interest and apply taxes
    double totalInterest =
        futureValue - initialInvestmentValue - totalContributions;
    double taxedInterest = totalInterest * (1 - taxRateValue / 100);
    double finalBalance =
        initialInvestmentValue + totalContributions + taxedInterest;

    // Adjust for inflation
    double inflationAdjustmentFactor =
        pow(1 + inflationRateValue / 100, loanYears + (loanMonths / 12))
            as double;
    double inflationAdjustedBalance = finalBalance / inflationAdjustmentFactor;
    startTimer();
    return inflationAdjustedBalance;
  }

  Map<String, double> calculateInterest1({
    required double initialInvestment,
    required double annualContribution,
    required double interestRate,
    required int compoundValue,
    required int loanYears,
    required double inflationRate,
    required int loanMonth, // Adding loanMonth
  }) {
    // Total months in the investment period, considering both years and additional months
    int totalMonths = loanYears * 12 + loanMonth;

    // Initial investment future value
    double periodicRate = interestRate / (compoundValue * 100);
    int totalCompoundingPeriods = compoundValue * loanYears;
    double futureValueOfInitial =
        initialInvestment * pow(1 + periodicRate, totalCompoundingPeriods);

    // Contributions future value
    double futureValueOfContributions = 0;
    for (int i = 1; i <= loanYears; i++) {
      futureValueOfContributions += annualContribution *
          pow(1 + periodicRate, totalCompoundingPeriods - (i * compoundValue));
    }

    // Total future value (Ending balance)
    double endingBalance = futureValueOfInitial + futureValueOfContributions;

    // Total interest earned
    double totalContributions = annualContribution * loanYears;
    double totalPrincipal = initialInvestment + totalContributions;
    double totalInterest = endingBalance - totalPrincipal;

    // Breakdown of interest
    double interestOfInitialInvestment =
        futureValueOfInitial - initialInvestment;
    double interestOfContributions =
        totalInterest - interestOfInitialInvestment;

    // Inflation adjustment
    double inflationAdjustmentFactor =
        pow(1 + inflationRate / 100, loanYears).toDouble();
    double buyingPowerAfterInflation =
        endingBalance / inflationAdjustmentFactor;

    return {
      "Ending Balance": endingBalance,
      "Total Principal": totalPrincipal,
      "Total Contributions": totalContributions,
      "Total Interest": totalInterest,
      "Interest of Initial Investment": interestOfInitialInvestment,
      "Interest of Contributions": interestOfContributions,
      "Buying Power After Inflation": buyingPowerAfterInflation,
    };
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
    _selectedValue = 'annually';
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1000,
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
                labelText: "Initial investment",
                hintText: "Enter investment",
                controller: initalInvesmentController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 0),
              child: InputFieldRow(
                labelText: "Annual contribution",
                hintText: "Enter contribution",
                controller: annualContributionController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 0),
              child: InputFieldRow(
                labelText: "Monthly contribution",
                hintText: "Enter contribution",
                controller: monthlyContributionController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 0),
              child: InputFieldRow(
                labelText: "Interest rate",
                hintText: "Enter rate",
                controller: interestRateController,
              ),
            ),
            CompoundRow(
              controller: compoundController,
              selectedValue: _selectedValue,
              onValueChanged: (value) {
                setState(() {
                  _selectedValue = value;
                  // _controller.text = value!;
                });
              },
            ),
            const SizedBox(
              height: 20,
            ),
            LoanTermRow(
              yearsController: loanYearsController,
              monthsController: loanMonthsController,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 0),
              child: InputFieldRow(
                labelText: "Tax rate",
                hintText: "Enter Tax rate",
                controller: taxRateController,
              ),
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

                        String initialInvestment =
                            initalInvesmentController.text;
                        String annual = annualContributionController.text;
                        String monthly = monthlyContributionController.text;
                        String interestRate = interestRateController.text;
                        String compound = compoundController.text;
                        String investment = investmentController.text;
                        String taxRate = taxRateController.text!;
                        String inflationRate = inflationRateController.text!;
                        String loanYear = loanYearsController.text!;
                        String loanMonth = loanMonthsController.text!;

                        if (initialInvestment!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter Invesment",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        } else if (annual!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter Annual",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        } else if (monthly!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter Monthly",
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
                        } else if (loanYear!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter Loan Year",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        } else if (loanMonth!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter Month",
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
                          int compoundValue = getCompoundValue(_selectedValue!);
                          print(
                              "compoundValue Value: $compoundValue $_selectedValue");
                          // calculateInterest(
                          //   initialInvestment,
                          //   annual,
                          //   monthly,
                          //   interestRate,
                          //   compoundValue,
                          //   loanYear,
                          //   loanMonth,
                          //   taxRate,
                          //   inflationRate,
                          // );
                          double result = calculateInterest(
                            initialInvestment, // Initial investment as a string
                            annual, // Annual contribution as a string
                            monthly, // Monthly contribution as a string
                            interestRate, // Interest rate as a string
                            compoundValue, // Compounding frequency (e.g., semiannually)
                            loanYear, // Loan years as a string
                            loanMonth, // Loan months as a string
                            taxRate, // Tax rate as a string
                            inflationRate, // Inflation rate as a string
                          );

                          print(
                              "Inflation-adjusted balance: \$${result.toStringAsFixed(2)}");
                          // Convert strings to required data types
                          double initialInvestments =
                              double.parse(initialInvestment);
                          double annuals = double.parse(annual);
                          double interestRates = double.parse(interestRate);
                          int loanYears = int.parse(loanYear);
                          double inflationRates = double.parse(inflationRate);
                          int loanMonths = int.parse(loanMonth);
                          results = calculateInterest1(
                            initialInvestment: initialInvestments,
                            annualContribution: annuals,
                            interestRate: interestRates,
                            compoundValue: compoundValue,
                            loanYears: loanYears,
                            loanMonth: loanMonths,
                            inflationRate: inflationRates,
                          );
                          endingBalance =
                              results["Ending Balance"]!.toStringAsFixed(2);
                          totalPrincipal =
                              results["Total Principal"]!.toStringAsFixed(2);
                          totalContributions = results["Total Contributions"]!
                              .toStringAsFixed(2);
                          totalInterests =
                              results["Total Interest"]!.toStringAsFixed(2);
                          interestofInitialInvestment =
                              results["Interest of Initial Investment"]!
                                  .toStringAsFixed(2);
                          interestofContributions =
                              results["Interest of Contributions"]!
                                  .toStringAsFixed(2);
                          buyingPowerAfterInflation =
                              results["Buying Power After Inflation"]!
                                  .toStringAsFixed(2);
                          // Print the results
                          print(
                              "Ending Balance: \$${results["Ending Balance"]!.toStringAsFixed(2)}");
                          print(
                              "Total Principal: \$${results["Total Principal"]!.toStringAsFixed(2)}");
                          print(
                              "Total Contributions: \$${results["Total Contributions"]!.toStringAsFixed(2)}");
                          print(
                              "Total Interest: \$${results["Total Interest"]!.toStringAsFixed(2)}");
                          print(
                              "Interest of Initial Investment: \$${results["Interest of Initial Investment"]!.toStringAsFixed(2)}");
                          print(
                              "Interest of Contributions: \$${results["Interest of Contributions"]!.toStringAsFixed(2)}");
                          print(
                              "Buying Power After Inflation: \$${results["Buying Power After Inflation"]!.toStringAsFixed(2)}");
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
                        initalInvesmentController.clear();
                        annualContributionController.clear();
                        monthlyContributionController.clear();
                        interestRateController.clear();
                        compoundController.clear();
                        investmentController.clear();
                        taxRateController.clear();
                        inflationRateController.clear();
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
            
              children: [
                Text(
                  "Ending Balance: \$${endingBalance}",
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Total Principal: \$${totalPrincipal}",
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Total Contributions: \$${totalContributions}",
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Total Interest: \$${totalInterests}",
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Interest of Initial Investment: \$${interestofInitialInvestment}",
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Interest of Contributions: \$${interestofContributions}",
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Buying Power After Inflation: \$${buyingPowerAfterInflation}",
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                )
              ],
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
                    '\$1,110.21',
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
                    '\$133,224.60',
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
                    '\$33,224.60',
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

int getCompoundValue(String compound) {
  switch (compound) {
    case "annually":
      return 1;
    case "semiannually":
      return 2;
    case "quarterly":
      return 4;
    case "monthly":
      return 12;
    case "semimonthly":
      return 24;
    case "biweekly":
      return 26;
    case "weekly":
      return 52;
    case "daily":
      return 365;
    case "continuously":
      return -1;
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
                "Investment",
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
