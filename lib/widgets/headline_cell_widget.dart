import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:readify/screens/article_screen.dart';
import 'package:readify/type/headlines.dart';

class HeadlineCellWidget extends StatefulWidget {
  final Headline headline;
  const HeadlineCellWidget({super.key, required this.headline});

  @override
  State<HeadlineCellWidget> createState() => _HeadlineCellWidgetState();
}

class _HeadlineCellWidgetState extends State<HeadlineCellWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Text(
                widget.headline.title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Text(
                widget.headline.excerpt,
                softWrap: true,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Text(
                DateTime.fromMillisecondsSinceEpoch(
                        widget.headline.updated * 1000)
                    .toString(),
                softWrap: true,
                style: const TextStyle(color: Colors.blue),
              ),
            ),
          ),
        ],
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LoaderOverlay(
                      child: ArticleScreen(
                        headline: widget.headline,
                      ),
                    )));
      },
    );
  }
}
