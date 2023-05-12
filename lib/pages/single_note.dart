import "package:flutter/material.dart";
import "package:project/components/error_popup.dart";
import "package:http/http.dart" as http;
import "dart:convert";

class SingleNote extends StatefulWidget {
  const SingleNote({
    super.key,
    required this.userId,
    required this.noteId,
    required this.noteTitle,
    required this.noteContent,
    required this.toggleThemeIcon,
  });

  final int? userId;
  final int? noteId;
  final String? noteTitle;
  final String? noteContent;
  final void Function() toggleThemeIcon;

  @override
  State<SingleNote> createState() => _SingleNoteState();
}

class _SingleNoteState extends State<SingleNote> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  bool savedNote = false;

  @override
  void initState() {
    super.initState();
    print("Saved note: ${savedNote}");
    titleController = TextEditingController(text: widget.noteTitle ?? "");
    contentController = TextEditingController(text: widget.noteContent ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          iconTheme: const IconThemeData(color: Colors.black),
          actions: [
            IconButton(
              onPressed: () async {
                final endpoint =
                    widget.noteId == null ? "notes" : "notes/${widget.noteId}";
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
                  // ignore: use_build_context_synchronously
                  ErrorPopup(context, "Error",
                      "Failed to save note: ${json.decode(response.body)['message']}");
                }

                setState(() {
                  savedNote = true;
                });
              },
              icon: const Icon(Icons.save_outlined, color: Colors.black),
              tooltip: "Save",
            ),
            if (widget.noteId != null)
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.delete, color: Colors.black),
                tooltip: "Delete",
              ),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(15),
          children: [
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(
                hintText: "Title",
                border: InputBorder.none,
              ),
              style: const TextStyle(fontSize: 30),
            ),
            TextFormField(
              controller: contentController,
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
          onPressed: () {
            widget.toggleThemeIcon();
          },
          backgroundColor: Colors.amber,
          child: const Icon(Icons.brightness_4),
        ),
      ),
    );
  }
}
