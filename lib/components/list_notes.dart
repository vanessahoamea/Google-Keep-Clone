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
              print("Pressed note with the ID ${item['id']}");
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: item["title"] != "" && item["title"] != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item["title"],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              )),
                          Text(
                              item["content"].length > 200
                                  ? "${item['content'].substring(0, 200)}..."
                                  : item["content"],
                              style: const TextStyle(fontSize: 18)),
                        ],
                      )
                    : Text(
                        item["content"].length > 200
                            ? "${item['content'].substring(0, 200)}..."
                            : item["content"],
                        style: const TextStyle(fontSize: 18)),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
