import "package:flutter/material.dart";
import "login.dart";
import "../main.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title, required this.userId});

  final String title;
  final int userId;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var themeIcon = MyApp.themeNotifier.value == ThemeMode.dark
      ? Icons.light_mode
      : Icons.dark_mode;

  void toggleThemeIcon(IconData icon) {
    setState(() {
      themeIcon = icon;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            widget.title,
            style: const TextStyle(color: Colors.black),
          ),
        ),
        backgroundColor: Colors.amber,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Logged in as user ${widget.userId}.",
            ),
          ],
        ),
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
