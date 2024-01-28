import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:readify/type/article.dart';
import 'package:readify/type/headlines.dart';
import 'package:readify/util/network.dart';

import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleScreen extends StatefulWidget {
  final Headline headline;
  const ArticleScreen({super.key, required this.headline});

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  Article? article;

  @override
  void initState() {
    refresh();
    super.initState();
  }

  refresh() {
    context.loaderOverlay.show();
    Network.getArticle(widget.headline.id).then((value) => {
          setState(() {
            article = value;
            context.loaderOverlay.hide();
          })
        });
    Network.updateArticleUnread(widget.headline.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.headline.title),
        actions: [],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: SelectionArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: HtmlWidget(article?.content ?? ''),
                ),
              ),
            ),
          ),
          Container(
            height: 60,
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    var url = Uri.tryParse(widget.headline.link);
                    if (url != null) {
                      launchUrl(url);
                    }
                  },
                  child: const Text('Source'),
                ),
                article?.marked ?? false
                    ? IconButton(
                        onPressed: () {
                          context.loaderOverlay.show();
                          Network.updateArticleStar(widget.headline.id, false)
                              .then((value) {
                            setState(() {
                              article?.marked = false;
                              context.loaderOverlay.hide();
                            });
                          });
                        },
                        icon: const Icon(Icons.star),
                      )
                    : IconButton(
                        onPressed: () {
                          context.loaderOverlay.show();
                          Network.updateArticleStar(widget.headline.id, true)
                              .then((value) {
                            setState(() {
                              article?.marked = true;
                              context.loaderOverlay.hide();
                            });
                          });
                        },
                        icon: const Icon(Icons.star_border),
                      )
              ],
            ),
          )
        ],
      ),
    );
  }
}
