import 'package:calculatoruniverse/constants/colors.dart';
import 'package:flutter/material.dart';

class InterestDropdownCompoundField extends StatefulWidget {
  final TextEditingController controller;
  final String? selectedValue;
  final Function(String?) onValueChanged;

  const InterestDropdownCompoundField({
    required this.controller,
    required this.selectedValue,
    required this.onValueChanged,
    super.key,
  });

  @override
  _InterestDropdownCompoundFieldState createState() =>
      _InterestDropdownCompoundFieldState();
}

class _InterestDropdownCompoundFieldState
    extends State<InterestDropdownCompoundField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30),
      child: TextField(
        controller: widget.controller,
        decoration: InputDecoration(
          labelText: 'Select',
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
                value: 'annually',
                child: Text('annually'),
              ),
               DropdownMenuItem(
                value: 'semiannually',
                child: Text('semiannually'),
              ),
               DropdownMenuItem(
                value: 'quarterly',
                child: Text('quarterly'),
              ),
              DropdownMenuItem(
                value: 'monthly',
                child: Text('monthly'),
              ),
               DropdownMenuItem(
                value: 'semimonthly',
                child: Text('semimonthly'),
              ),
               DropdownMenuItem(
                value: 'biweekly',
                child: Text('biweekly'),
              ),
               DropdownMenuItem(
                value: 'weekly',
                child: Text('weekly'),
              ),
               DropdownMenuItem(
                value: 'daily',
                child: Text('daily'),
              ),
              DropdownMenuItem(
                value: 'continuously',
                child: Text('continuously'),
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
