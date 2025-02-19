import 'package:calculatoruniverse/constants/colors.dart';
import 'package:flutter/material.dart';

class PeriodUnitCompoundField extends StatefulWidget {
  final TextEditingController controller;
  final String? selectedValue;
  final Function(String?) onValueChanged;

  const PeriodUnitCompoundField({
    required this.controller,
    required this.selectedValue,
    required this.onValueChanged,
    super.key,
  });

  @override
  _PeriodUnitCompoundFieldState createState() =>
      _PeriodUnitCompoundFieldState();
}

class _PeriodUnitCompoundFieldState extends State<PeriodUnitCompoundField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18),
      child: TextField(
        controller: widget.controller,
        decoration: InputDecoration(
          labelText: 'Period Unit',
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
                value: 'Days',
                child: Text('Days'),
              ),
              DropdownMenuItem(
                value: 'Weeks',
                child: Text('Weeks'),
              ),
              DropdownMenuItem(
                value: 'Months',
                child: Text('Months'),
              ),
              DropdownMenuItem(
                value: 'Quaters',
                child: Text('Quaters'),
              ),
              DropdownMenuItem(
                value: 'Years',
                child: Text('Years'),
              ),
            ],
            onChanged: (value) {
              if (value != null) {
                widget.onValueChanged(value);
              }
            },
          ),
        ),
        readOnly: true,
      ),
    );
  }
}
