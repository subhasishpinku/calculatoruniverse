

import 'package:calculatoruniverse/Interest%20Calculator/InterestCalculators.dart';
import 'package:calculatoruniverse/InterestCalculator/InterestCalculator.dart';
import 'package:calculatoruniverse/PFCalculator/pFCalculator.dart';
import 'package:calculatoruniverse/SIP%20Calculator/sIPCalculator.dart';
import 'package:calculatoruniverse/component/calculatorItem.dart';
import 'package:calculatoruniverse/constants/colors.dart';
import 'package:calculatoruniverse/defaultScreen.dart';
import 'package:calculatoruniverse/gratuityCalculator/gratuityCalculator.dart';
import 'package:calculatoruniverse/screens/FinancialCalculators/financial_calculators.dart';
import 'package:calculatoruniverse/screens/FitnessHealthCalculators/fitnessHealthCalculators.dart';
import 'package:calculatoruniverse/screens/dashboard/dashboard_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaxCalculatorsDashboard extends StatefulWidget {
  const TaxCalculatorsDashboard({super.key});
  @override
  State<TaxCalculatorsDashboard> createState() => _TaxCalculatorsDashboardState();
}

class _TaxCalculatorsDashboardState extends State<TaxCalculatorsDashboard> {
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
              'Categories', // Replace this with your desired title
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
                                  const InterestCalculators(),
                            ),
                          );
                        },
                        child: const CalculatorItem(
                          imagePath: "assets/images/interestCal.png",
                          title: 'Interest Calculator',
                          padding: EdgeInsets.only(top: 0),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const FitnessHealthCalculator(),
                            ),
                          );
                        },
                        child: const CalculatorItem(
                          imagePath: "assets/images/incomeTax.png",
                          title: 'Income Tax Calculator',
                          padding: EdgeInsets.only(top: 20),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const GratuityCalculator(),
                            ),
                          );
                        },
                        child: const CalculatorItem(
                          imagePath: "assets/images/gratuity.png",
                          title: 'Gratuity Calculator',
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
                                  const SIPCalculator(),
                            ),
                          );
                        },
                        child: const CalculatorItem(
                          imagePath: "assets/images/sip.png",
                          title: 'SIP Calculator',
                          padding: EdgeInsets.only(top: 0),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const PFCalculator(),
                            ),
                          );
                        },
                        child: const CalculatorItem(
                          imagePath: "assets/images/pf.png",
                          title: 'PF Calculator',
                          padding: EdgeInsets.only(top: 0),
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
                          imagePath: "assets/images/hra.png",
                          title: 'HRA calculator',
                          padding: EdgeInsets.only(top: 0),
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
