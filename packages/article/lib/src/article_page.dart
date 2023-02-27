import 'package:flutter/material.dart';
import 'package:receive_share/receive_share.dart';

import 'article_list_widget.dart';

class ArticlePage extends StatelessWidget {
  const ArticlePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: ArticlePageParts.title(),
        ),
        body: Column(
          children: [
            Expanded(child: ArticlePageParts.articleList()),
            ArticlePageParts.receiveShareUrl(),
          ],
        ));
  }
}

class ArticlePageParts {
  static Widget title() {
    const widget = Text(ArticlePageState.title);
    return widget;
  }

  static Widget articleList() {
    const widget = ArticleListWidget();
    return widget;
  }

  static Widget receiveShareUrl() {
    const widget = ReceiveShareWidget();
    return widget;
  }
}

class ArticlePageState {
  static const title = "article page";
}
