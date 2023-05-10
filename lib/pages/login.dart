import "package:flutter/material.dart";
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
  var themeIcon = MyApp.themeNotifier.value == ThemeMode.dark
      ? Icons.light_mode
      : Icons.dark_mode;

  void toggleThemeIcon(IconData icon) {
    setState(() {
      themeIcon = icon;
    });
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
      int userId = data["id"];
      String userEmail = data["email"];

      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(
            title: "Google Keep Clone",
            userId: userId,
            userEmail: userEmail,
          ),
        ),
      );
    } else {
      // ignore: use_build_context_synchronously
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text("User not found"),
          content: const Text("E-mail or password are incorrect."),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.blueAccent),
              onPressed: () => Navigator.pop(context, "Close"),
              child: const Text("Close"),
            ),
          ],
        ),
      );
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
            buttonText: "Sign in",
            redirect: handleLogin,
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
