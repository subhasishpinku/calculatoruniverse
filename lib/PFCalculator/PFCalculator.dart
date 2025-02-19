import 'dart:math';

import 'package:calculatoruniverse/Interest%20Calculator/compoundFrequencyRow.dart';
import 'package:calculatoruniverse/PFCalculator/frequencyofInvestment.dart';
import 'package:calculatoruniverse/component/InputFieldRows.dart';
import 'package:calculatoruniverse/component/inputFieldRow.dart';
import 'package:calculatoruniverse/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PFCalculator extends StatefulWidget {
  const PFCalculator({super.key});

  @override
  State<PFCalculator> createState() => _PFCalculatorState();
}

class _PFCalculatorState extends State<PFCalculator> {
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
              'PF Calculator',
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
              PFCalculatorCard(),
              Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  "What is EPF?",
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
                  "The Employee Provident Fund or the EPF is a retirement benefits scheme for salaried employees in the private sector. The Employees Provident Fund Organisation (EPFO) manages the EPF. Any organisation or firm with 20 or more employees gets covered under the EPFO. The Employees Provident Fund Organisation operates three schemes.The EPF Scheme 1952 The Pension Scheme 1995 The Insurance Scheme 1976. The employees who fall under the EPF scheme make a fixed contribution of 12% of the basic salary and the dearness allowance towards the scheme. The employer should also make an equal contribution to the EPF scheme. The EPFO Central Board of Trustees fixes the EPF interest rates every financial year after consulting the Ministry of Finance. The EPF Interest Rate for Financial Year 2023-24 is 8.25%.The employee would get a lump-sum amount at retirement, which includes the contributions of both the employee and the employer with the interest payments. However, 12% of the employer contribution does not go to the EPF account. Out of the 12% contribution, 8.33% goes towards the Employee Pension Scheme Account, and the remaining 3.67% goes to the employee EPF account.It is compulsory for all employees who draw a basic salary of less than Rs 15,000 per month to become members of the EPF. You cannot opt-out of the EPF scheme once you become a scheme member. An employee can make an enhanced contribution up to a maximum of 100% of the basic salary to the voluntary provident fund. The employer will not match the contribution.",
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

class PFCalculatorCard extends StatefulWidget {
  const PFCalculatorCard({super.key});
  @override
  State<PFCalculatorCard> createState() => _PFCalculatorCardState();
}

class _PFCalculatorCardState extends State<PFCalculatorCard> {
  final TextEditingController monthlySIPAmountController =
      TextEditingController();
  final TextEditingController currentPFInterestRateController =
      TextEditingController();
  final TextEditingController frequencyOfInvestmentController =
      TextEditingController();
        String? _selectedFrequencyOfInvestment = "Monthly";

  double _durationofinvestmentValue = 15;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    currentPFInterestRateController.text = "8.25";
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant PFCalculatorCard oldWidget) {
    super.didUpdateWidget(oldWidget);
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
                labelText: "YEARLY PF Investment (MIN:500, MAX:150,000)",
                hintText: "",
                controller: monthlySIPAmountController,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: InputFieldRows(
                labelText: "Current PF Interest Rate (FY 2023-24)",
                hintText: "",
                controller: currentPFInterestRateController,
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
                      "Duration of investment (15-50 YEARS)",
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
                            value: _durationofinvestmentValue,
                            min: 15,
                            max: 50,
                            divisions: 45,
                            label:
                                "${_durationofinvestmentValue.round()} Years",
                            onChanged: (double value) {
                              setState(() {
                                _durationofinvestmentValue = value;
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
                          "${_durationofinvestmentValue.round()} Years",
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
                Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 18, bottom: 15),
                              child: Text(
                                'Frequency of Investment',
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
                          child: FrequencyOfInvestment(
                            controller: frequencyOfInvestmentController,
                            selectedValue: _selectedFrequencyOfInvestment,
                            onValueChanged: (value) {
                              setState(() {
                                _selectedFrequencyOfInvestment = value;
                              });
                            },
                          ),
                        ),
                      ],
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

                        String monthlySIPAmount =
                            monthlySIPAmountController.text;
                            String currentPFInterestRate =
                            currentPFInterestRateController.text;
                        if (monthlySIPAmount!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter Monthly SIP Amount",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        }     currentPFInterestRateController.text;
                        if (currentPFInterestRate!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter Current PF InterestRate",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        }else {
                       
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
                        monthlySIPAmountController.clear();
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
          ],
        ),
      ),
    );
  }
}
