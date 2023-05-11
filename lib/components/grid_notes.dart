import "package:flutter/material.dart";
import "package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart";

class GridNotes extends StatelessWidget {
  const GridNotes({super.key, required this.notes});

  final List notes;

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
            onTap: () {
              print("Pressed note with the ID ${notes[index]['id']}");
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: notes[index]["title"] != "" &&
                        notes[index]["title"] != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(notes[index]["title"],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              )),
                          Text(
                              notes[index]["content"].length > 200
                                  ? "${notes[index]['content'].substring(0, 200)}..."
                                  : notes[index]["content"],
                              style: const TextStyle(fontSize: 18)),
                        ],
                      )
                    : Text(
                        notes[index]["content"].length > 200
                            ? "${notes[index]['content'].substring(0, 200)}..."
                            : notes[index]["content"],
                        style: const TextStyle(fontSize: 18)),
              ),
            ),
          ),
        );
      },
    );
  }
}
