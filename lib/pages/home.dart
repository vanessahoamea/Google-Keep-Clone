import "package:flutter/material.dart";
import "package:project/components/app_buttons.dart";
import "package:project/components/grid_notes.dart";
import "package:project/components/list_notes.dart";
import "package:project/components/main_button.dart";
import "package:project/main.dart";

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.title,
    required this.userId,
    required this.userEmail,
    required this.themeIcon,
    required this.toggleThemeIcon,
  });

  final String title;
  final int userId;
  final String userEmail;
  final IconData themeIcon;
  final void Function(IconData) toggleThemeIcon;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List notes = [];
  var notesView = Icons.view_list;

  void toggleNotesView(IconData view) {
    setState(() {
      notesView = view;
      notes = [1, 2, 3, 4, 5, 6, 7]; // for debugging
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
      body: SingleChildScrollView(
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
            Padding(
              padding: const EdgeInsets.all(10),
              child: notesView == Icons.view_list
                  ? GridNotes(notes: notes)
                  : ListNotes(notes: notes),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (MyApp.themeNotifier.value == ThemeMode.light) {
            MyApp.themeNotifier.value = ThemeMode.dark;
            widget.toggleThemeIcon(Icons.light_mode);
          } else {
            MyApp.themeNotifier.value = ThemeMode.light;
            widget.toggleThemeIcon(Icons.dark_mode);
          }
        },
        backgroundColor: Colors.amber,
        child: Icon(widget.themeIcon),
      ),
    );
  }
}
