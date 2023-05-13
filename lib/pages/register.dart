import "package:flutter/material.dart";
import "package:project/components/error_popup.dart";
import "package:project/components/input_field.dart";
import "package:project/components/main_button.dart";
import "package:project/pages/login.dart";
import "package:http/http.dart" as http;
import "dart:convert";

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, required this.toggleTheme});

  final void Function() toggleTheme;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void handleSignup(BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse("http://192.168.100.58:8080/register"),
        body: json.encode({
          "email": emailController.text,
          "password": passwordController.text,
        }),
      );

      if (response.statusCode == 200) {
        // ignore: use_build_context_synchronously
        await showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            content: const Text("Account created."),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(foregroundColor: Colors.blueAccent),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                ),
                child: const Text("OK"),
              ),
            ],
          ),
        );
      } else {
        throw Exception("E-mail is already taken.");
      }
    } catch (e) {
      String message = e.toString().contains("Exception: ")
          ? e.toString().split("Exception: ")[1]
          : e.toString();
      // ignore: use_build_context_synchronously
      ErrorPopup(context, "Error", message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // upper text
          const Text(
            "Create account",
            style: TextStyle(fontSize: 30),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),

          // email and password fields
          InputField(controller: emailController, hintText: "E-mail"),
          InputField(controller: passwordController, hintText: "Password"),

          // create account button
          MainButton(buttonText: "Register", redirect: handleSignup),
          const SizedBox(height: 30),

          // sign up text
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text("Already have an account?"),
              const SizedBox(width: 5),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Text(
                  "Sign in",
                  style: TextStyle(
                      color: Colors.amber, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => widget.toggleTheme(),
        backgroundColor: Colors.amber,
        child: const Icon(Icons.brightness_4),
      ),
    );
  }
}
