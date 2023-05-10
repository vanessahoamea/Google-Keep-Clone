import "package:flutter/material.dart";

class AppButtons extends StatelessWidget {
  final IconData notesView;
  final void Function(IconData) toggleNotesView;

  const AppButtons({
    super.key,
    required this.notesView,
    required this.toggleNotesView,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Tooltip(
            message: "Create note",
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(15),
                backgroundColor: Colors.amber,
              ),
              child: const Icon(Icons.add, color: Colors.black),
            ),
          ),
          Tooltip(
            message: notesView == Icons.view_list ? "List view" : "Grid view",
            child: ElevatedButton(
              onPressed: () {
                if (notesView == Icons.view_list) {
                  toggleNotesView(Icons.grid_view);
                } else {
                  toggleNotesView(Icons.view_list);
                }
              },
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(15),
                backgroundColor: Colors.amber,
              ),
              child: Icon(notesView, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
