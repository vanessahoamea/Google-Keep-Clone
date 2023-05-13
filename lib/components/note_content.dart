import "package:flutter/material.dart";

class NoteContent extends StatelessWidget {
  const NoteContent({
    super.key,
    required this.titleController,
    required this.contentController,
    required this.noteTitle,
    required this.noteContent,
    required this.noteDate,
    required this.isChanged,
  });

  final TextEditingController titleController;
  final TextEditingController contentController;
  final String? noteTitle;
  final String? noteContent;
  final String? noteDate;
  final void Function(String, String?) isChanged;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(15),
      children: <Widget>[
        // last modified date
        if (noteDate != null)
          Text(
            "Edited ${noteDate!.split(' ')[0]}",
            style: const TextStyle(color: Colors.grey),
            textAlign: TextAlign.right,
          ),

        // note title
        TextFormField(
          controller: titleController,
          onChanged: (text) => isChanged(text, noteTitle),
          decoration: const InputDecoration(
            hintText: "Title",
            border: InputBorder.none,
          ),
          style: const TextStyle(fontSize: 30),
        ),

        // note content
        TextFormField(
          controller: contentController,
          onChanged: (text) => isChanged(text, noteContent),
          decoration: const InputDecoration(
            hintText: "Take a note...",
            border: InputBorder.none,
          ),
          keyboardType: TextInputType.multiline,
          maxLines: null,
          style: const TextStyle(fontSize: 20),
        ),
      ],
    );
  }
}
