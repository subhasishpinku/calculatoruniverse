import 'package:calculatoruniverse/constants/colors.dart';
import 'package:flutter/material.dart';

class MonthsDropdownCompoundField extends StatefulWidget {
  final TextEditingController controller;
  final String? selectedValue;
  final Function(String?) onValueChanged;

  const MonthsDropdownCompoundField({
    required this.controller,
    required this.selectedValue,
    required this.onValueChanged,
    super.key,
  });

  @override
  _MonthsDropdownCompoundFieldState createState() =>
      _MonthsDropdownCompoundFieldState();
}

class _MonthsDropdownCompoundFieldState
    extends State<MonthsDropdownCompoundField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30),
      child: TextField(
        controller: widget.controller,
        decoration: InputDecoration(
          labelText: 'Average',
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
                value: 'January',
                child: Text('January'),
              ),
              DropdownMenuItem(
                value: 'February',
                child: Text('February'),
              ),
              DropdownMenuItem(
                value: 'March',
                child: Text('March'),
              ),
              DropdownMenuItem(
                value: 'April',
                child: Text('April'),
              ),
              DropdownMenuItem(
                value: 'May',
                child: Text('May'),
              ),
              DropdownMenuItem(
                value: 'June',
                child: Text('June'),
              ),
              DropdownMenuItem(
                value: 'July',
                child: Text('July'),
              ),
              DropdownMenuItem(
                value: 'August',
                child: Text('August'),
              ),
              DropdownMenuItem(
                value: 'September',
                child: Text('September'),
              ),
              DropdownMenuItem(
                value: 'October',
                child: Text('October'),
              ),
              DropdownMenuItem(
                value: 'November',
                child: Text('November'),
              ),
              DropdownMenuItem(
                value: 'December',
                child: Text('December'),
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
