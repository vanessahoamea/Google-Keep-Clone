import "package:flutter/material.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.dark);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, currentMode, child) {
        return MaterialApp(
          title: "Google Keep Clone",
          theme: ThemeData(primarySwatch: Colors.amber),
          darkTheme: ThemeData.dark(),
          themeMode: currentMode,
          home: const MyHomePage(title: "Google Keep Clone"),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              "Testing dark & light mode switch...",
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
