import "package:flutter/material.dart";

void ErrorPopup(BuildContext context, String title, String content) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(title),
      content: Text(content),
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
