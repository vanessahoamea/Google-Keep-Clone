import "package:flutter/material.dart";
import "package:project/pages/single_note.dart";

class ListNotes extends StatelessWidget {
  const ListNotes({
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
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: notes.map((item) {
        return Padding(
          padding: const EdgeInsets.all(5),
          child: GestureDetector(
            onTap: () async {
              bool? reload = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SingleNote(
                    userId: null,
                    noteId: item["id"],
                    noteTitle: item["title"],
                    noteContent: item["content"],
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
                    if (item["title"] != "" && item["title"] != null)
                      Text(item["title"],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          )),
                    if (item["content"] != "" && item["content"] != null)
                      Text(
                          item["content"].length > 200
                              ? "${item['content'].substring(0, 200)}..."
                              : item["content"],
                          style: const TextStyle(fontSize: 18)),
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
