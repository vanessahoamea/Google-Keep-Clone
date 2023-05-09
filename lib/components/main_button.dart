import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "dart:convert";

class MainButton extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final void Function(BuildContext, int) redirect;

  const MainButton({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.redirect,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final response = await http.post(
          Uri.parse("http://192.168.100.58:8080/login"),
          body: json.encode({
            "email": emailController.text,
            "password": passwordController.text
          }),
        );

        if (response.statusCode == 200) {
          Map data = json.decode(response.body);
          int userId = data["id"];

          redirect(context, userId);
        } else {
          //
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.amber,
        padding: const EdgeInsets.all(20),
      ),
      child: const Text("Sign in", style: TextStyle(color: Colors.black)),
    );
  }
}
