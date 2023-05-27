import 'package:flutter/material.dart';

class CustomTopBar extends StatelessWidget {
  final String contentType;
  final String source;

  const CustomTopBar(
      {Key? key, required this.contentType, required this.source})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      leading: const BackButton(color: Color.fromARGB(255, 156, 149, 122)),
      backgroundColor: Colors.transparent,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                contentType == 'podcast' ? Icons.headset : Icons.book,
                color: const Color(0xFF556B2F), // dark olive green color
                size: 16,
              ),
              const SizedBox(width: 5),
              Text(
                contentType == 'podcast'
                    ? 'An episode from'
                    : 'An article from',
                style: const TextStyle(
                  color: Color(0xFF556B2F), // dark olive green color
                  fontWeight: FontWeight.w300,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          Text(
            source,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.green[600],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0))),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.add, size: 20.0),
                Text(
                  'Subscribe',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10), // Spacing on the right
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(0.0),
        child: Divider(
          color: Colors.green[600],
          thickness: 1,
        ),
      ),
    );
  }
}
