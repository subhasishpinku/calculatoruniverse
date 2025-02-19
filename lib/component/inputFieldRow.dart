import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Required for input formatters

class InputFieldRow extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController controller;

  const InputFieldRow({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8), // Space between label and TextField
        TextField(
          controller: controller,
          keyboardType: TextInputType.number, // Sets the keyboard to numeric
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly, // Allows only digits
          ],
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromARGB(255, 136, 122, 122),
                width: 1.0,
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFFDDDDDD),
                width: 1.0,
              ),
            ),
            hintText: hintText,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 16,
            ),
          ),
        ),
      ],
    );
  }
}
