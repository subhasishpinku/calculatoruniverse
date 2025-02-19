import 'package:calculatoruniverse/constants/colors.dart';
import 'package:flutter/material.dart';

class AutoLoanCompoundDropdownField extends StatefulWidget {
  final TextEditingController controller;
  final String? selectedValue;
  final Function(String?) onValueChanged;

  const AutoLoanCompoundDropdownField({
    required this.controller,
    required this.selectedValue,
    required this.onValueChanged,
    super.key,
  });

  @override
  _AutoLoanCompoundDropdownFieldState createState() =>
      _AutoLoanCompoundDropdownFieldState();
}

class _AutoLoanCompoundDropdownFieldState
    extends State<AutoLoanCompoundDropdownField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30),
      child: TextField(
        controller: widget.controller,
        decoration: InputDecoration(
          labelText: 'Select State',
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
                value: 'Andhra Pradesh',
                child: Text('Andhra Pradesh'),
              ),
              DropdownMenuItem(
                value: 'Arunachal Pradesh',
                child: Text('Arunachal Pradesh'),
              ),
              DropdownMenuItem(
                value: 'Assam',
                child: Text('Assam'),
              ),
              DropdownMenuItem(
                value: 'Bihar',
                child: Text('Bihar'),
              ),
              DropdownMenuItem(
                value: 'Chhattisgarh',
                child: Text('Chhattisgarh'),
              ),
              DropdownMenuItem(
                value: 'Goa',
                child: Text('Goa'),
              ),
              DropdownMenuItem(
                value: 'Gujarat',
                child: Text('Gujarat'),
              ),
              DropdownMenuItem(
                value: 'Haryana',
                child: Text('Haryana'),
              ),
              DropdownMenuItem(
                value: 'Himachal Pradesh',
                child: Text('Himachal Pradesh'),
              ),
              DropdownMenuItem(
                value: 'Jharkhand',
                child: Text('Jharkhand'),
              ),
              DropdownMenuItem(
                value: 'Karnataka',
                child: Text('Karnataka'),
              ),
              DropdownMenuItem(
                value: 'Kerala',
                child: Text('Kerala'),
              ),
              DropdownMenuItem(
                value: 'Madhya Pradesh',
                child: Text('Madhya Pradesh'),
              ),
              DropdownMenuItem(
                value: 'Maharashtra',
                child: Text('Maharashtra'),
              ),
              DropdownMenuItem(
                value: 'Manipur',
                child: Text('Manipur'),
              ),
              DropdownMenuItem(
                value: 'Meghalaya',
                child: Text('Meghalaya'),
              ),
              DropdownMenuItem(
                value: 'Mizoram',
                child: Text('Mizoram'),
              ),
              DropdownMenuItem(
                value: 'Nagaland',
                child: Text('Nagaland'),
              ),
              DropdownMenuItem(
                value: 'Odisha',
                child: Text('Odisha'),
              ),
              DropdownMenuItem(
                value: 'Punjab',
                child: Text('Punjab'),
              ),
              DropdownMenuItem(
                value: 'Rajasthan',
                child: Text('Rajasthan'),
              ),
              DropdownMenuItem(
                value: 'Sikkim',
                child: Text('Sikkim'),
              ),
              DropdownMenuItem(
                value: 'Tamil Nadu',
                child: Text('Tamil Nadu'),
              ),
              DropdownMenuItem(
                value: 'Telangana',
                child: Text('Telangana'),
              ),
              DropdownMenuItem(
                value: 'Tripura',
                child: Text('Tripura'),
              ),
              DropdownMenuItem(
                value: 'Uttar Pradesh',
                child: Text('Uttar Pradesh'),
              ),
              DropdownMenuItem(
                value: 'Uttarakhand',
                child: Text('Uttarakhand'),
              ),
              DropdownMenuItem(
                value: 'West Bengal',
                child: Text('West Bengal'),
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
