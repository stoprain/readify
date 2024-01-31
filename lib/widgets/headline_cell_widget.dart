import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
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
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: widget.headline.unread ? Colors.black : Colors.grey),
              ),
            ),
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Html(
                data: widget.headline.excerpt,
                style: {
                  '*': Style(
                      color:
                          widget.headline.unread ? Colors.black : Colors.grey,
                      maxLines: 2,
                      textOverflow: TextOverflow.ellipsis)
                },
              )),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Text(
                DateTime.fromMillisecondsSinceEpoch(
                        widget.headline.updated * 1000)
                    .toString(),
                softWrap: true,
                style: TextStyle(
                    color: widget.headline.unread ? Colors.blue : Colors.grey),
              ),
            ),
          ),
        ],
      ),
      onTap: () {
        setState(() {
          widget.headline.unread = false;
        });

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
