import "package:flutter/material.dart";

class MainButton extends StatelessWidget {
  final String email;
  final String password;

  const MainButton({
    super.key,
    required this.email,
    required this.password,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        //
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.amber,
        padding: const EdgeInsets.all(20),
      ),
      child: const Text("Sign in", style: TextStyle(color: Colors.black)),
    );
  }
}
