import 'package:calculatoruniverse/constants/colors.dart';
import 'package:flutter/material.dart';

class PayBackDropdownField extends StatefulWidget {
  final TextEditingController controller;
  final String? selectedValue;
  final Function(String?) onValueChanged;

  const PayBackDropdownField({
    required this.controller,
    required this.selectedValue,
    required this.onValueChanged,
    super.key,
  });

  @override
  _PayBackDropdownFieldState createState() => _PayBackDropdownFieldState();
}

class _PayBackDropdownFieldState extends State<PayBackDropdownField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30),
      child: TextField(
        controller: widget.controller,
        decoration: InputDecoration(
          labelText: 'Select a PayBack',
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
                value: 'Every Day',
                child: Text('Every Day'),
              ),
              DropdownMenuItem(
                value: 'Every Week',
                child: Text('Every Week'),
              ),
              DropdownMenuItem(
                value: 'Every 2 Weeks',
                child: Text('Every 2 Weeks'),
              ),
              DropdownMenuItem(
                value: 'Every Half Month',
                child: Text('Every Half Month'),
              ),
              DropdownMenuItem(
                value: 'Every Month',
                child: Text('Every Month'),
              ),
              DropdownMenuItem(
                value: 'Every Quarter',
                child: Text('Every Quarter'),
              ),
              DropdownMenuItem(
                value: 'Every 6 Months',
                child: Text('Every 6 Months'),
              ),
              DropdownMenuItem(
                value: 'Every Years',
                child: Text('Every Years'),
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
