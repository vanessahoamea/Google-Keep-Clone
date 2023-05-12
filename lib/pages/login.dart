import "package:flutter/material.dart";
import "package:project/components/error_popup.dart";
import "package:project/components/input_field.dart";
import "package:project/components/main_button.dart";
import "package:project/pages/home.dart";
import "package:project/main.dart";
import "package:http/http.dart" as http;
import "dart:convert";

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void toggleThemeIcon() {
    if (MyApp.themeNotifier.value == ThemeMode.light) {
      MyApp.themeNotifier.value = ThemeMode.dark;
    } else {
      MyApp.themeNotifier.value = ThemeMode.light;
    }
  }

  void handleLogin(BuildContext context) async {
    final response = await http.post(
      Uri.parse("http://192.168.100.58:8080/login"),
      body: json.encode({
        "email": emailController.text,
        "password": passwordController.text,
      }),
    );

    if (response.statusCode == 200) {
      Map data = json.decode(response.body);

      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(
            title: "Google Keep Clone",
            userId: data["id"],
            userEmail: data["email"],
            toggleThemeIcon: toggleThemeIcon,
          ),
        ),
      );
    } else {
      // ignore: use_build_context_synchronously
      ErrorPopup(
          context, "User not found", "E-mail or password are incorrect.");
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
            "Sign in to your account to continue",
            style: TextStyle(fontSize: 30),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),

          // email and password fields
          InputField(controller: emailController, hintText: "E-mail"),
          InputField(controller: passwordController, hintText: "Password"),

          // sign in button
          MainButton(buttonText: "Sign in", redirect: handleLogin),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          toggleThemeIcon();
        },
        backgroundColor: Colors.amber,
        child: const Icon(Icons.brightness_4),
      ),
    );
  }
}
