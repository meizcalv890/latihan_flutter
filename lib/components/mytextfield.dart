import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final String label;
  final String hint;
  final TextEditingController textEditingController;
  final bool isPassword;
  final IconData icon;
  final double fontSize;

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
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: TextStyle(fontSize: widget.fontSize)),
        Container(
          margin: const EdgeInsets.all(10),
          child: TextField(
            controller: widget.textEditingController,
            obscureText: widget.isPassword && isObscure,
            decoration: InputDecoration(
              hintText: widget.hint,
              prefixIcon: Icon(widget.icon),

              suffixIcon: widget.isPassword
                  ? IconButton(
                      icon: Icon(
                        isObscure ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          isObscure = !isObscure;
                        });
                      },
                    )
                  : null,

              filled: true,
              fillColor: Colors.grey.shade100,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 14,
                horizontal: 12,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.blue),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
