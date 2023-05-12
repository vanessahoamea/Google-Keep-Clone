import "package:flutter/material.dart";
import "package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart";
import "package:project/pages/single_note.dart";

class GridNotes extends StatelessWidget {
  const GridNotes({
    super.key,
    required this.notes,
    required this.getNotes,
    required this.toggleThemeIcon,
  });

  final List notes;
  final void Function() getNotes;
  final void Function() toggleThemeIcon;

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
                    toggleThemeIcon: toggleThemeIcon,
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
                  children: [
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
