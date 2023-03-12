import 'package:article/src/article_repository.dart';
import 'package:article/src/article_state.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:receive_share/receive_share.dart';

import 'article_list_widget.dart';

// --------------------------------------------------
//
// ArticlePageState
//
// --------------------------------------------------
class ArticlePageState {
  static const title = "article page";
}

// --------------------------------------------------
//
// ArticlePage
//
// --------------------------------------------------
class ArticlePage extends StatelessWidget {
  const ArticlePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ArticlePageParts.title(),
      ),
      body: Consumer(builder: (context, ref, child) {
        return Column(
          children: [
            Expanded(child: ArticlePageParts.articleList()),

            // このWidgetで、他アプリからShareしてもらったURLを受け取る。
            ArticlePageParts.receiveShareWidget(),

            // local Db
            ArticlePageParts.localDbWidget(),
          ],
        );
      }),
    );
  }
}

// --------------------------------------------------
//
// ArticlePageParts
//
// --------------------------------------------------
class ArticlePageParts {
  //

  // --------------------------------------------------
  // title
  // --------------------------------------------------
  static Widget title() {
    const widget = Text(ArticlePageState.title);
    return widget;
  }

  // --------------------------------------------------
  // articleList
  // --------------------------------------------------
  static Widget articleList() {
    const widget = ArticleListWidget();
    return widget;
  }

  // --------------------------------------------------
  // receiveShareWidget
  // --------------------------------------------------
  // このWidgetで、他アプリからShareしてもらったURLを受け取る。
  static Widget receiveShareWidget() {
    const widget = ReceiveShareWidget();
    return widget;
  }

  // --------------------------------------------------
  // localDbWidget
  // --------------------------------------------------
  static Widget localDbWidget() {
    final widget = Consumer(builder: (context, ref, child) {
      // final localDb = ref.watch(localDbDriftProvider);
      // ref.watch(driftDbProvider);
      // ref.watch(articleRepositoryProvider);
      // final articleRepository = ref.watch(articleRepositoryProvider.notifier);
      final articleRepository = ref.watch(articleRepositoryProvider);

      return ElevatedButton(
        onPressed: () async {
          final artcileState = ArticleState.create(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            uriString: "uriString",
            title: "title",
            contents: "contents",
          );

          await articleRepository.addArticle(articleState: artcileState);

          final res = await articleRepository.getAllarticles();
          logger.d("localDbDrift data : $res");

          // await articleRepository.close();
        },
        child: const Text("insert DB"),
      );
    });
    return widget;
  }
}
