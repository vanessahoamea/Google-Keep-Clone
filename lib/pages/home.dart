import "package:flutter/material.dart";
import "package:project/components/app_buttons.dart";
import "package:project/components/main_button.dart";
import "package:project/main.dart";

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.title,
    required this.userId,
    required this.userEmail,
  });

  final String title;
  final int userId;
  final String userEmail;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var notesView = Icons.view_list;
  var themeIcon = MyApp.themeNotifier.value == ThemeMode.dark
      ? Icons.light_mode
      : Icons.dark_mode;

  void toggleThemeIcon(IconData icon) {
    setState(() {
      themeIcon = icon;
    });
  }

  void toggleNotesView() {
    setState(() {
      if (notesView == Icons.view_list) {
        notesView = Icons.grid_view;
      } else {
        notesView = Icons.view_list;
      }
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // user information and log out button
            Padding(
              padding: const EdgeInsets.only(top: 25, bottom: 5),
              child: Text(
                "Welcome back, ${widget.userEmail}!",
                style: const TextStyle(fontSize: 18),
              ),
            ),
            MainButton(
              buttonText: "Log out",
              redirect: (context) => Navigator.pop(context),
            ),

            // create note and toggle view buttons
            AppButtons(
              notesView: notesView,
              toggleNotesView: toggleNotesView,
            ),

            // view all notes
            notesView == Icons.view_list
                ? const Text("Displaying grid notes...")
                : const Text("Displaying list notes..."),
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
