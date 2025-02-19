import 'package:calculatoruniverse/constants/colors.dart';
import 'package:flutter/material.dart';

class CompoundFrequencyField extends StatefulWidget {
  final TextEditingController controller;
  final String? selectedValue;
  final Function(String?) onValueChanged;

  const CompoundFrequencyField({
    required this.controller,
    required this.selectedValue,
    required this.onValueChanged,
    super.key,
  });

  @override
  _CompoundFrequencyFieldState createState() =>
      _CompoundFrequencyFieldState();
}

class _CompoundFrequencyFieldState extends State<CompoundFrequencyField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18),
      child: TextField(
        controller: widget.controller,
        decoration: InputDecoration(
          labelText: 'Compound Frequency',
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
                value: 'Daily',
                child: Text('Daily'),
              ),
              DropdownMenuItem(
                value: 'Weekly',
                child: Text('Weekly'),
              ),
              DropdownMenuItem(
                value: 'Monthly',
                child: Text('Monthly'),
              ),
              DropdownMenuItem(
                value: 'Quaters',
                child: Text('Quaters'),
              ),
              DropdownMenuItem(
                value: 'Semi-Annual',
                child: Text('Semi-Annual'),
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
