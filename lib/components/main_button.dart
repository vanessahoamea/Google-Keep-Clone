import "package:flutter/material.dart";

class MainButton extends StatelessWidget {
  final String buttonText;
  final void Function(BuildContext) redirect;

  const MainButton({
    super.key,
    required this.buttonText,
    required this.redirect,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        redirect(context);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.amber,
        padding: const EdgeInsets.all(15),
      ),
      child: Text(buttonText, style: const TextStyle(color: Colors.black)),
    );
  }
}
