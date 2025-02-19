import 'package:calculatoruniverse/TaxCalculatorsDashbord/TaxCalculatorsDashbord.dart';
import 'package:calculatoruniverse/component/calculatorItem.dart';
import 'package:calculatoruniverse/constants/colors.dart';
import 'package:calculatoruniverse/defaultScreen.dart';
import 'package:calculatoruniverse/screens/FinancialCalculators/financial_calculators.dart';
import 'package:calculatoruniverse/screens/FitnessHealthCalculators/fitnessHealthCalculators.dart';
import 'package:calculatoruniverse/screens/dashboard/dashboard_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
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
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     Expanded(
            //       child: Column(
            //         children: [
            //           Column(
            //             children: [
            //               Container(
            //                 padding: const EdgeInsets.only(top: 0),
            //                 child: Image.asset(
            //                   "assets/images/financial.png",
            //                 ),
            //               ),
            //               const Padding(
            //                 padding: EdgeInsets.only(left: 30, top: 10),
            //                 child: Text('Financial Calculators'),
            //               )
            //             ],
            //           ),
            //         ],
            //       ),
            //     ),
            //     Expanded(
            //       child: Column(
            //         children: [
            //           Column(
            //             children: [
            //               Container(
            //                 padding: const EdgeInsets.only(top: 20),
            //                 child: Image.asset(
            //                   "assets/images/health.png",
            //                 ),
            //               ),
            //               const Padding(
            //                 padding: EdgeInsets.only(left: 30, top: 10),
            //                 child: Text('Fitness & Health Calculators'),
            //               )
            //             ],
            //           ),
            //         ],
            //       ),
            //     ),
            //     Expanded(
            //       child: Column(
            //         children: [
            //           Column(
            //             children: [
            //               Container(
            //                 padding: const EdgeInsets.only(top: 10),
            //                 child: Image.asset(
            //                   "assets/images/math.png",
            //                 ),
            //               ),
            //               const Padding(
            //                 padding: EdgeInsets.only(left: 30, top: 10),
            //                 child: Text('Math Calculators'),
            //               )
            //             ],
            //           ),
            //         ],
            //       ),
            //     ),
            //   ],
            // ),
            // Column(
            //   crossAxisAlignment:
            //       CrossAxisAlignment.start,
            //   children: [
            //     Container(
            //       padding: const EdgeInsets.only(top: 10,left:  20),
            //       child: Image.asset(
            //         "assets/images/other.png",
            //       ),
            //     ),
            //     const Padding(
            //       padding: EdgeInsets.only(left: 30, top: 10, right: 270),
            //       child: Text('Other Calculators'),
            //     )
            //   ],
            // ),
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
                                  const FinancialCalculators(),
                            ),
                          );
                        },
                        child: const CalculatorItem(
                          imagePath: "assets/images/financial.png",
                          title: 'Financial Calculators',
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
                          imagePath: "assets/images/health.png",
                          title: 'Fitness & Health Calculators',
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
                                  const DefaultScreen(),
                            ),
                          );
                        },
                        child: const CalculatorItem(
                          imagePath: "assets/images/math.png",
                          title: 'Math Calculators',
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
                          imagePath: "assets/images/other.png",
                          title: 'Other Calculators',
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
                                  const TaxCalculatorsDashboard(),
                            ),
                          );
                        },
                        child: const CalculatorItem(
                          imagePath: "assets/images/tax.png",
                          title: 'Tax Calculators',
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
                          imagePath: "assets/images/defult.png",
                          title: 'coomming Soon',
                          padding: EdgeInsets.only(top: 0),
                        ),
                      ),
                    ),
                    // GestureDetector(
                    //      onTap: () {
                    //       Navigator.of(context).push(
                    //         MaterialPageRoute(
                    //           builder: (BuildContext context) =>
                    //               const DefaultScreen(),
                    //         ),
                    //       );
                    //     },
                    //   child: Container(
                    //     padding: const EdgeInsets.only(top: 10, left: 20),
                    //     child: Image.asset(
                    //       "assets/images/other.png",
                    //     ),
                    //   ),
                    // ),
                    // const Padding(
                    //   padding: EdgeInsets.only(left: 30, top: 10, right: 270),
                    //   child: Text('Other Calculators'),
                    // )
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
