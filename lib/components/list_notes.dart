import "package:flutter/material.dart";

class ListNotes extends StatelessWidget {
  const ListNotes({super.key, required this.notes});

  final List notes;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: notes.map((item) {
        return Padding(
          padding: const EdgeInsets.all(5),
          child: GestureDetector(
            onTap: () {
              print("Pressed note $item");
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text("Test $item"),
            ),
          ),
        );
      }).toList(),
    );
  }
}
