import "package:flutter/material.dart";

Future<String?> WarningPopup(BuildContext context, String content) {
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      content: Text(content),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(foregroundColor: Colors.blueAccent),
          onPressed: () => Navigator.pop(context, "OK"),
          child: const Text("OK"),
        ),
        TextButton(
          style: TextButton.styleFrom(foregroundColor: Colors.blueAccent),
          onPressed: () => Navigator.pop(context, "Cancel"),
          child: const Text("Cancel"),
        ),
      ],
    ),
  );
}
