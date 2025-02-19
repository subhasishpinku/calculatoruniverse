

import 'package:calculatoruniverse/Inflation%20Calculator/inflation_Calculator.dart';
import 'package:calculatoruniverse/Investment%20Calculator/InvestmentCalculator.dart';
import 'package:calculatoruniverse/PaymentCalculator/paymentCalculator.dart';
import 'package:calculatoruniverse/RetirementCalculator/RetirementCalculator.dart';
import 'package:calculatoruniverse/amortizationCalculator/amortizationCalculator.dart';
import 'package:calculatoruniverse/component/calculatorItem.dart';
import 'package:calculatoruniverse/constants/colors.dart';
import 'package:calculatoruniverse/defaultScreen.dart';
import 'package:calculatoruniverse/financeCalculator/financeCalculator.dart';
import 'package:calculatoruniverse/screens/AutoLoan/autoloan.dart';
import 'package:calculatoruniverse/screens/LoanCalculator/loan_calculator.dart';
import 'package:calculatoruniverse/screens/dashboard/dashboard_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FinancialCalculators extends StatefulWidget {
  const FinancialCalculators({super.key});

  @override
  State<FinancialCalculators> createState() => FinancialCalculatorsState();
}

class FinancialCalculatorsState extends State<FinancialCalculators> {
  @override
  void initState() {
    super.initState();
  }

  int _currentPage = 0;
  @override
  Widget build(BuildContext context) {
    DashboardProvider dashboardProviders =
        Provider.of<DashboardProvider>(context, listen: true);
    final pageController = PageController(viewportFraction: 1.05);
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
              'Financial Calculators', // Replace this with your desired title
              style: TextStyle(
                color: AppColor.defaultBlack,
                fontWeight: FontWeight.bold, // Customize the title text color
                fontSize: 18, // Customize the font size
              ),
            ),
          ),
        ),
      ),
      backgroundColor: AppColor.defaultWhite,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                CarouselSlider(
                  items: dashboardProviders.images
                      .map(
                        (e) => Center(
                          child: Image.asset(
                            e,
                            fit: BoxFit.cover,
                            width: 1000,
                          ),
                        ),
                      )
                      .toList(),
                  options: CarouselOptions(
                      height: 210.0, // Adjust height as needed
                      aspectRatio: 16 / 9, // Aspect ratio of the slider
                      viewportFraction:
                          0.8, // How much of the next/prev image to show
                      initialPage: 0,
                      autoPlay: true, // Enable auto-scrolling
                      autoPlayInterval: const Duration(seconds: 2),
                      enlargeCenterPage: true, // Enlarge the center image
                      enlargeFactor: 0.3,
                      onPageChanged: (value, _) {
                        setState(() {
                          _currentPage = value;
                        });
                      }),
                ),
                buildCarouselIndicator()
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const DefaultScreen(),
                            ),
                          );
                        },
                        child: const CalculatorItem(
                          imagePath: "assets/images/mortgage.png",
                          title: 'Mortgage Calculator',
                          padding: EdgeInsets.only(top: 10),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const LoanCalculator(),
                            ),
                          );
                        },
                        child: const CalculatorItem(
                          imagePath: "assets/images/loan.png",
                          title: 'Loan Calculators',
                          padding: EdgeInsets.only(top: 10),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                          onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const AutoLoan(),
                            ),
                          );
                        },
                        child: const CalculatorItem(
                          imagePath: "assets/images/auto.png",
                          title: 'Auto Loan Calculators',
                          padding: EdgeInsets.only(top: 10),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const PaymentCalculator(),
                            ),
                          );
                        },
                        child: const CalculatorItem(
                          imagePath: "assets/images/payment.png",
                          title: 'Payment Calculators',
                          padding: EdgeInsets.only(top: 10),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                         onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const RetirementCalculator(),
                            ),
                          );
                        },
                        child: const CalculatorItem(
                          imagePath: "assets/images/retirement.png",
                          title: 'Retirement Calculators',
                          padding: EdgeInsets.only(top: 10),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                           onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const AmortizationCalculator(),
                            ),
                          );
                        },
                        child: const CalculatorItem(
                          imagePath: "assets/images/amortization.png",
                          title: 'Amortization  Calculators',
                          padding: EdgeInsets.only(top: 10),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const InvestmentCalculator(),
                            ),
                          );
                        },
                        child: const CalculatorItem(
                          imagePath: "assets/images/investment.png",
                          title: 'Investment Calculators',
                          padding: EdgeInsets.only(top: 10),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                         onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const InflationCalculatorScreen(),
                            ),
                          );
                        },
                        child: const CalculatorItem(
                          imagePath: "assets/images/inflation.png",
                          title: 'inflation Calculators',
                          padding: EdgeInsets.only(top: 10),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                           onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const FinanceCalculator(),
                            ),
                          );
                        },
                        child: const CalculatorItem(
                          imagePath: "assets/images/finance.png",
                          title: 'Finance Calculators',
                          padding: EdgeInsets.only(top: 10),
                        ),
                      ),
                    ),
                  ],
                ),

                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const DefaultScreen(),
                            ),
                          );
                        },
                        child: const CalculatorItem(
                          imagePath: "assets/images/income.png",
                          title: 'Income Tax Calculators',
                          padding: EdgeInsets.only(top: 10),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                         onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const DefaultScreen(),
                            ),
                          );
                        },
                        child: const CalculatorItem(
                          imagePath: "assets/images/compound.png",
                          title: 'Compound Interest Calculators',
                          padding: EdgeInsets.only(top: 10),
                        ),
                      ),
                    ),
                    const Expanded(
                      child: CalculatorItem(
                        imagePath: "assets/images/salary.png",
                        title: 'Salary Calculators',
                        padding: EdgeInsets.only(top: 10),
                      ),
                    ),
                  ],
                ),

                        Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const DefaultScreen(),
                            ),
                          );
                        },
                        child: const CalculatorItem(
                          imagePath: "assets/images/interest.png",
                          title: 'Interest Rate  Calculators',
                          padding: EdgeInsets.only(top: 10),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                          onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const DefaultScreen(),
                            ),
                          );
                        },
                        child: const CalculatorItem(
                          imagePath: "assets/images/seal.png",
                          title: 'Seal Tax  Calculators',
                          padding: EdgeInsets.only(top: 10),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                          onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const DefaultScreen(),
                            ),
                          );
                        },
                        child: const CalculatorItem(
                          imagePath: "assets/images/seal.png",
                          title: 'Salary Calculators',
                          padding: EdgeInsets.only(top: 10),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  buildCarouselIndicator() {
    DashboardProvider dashboardProviders =
        Provider.of<DashboardProvider>(context, listen: true);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < dashboardProviders.images.length; i++)
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 6.0), // Adjust the horizontal spacing here
            child: Container(
              margin: EdgeInsets.all(5),
              height: i == _currentPage ? 7 : 5,
              width: i == _currentPage ? 7 : 5,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: i == _currentPage
                    ? AppColor.primaryColor
                    : AppColor.defaultBlack,
              ),
              padding: EdgeInsets.all(5.0),
            ),
          ),
      ],
    );
  }
}
