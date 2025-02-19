import 'package:calculatoruniverse/constants/colors.dart';
import 'package:flutter/material.dart';

class YearsDropdownCompoundField extends StatefulWidget {
  final TextEditingController controller;
  final String? selectedValue;
  final Function(String?) onValueChanged;

  const YearsDropdownCompoundField({
    required this.controller,
    required this.selectedValue,
    required this.onValueChanged,
    super.key,
  });

  @override
  _YearsDropdownCompoundFieldState createState() =>
      _YearsDropdownCompoundFieldState();
}

class _YearsDropdownCompoundFieldState
    extends State<YearsDropdownCompoundField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30),
      child: TextField(
        controller: widget.controller,
        decoration: InputDecoration(
          labelText: 'Years',
          floatingLabelBehavior: FloatingLabelBehavior.always,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(
              color: AppColor.lightGrayColor,
              width: 1.0,
            ),
          ),
          suffixIcon: DropdownButton<String>(
            value: widget.selectedValue,
            underline: const SizedBox(),
            icon: const Icon(Icons.arrow_drop_down),
            items: const [
              DropdownMenuItem(
                value: '2025',
                child: Text('2025'),
              ),
              DropdownMenuItem(
                value: '2024',
                child: Text('2024'),
              ),
              DropdownMenuItem(
                value: '2023',
                child: Text('2023'),
              ),
              DropdownMenuItem(
                value: '2022',
                child: Text('2022'),
              ),
              DropdownMenuItem(
                value: '2021',
                child: Text('2021'),
              ),
              DropdownMenuItem(
                value: '2020',
                child: Text('2020'),
              ),
              DropdownMenuItem(
                value: '2019',
                child: Text('2019'),
              ),
              DropdownMenuItem(
                value: '2018',
                child: Text('2018'),
              ),
              DropdownMenuItem(
                value: '2017',
                child: Text('2017'),
              ),
              DropdownMenuItem(
                value: '2016',
                child: Text('October'),
              ),
              DropdownMenuItem(
                value: '2015',
                child: Text('2015'),
              ),
              DropdownMenuItem(
                value: '2014',
                child: Text('2014'),
              ),
            ],
            onChanged: (value) {
              widget.onValueChanged(value);
            },
          ),
        ),
        readOnly: true,
      ),
    );
  }
}
