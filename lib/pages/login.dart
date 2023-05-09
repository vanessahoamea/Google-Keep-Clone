import "package:flutter/material.dart";
import "package:project/components/input_field.dart";
import "package:project/components/main_button.dart";
import "home.dart";
import "../main.dart";

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var themeIcon = MyApp.themeNotifier.value == ThemeMode.dark
      ? Icons.light_mode
      : Icons.dark_mode;

  void toggleThemeIcon(IconData icon) {
    setState(() {
      themeIcon = icon;
    });
  }

  void redirect(BuildContext context, int userId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(
          title: "Google Keep Clone",
          userId: userId,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            "Sign in to your account to continue",
            style: TextStyle(
              fontSize: 30,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 30),

          // email and password fields
          InputField(
            controller: emailController,
            hintText: "E-mail",
            obscureText: false,
          ),
          InputField(
            controller: passwordController,
            hintText: "Password",
            obscureText: true,
          ),

          // sign in button
          MainButton(
            emailController: emailController,
            passwordController: passwordController,
            redirect: redirect,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (MyApp.themeNotifier.value == ThemeMode.light) {
            MyApp.themeNotifier.value = ThemeMode.dark;
            toggleThemeIcon(Icons.light_mode);
          } else {
            MyApp.themeNotifier.value = ThemeMode.light;
            toggleThemeIcon(Icons.dark_mode);
          }
        },
        backgroundColor: Colors.amber,
        child: Icon(themeIcon),
      ),
    );
  }
}
