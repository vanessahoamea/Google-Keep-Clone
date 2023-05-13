import "package:flutter/material.dart";
import "package:project/components/error_popup.dart";
import "package:project/components/warning_popup.dart";
import "package:http/http.dart" as http;
import "dart:convert";

class SingleNote extends StatefulWidget {
  const SingleNote({
    super.key,
    required this.userId,
    required this.noteId,
    required this.noteTitle,
    required this.noteContent,
    required this.toggleTheme,
  });

  final int? userId;
  final int? noteId;
  final String? noteTitle;
  final String? noteContent;
  final void Function() toggleTheme;

  @override
  State<SingleNote> createState() => _SingleNoteState();
}

class _SingleNoteState extends State<SingleNote> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  bool savedNote = true;

  void isChanged(String text, String? original) {
    setState(() {
      savedNote = (text == original);
    });
  }

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.noteTitle ?? "");
    contentController = TextEditingController(text: widget.noteContent ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool isNewEmptyNote = widget.noteId == null &&
            titleController.text == "" &&
            contentController.text == "";
        if (!savedNote && !isNewEmptyNote) {
          String? option = await WarningPopup(context,
              "Are you sure you want to discard your changes to this note?");
          return option == "OK" ? true : false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          iconTheme: const IconThemeData(color: Colors.black),
          actions: [
            IconButton(
              onPressed: () async {
                try {
                  final endpoint = widget.noteId == null
                      ? "notes"
                      : "notes/${widget.noteId}";
                  final response = await http.post(
                    Uri.parse("http://192.168.100.58:8080/$endpoint"),
                    body: json.encode({
                      "user_id": widget.userId,
                      "title": titleController.text,
                      "content": contentController.text,
                    }),
                  );

                  if (response.statusCode == 200) {
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context, true);
                  } else {
                    throw Exception(json.decode(response.body)["message"]);
                  }
                } catch (e) {
                  String message = e.toString().contains("Exception: ")
                      ? e.toString().split("Exception: ")[1]
                      : e.toString();
                  // ignore: use_build_context_synchronously
                  ErrorPopup(context, "Error", "Failed to save note: $message");
                }
              },
              icon: const Icon(Icons.save_outlined, color: Colors.black),
              tooltip: "Save",
            ),
            if (widget.noteId != null)
              IconButton(
                onPressed: () async {
                  String? option = await WarningPopup(context,
                      "Are you sure you want to delete this note? This action can't be undone.");

                  if (option == "OK") {
                    try {
                      final response = await http.post(Uri.parse(
                          "http://192.168.100.58:8080/delete-note/${widget.noteId}"));

                      if (response.statusCode == 200) {
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context, true);
                      } else {
                        throw Exception(json.decode(response.body)["message"]);
                      }
                    } catch (e) {
                      // ignore: use_build_context_synchronously
                      ErrorPopup(context, "Error", "Failed to delete note: $e");
                    }
                  }
                },
                icon: const Icon(Icons.delete, color: Colors.black),
                tooltip: "Delete",
              ),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(15),
          children: <Widget>[
            TextFormField(
              controller: titleController,
              onChanged: (text) => isChanged(text, widget.noteTitle),
              decoration: const InputDecoration(
                hintText: "Title",
                border: InputBorder.none,
              ),
              style: const TextStyle(fontSize: 30),
            ),
            TextFormField(
              controller: contentController,
              onChanged: (text) => isChanged(text, widget.noteContent),
              decoration: const InputDecoration(
                hintText: "Take a note...",
                border: InputBorder.none,
              ),
              keyboardType: TextInputType.multiline,
              maxLines: null,
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => widget.toggleTheme(),
          backgroundColor: Colors.amber,
          child: const Icon(Icons.brightness_4),
        ),
      ),
    );
  }
}
