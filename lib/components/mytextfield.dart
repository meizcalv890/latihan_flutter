import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  //declare object atau var yang diperlukan
  final String label;
  final String hint;
  final TextEditingController textEditingController;
  final bool isPassword;
  final IconData icon;
  final double fontSize;
  // dll

  const MyTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.textEditingController,
    required this.isPassword,
    required this.icon,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: fontSize)),
        Container(
          margin: const EdgeInsets.all(10),
          child: TextField(
            controller: textEditingController,
            obscureText: isPassword,
            decoration: InputDecoration(
              hintText: hint,
              prefixIcon: Icon(icon),
              filled: true,
              fillColor: Colors.grey.shade100,
              contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
              border:OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),  
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.blue),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
