import "package:flutter/material.dart";

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const InputField({
    super.key,
    required this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 0, 50, 10),
      child: TextField(
        controller: controller,
        obscureText: hintText == "Password" ? true : false,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.amber),
          ),
          hintText: hintText,
        ),
      ),
    );
  }
}
