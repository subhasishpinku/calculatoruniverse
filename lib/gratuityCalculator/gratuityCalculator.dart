import 'package:calculatoruniverse/component/inputFieldRow.dart';
import 'package:calculatoruniverse/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GratuityCalculator extends StatefulWidget {
  const GratuityCalculator({super.key});

  @override
  State<GratuityCalculator> createState() => _GratuityCalculatorState();
}

class _GratuityCalculatorState extends State<GratuityCalculator> {
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
              'What is Gratuity?',
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
              GratuityCalculatorCard(),
              Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  "Gratuity refers to the amount that an employer pays his employee, in return for services offered by him to the company. However, only those employees who have been employed by the company for five years or more are given the gratuity amount. It is governed by the Payment of Gratuity Act, 1972.The employee can get the gratuity before five years if he/she gets disabled in an accident or due to a disease. Gratuity mainly depends on your last drawn salary and the years of service which are rendered to the Company.",
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
              Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  "What are the Eligibility Criteria for Payment of Gratuity? o receive the gratuity, you must meet the following eligibility criteria: You should be eligible for superannuation.You should have retired from service.You should have resigned after continuous employment of five years with the company.In case of your death the gratuity is paid to the nominee, or to you on disablement on account of a sickness or an accident.",
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

class GratuityCalculatorCard extends StatefulWidget {
  const GratuityCalculatorCard({super.key});
  @override
  State<GratuityCalculatorCard> createState() => _GratuityCalculatorCardState();
}

class _GratuityCalculatorCardState extends State<GratuityCalculatorCard> {
  final TextEditingController salaryController = TextEditingController();
  double _currentValue = 5;
  bool isLoading = false;
  double gratuityPayable = 0.0;

  // Method to calculate gratuity
  void calculateGratuity() {
    if (salaryController.text.isNotEmpty) {
      double salary = double.tryParse(salaryController.text) ?? 0;
      gratuityPayable = (salary * _currentValue * 15) / 26; // Formula
    } else {
      gratuityPayable = 0.0;
    }
    setState(() {});
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
  void didUpdateWidget(covariant GratuityCalculatorCard oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 450,
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
                labelText: "Salary (Basic Pay + D.A)",
                hintText: "Enter Salary (Basic Pay + D.A)",
                controller: salaryController,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 12),
                    child: Text(
                      "No. of Years Of Service (Min: 5 Years)",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            activeTrackColor:
                                Colors.grey, // Gray for the active track
                            inactiveTrackColor: Colors.grey
                                .shade300, // Lighter gray for inactive track
                            thumbColor: Colors.grey, // Gray for the thumb
                            overlayColor: Colors.grey.withOpacity(
                                0.3), // Transparent gray for overlay
                            valueIndicatorColor:
                                Colors.grey, // Gray for the value indicator
                          ),
                          child: Slider(
                            value: _currentValue,
                            min: 5,
                            max: 50,
                            divisions: 45,
                            label: "${_currentValue.round()} Years",
                            onChanged: (double value) {
                              setState(() {
                                _currentValue = value;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          "${_currentValue.round()} Years",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ],
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

                        calculateGratuity();
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
            const SizedBox(height: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Total Gratuity Payable To You",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  "₹ ${NumberFormat("#,##0.00").format(gratuityPayable)}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
