import 'package:calculatoruniverse/constants/colors.dart';
import 'package:flutter/material.dart';

class CompoundDropdownField extends StatefulWidget {
  final TextEditingController controller;
  final String? selectedValue;
  final Function(String?) onValueChanged;

  const CompoundDropdownField({
    required this.controller,
    required this.selectedValue,
    required this.onValueChanged,
    super.key,
  });

  @override
  _CompoundDropdownFieldState createState() => _CompoundDropdownFieldState();
}

class _CompoundDropdownFieldState extends State<CompoundDropdownField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30),
      child: TextField(
        controller: widget.controller,
        decoration: InputDecoration(
          labelText: 'Select a Compound',
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
                value: 'Annually (APY)',
                child: Text('Annually (APY)'),
              ),
              DropdownMenuItem(
                value: 'Semi-annually',
                child: Text('Semi-annually'),
              ),
              DropdownMenuItem(
                value: 'Quarterly',
                child: Text('Quarterly'),
              ),
              DropdownMenuItem(
                value: 'Monthly (APR)',
                child: Text('Monthly (APR)'),
              ),
              DropdownMenuItem(
                value: 'Semi-monthly',
                child: Text('Semi-monthly'),
              ),
              DropdownMenuItem(
                value: 'Biweekly',
                child: Text('Biweekly'),
              ),
              DropdownMenuItem(
                value: 'Weekly',
                child: Text('Weekly'),
              ),
              DropdownMenuItem(
                value: 'Daily',
                child: Text('Daily'),
              ),
              DropdownMenuItem(
                value: 'Continuously',
                child: Text('Continuously'),
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
