import 'dart:math';

import 'package:calculatoruniverse/SIP%20Calculator/DonutChart.dart';
import 'package:calculatoruniverse/component/inputFieldRow.dart';
import 'package:calculatoruniverse/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class SIPCalculator extends StatefulWidget {
  const SIPCalculator({super.key});

  @override
  State<SIPCalculator> createState() => _SIPCalculatorState();
}

class _SIPCalculatorState extends State<SIPCalculator> {
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
              'SIP Calculator',
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
              SIPCalculatorCard(),
              Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  "SIP Calculator is a valuable tool that helps investors estimate the future value of their mutual fund investments made through a Systematic Investment Plan (SIP). By inputting the monthly SIP amount, investment duration, and expected rate of return, the calculator can determine the projected corpus amount at maturity. This tool empowers investors to make informed financial decisions by providing a clear understanding of the potential growth of their SIP investments.In this article-Formula to calculate SIP returns SIP calculation examplesPower of compounding in SIP investment  Calculation of SIP returns in Excel How to use ClearTax SIP calculator? Why should you use an SIP calculator?",
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

class SIPCalculatorCard extends StatefulWidget {
  const SIPCalculatorCard({super.key});
  @override
  State<SIPCalculatorCard> createState() => _SIPCalculatorCardState();
}

class _SIPCalculatorCardState extends State<SIPCalculatorCard> {
  final TextEditingController monthlySIPAmountController =
      TextEditingController();
  double _SIPPeriodValue = 1;
  double _expectedReturnRatetValue = 1;
  double _investmentPeriodValue = 1;
  double _returnsValue = 1;
  String _selectedValue = 'SIP Investment';

  bool isLoading = false;
  double _investedAmount = 0;
  double _maturityAmount = 0;
  String? _refressValue = "0";
  // SIP Calculation Logic
  void _calculateSIP() {
    double monthlySIP = double.tryParse(monthlySIPAmountController.text) ?? 0;
    int sipPeriodMonths = (_SIPPeriodValue * 12).toInt();
    double monthlyReturnRate = _expectedReturnRatetValue / 12 / 100;

    _investedAmount = monthlySIP * sipPeriodMonths;

    _maturityAmount = monthlySIP *
        (pow(1 + monthlyReturnRate, sipPeriodMonths) - 1) /
        monthlyReturnRate *
        (1 + monthlyReturnRate);

    setState(() {});
  }

  double _wealthGained = 0;
  double _totalWealth = 0;

  // Lumpsum Calculation Logic
  void _calculateLumpsum() {
    double lumpsumAmount =
        double.tryParse(monthlySIPAmountController.text) ?? 0;
    double annualRate = _returnsValue / 100;
    int years = _investmentPeriodValue.toInt();

    _totalWealth = lumpsumAmount * pow(1 + annualRate, years);
    _wealthGained = _totalWealth - lumpsumAmount;

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
  void didUpdateWidget(covariant SIPCalculatorCard oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _refressValue == "1" ? 900 : 600,
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Radio<String>(
                      value: 'SIP Investment',
                      groupValue: _selectedValue,
                      onChanged: (value) {
                        setState(() {
                          _selectedValue = value!;
                          monthlySIPAmountController.clear();
                          _refressValue = "0";
                        });
                      },
                      activeColor:
                          Colors.black, // Change the color when selected
                    ),
                    const Text('SIP Investment'),
                  ],
                ),
                const SizedBox(width: 20), // Space between the radio buttons
                Row(
                  children: [
                    Radio<String>(
                      value: 'Lumpsum',
                      groupValue: _selectedValue,
                      onChanged: (value) {
                        setState(() {
                          _selectedValue = value!;
                          monthlySIPAmountController.clear();
                          _refressValue = "0";
                        });
                      },
                      activeColor:
                          Colors.black, // Change the color when selected
                    ),
                    const Text('Lumpsum'),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: InputFieldRow(
                labelText: "Monthly SIP Amount",
                hintText: "",
                controller: monthlySIPAmountController,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            if (_selectedValue == 'SIP Investment')
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 12),
                      child: Text(
                        "SIP Period",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
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
                              value: _SIPPeriodValue,
                              min: 1,
                              max: 30,
                              divisions: 45,
                              label: "${_SIPPeriodValue.round()} Years",
                              onChanged: (double value) {
                                setState(() {
                                  _SIPPeriodValue = value;
                                });
                              },
                            ),
                          ),
                        ),
                        if (_selectedValue == 'SIP Investment')
                          const SizedBox(width: 16),
                        if (_selectedValue == 'SIP Investment')
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              "${_SIPPeriodValue.round()} Years",
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                      ],
                    ),
                    if (_selectedValue == 'SIP Investment')
                      const Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Text(
                          "Expected Return Rate (p.a)",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                    if (_selectedValue == 'SIP Investment')
                      const SizedBox(height: 16),
                    if (_selectedValue == 'SIP Investment')
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
                                value: _expectedReturnRatetValue,
                                min: 1,
                                max: 30,
                                divisions: 45,
                                label: "${_expectedReturnRatetValue.round()} %",
                                onChanged: (double value) {
                                  setState(() {
                                    _expectedReturnRatetValue = value;
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
                              "${_expectedReturnRatetValue.round()} %",
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            if (_selectedValue == 'Lumpsum')
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Investment Period (in Years)",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
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
                                  valueIndicatorColor: Colors
                                      .grey, // Gray for the value indicator
                                ),
                                child: Slider(
                                  value: _investmentPeriodValue,
                                  min: 1,
                                  max: 30,
                                  divisions: 45,
                                  label:
                                      "${_investmentPeriodValue.round()} Years",
                                  onChanged: (double value) {
                                    setState(() {
                                      _investmentPeriodValue = value;
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
                                "${_investmentPeriodValue.round()} Years",
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Returns",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
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
                                  valueIndicatorColor: Colors
                                      .grey, // Gray for the value indicator
                                ),
                                child: Slider(
                                  value: _returnsValue,
                                  min: 1,
                                  max: 30,
                                  divisions: 45,
                                  label: "${_returnsValue.round()} %",
                                  onChanged: (double value) {
                                    setState(() {
                                      _returnsValue = value;
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
                                "${_returnsValue.round()} %",
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ])),
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

                        String principalAmount =
                            monthlySIPAmountController.text;
                        if (principalAmount!.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Enter  Amount",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.defaultWhite,
                          );
                        } else {
                          if (_selectedValue == "SIP Investment") {
                            _refressValue = "1";
                            _calculateSIP();
                          } else {
                            _refressValue = "1";
                            _calculateLumpsum();
                          }
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
            if (_refressValue == "1")
              Column(
                children: [
                  if (_selectedValue == 'SIP Investment')
                    DonutChart(
                      principal: _maturityAmount,
                      interest: _investedAmount,
                    ),
                  if (_selectedValue == 'Lumpsum')
                    DonutChart(
                      principal: _wealthGained,
                      interest: _totalWealth,
                    ),
                ],
              ),
            if (_selectedValue == 'SIP Investment')
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Result SIP Investment",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "₹ Maturity Amount: ₹${_maturityAmount.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "₹ Invested Amount: ₹${_investedAmount.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            if (_selectedValue == 'Lumpsum')
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Result Lumpsum",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Wealth Gained: ₹${_wealthGained.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Total Wealth: ₹${_totalWealth.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 16,
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
