import "package:flutter/material.dart";
import "package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart";
import "package:project/pages/single_note.dart";

class GridNotes extends StatelessWidget {
  const GridNotes({
    super.key,
    required this.notes,
    required this.getNotes,
    required this.toggleTheme,
  });

  final List notes;
  final void Function() getNotes;
  final void Function() toggleTheme;

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: notes.length,
      gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(5),
          child: GestureDetector(
            onTap: () async {
              bool? reload = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SingleNote(
                    userId: null,
                    noteId: notes[index]["id"],
                    noteTitle: notes[index]["title"],
                    noteContent: notes[index]["content"],
                    noteDate: notes[index]["date_modified"],
                    toggleTheme: toggleTheme,
                  ),
                ),
              );
              if (reload != null && reload) getNotes();
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    if (notes[index]["title"] != "" &&
                        notes[index]["title"] != null)
                      Text(notes[index]["title"],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          )),
                    if (notes[index]["content"] != "" &&
                        notes[index]["content"] != null)
                      Text(
                          notes[index]["content"].length > 200
                              ? "${notes[index]['content'].substring(0, 200)}..."
                              : notes[index]["content"],
                          style: const TextStyle(fontSize: 18)),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
