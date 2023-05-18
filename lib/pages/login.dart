import "package:flutter/material.dart";
import "package:project/components/error_popup.dart";
import "package:project/components/input_field.dart";
import "package:project/components/main_button.dart";
import "package:project/pages/home.dart";
import "package:project/pages/register.dart";
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

  void toggleTheme() {
    if (MyApp.themeNotifier.value == ThemeMode.light) {
      MyApp.themeNotifier.value = ThemeMode.dark;
    } else {
      MyApp.themeNotifier.value = ThemeMode.light;
    }
  }

  void handleLogin(BuildContext context) async {
    try {
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
              toggleTheme: toggleTheme,
            ),
          ),
        );
      } else {
        throw Exception("E-mail or password are incorrect.");
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
          const SizedBox(height: 30),

          // sign up text
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text("Don't have an account?"),
              const SizedBox(width: 5),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          RegisterPage(toggleTheme: toggleTheme),
                    ),
                  );
                },
                child: const Text(
                  "Register",
                  style: TextStyle(
                      color: Colors.amber, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => toggleTheme(),
        backgroundColor: Colors.amber,
        child: const Icon(Icons.brightness_4),
      ),
    );
  }
}
