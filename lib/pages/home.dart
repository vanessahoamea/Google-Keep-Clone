import "package:flutter/material.dart";
import "package:project/components/app_buttons.dart";
import "package:project/components/grid_notes.dart";
import "package:project/components/list_notes.dart";
import "package:project/components/main_button.dart";
import "package:http/http.dart" as http;
import "dart:convert";

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.title,
    required this.userId,
    required this.userEmail,
    required this.toggleTheme,
  });

  final String title;
  final int userId;
  final String userEmail;
  final void Function() toggleTheme;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List notes = [];
  var notesView = Icons.view_list;

  void toggleNotesView(IconData view) {
    setState(() {
      notesView = view;
    });
  }

  void getNotes() async {
    final response = await http
        .get(Uri.parse("http://192.168.100.58:8080/notes/${widget.userId}"));

    if (response.statusCode == 200) {
      setState(() {
        notes = json.decode(response.body)["data"];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getNotes();
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
              getNotes: getNotes,
              userId: widget.userId,
              toggleTheme: widget.toggleTheme,
            ),

            // view all notes
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 30),
              child: notes.isEmpty
                  ? const Text("You don't have any notes yet.")
                  : (notesView == Icons.view_list
                      ? GridNotes(
                          notes: notes,
                          getNotes: getNotes,
                          toggleTheme: widget.toggleTheme,
                        )
                      : ListNotes(
                          notes: notes,
                          getNotes: getNotes,
                          toggleTheme: widget.toggleTheme,
                        )),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => widget.toggleTheme(),
        backgroundColor: Colors.amber,
        child: const Icon(Icons.brightness_4),
      ),
    );
  }
}
