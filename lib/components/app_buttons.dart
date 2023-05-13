import "package:flutter/material.dart";
import "package:project/pages/single_note.dart";

class AppButtons extends StatefulWidget {
  const AppButtons({
    super.key,
    required this.notesView,
    required this.toggleNotesView,
    required this.getNotes,
    required this.userId,
    required this.toggleTheme,
  });

  final IconData notesView;
  final void Function(IconData) toggleNotesView;
  final void Function() getNotes;
  final int? userId;
  final void Function() toggleTheme;

  @override
  State<AppButtons> createState() => _AppButtonsState();
}

class _AppButtonsState extends State<AppButtons> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // add new note button
          Tooltip(
            message: "Create note",
            child: ElevatedButton(
              onPressed: () async {
                bool? reload = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SingleNote(
                        userId: widget.userId,
                        noteId: null,
                        noteTitle: null,
                        noteContent: null,
                        noteDate: null,
                        toggleTheme: widget.toggleTheme,
                      ),
                    ));
                if (reload != null && reload) widget.getNotes();
              },
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(15),
                backgroundColor: Colors.amber,
              ),
              child: const Icon(Icons.add, color: Colors.black),
            ),
          ),

          // toggle notes view button
          Tooltip(
            message:
                widget.notesView == Icons.view_list ? "List view" : "Grid view",
            child: ElevatedButton(
              onPressed: () {
                if (widget.notesView == Icons.view_list) {
                  widget.toggleNotesView(Icons.grid_view);
                } else {
                  widget.toggleNotesView(Icons.view_list);
                }
              },
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(15),
                backgroundColor: Colors.amber,
              ),
              child: Icon(widget.notesView, color: Colors.black),
            ),
          ),

          // refresh notes button
          Tooltip(
            message: "Refresh",
            child: ElevatedButton(
              onPressed: () => widget.getNotes(),
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(15),
                backgroundColor: Colors.amber,
              ),
              child: const Icon(Icons.refresh, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
