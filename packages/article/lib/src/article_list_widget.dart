import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'article_state.dart';
import 'article_state_list.dart';

// --------------------------------------------------
//
// ArticleListWidget
//
// --------------------------------------------------
class ArticleListWidget extends StatelessWidget {
  const ArticleListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        //

        // trigger：他アプリからURLがShareされてきたら、記事を記事一覧へ追加する。
        ref.watch(reflectAddArticleStateListProvider);

        // trigger：記事一覧に新規追加された記事を、ローカルDBへ保存する。
        ref.watch(reflectAddArticleStateToLocaDbProvider);

        // ref.invalidate(articleStateListNotifierProvider);
        ref.invalidate(articleStateListNotifierProvider);
        // ref.refresh(articleStateListNotifierProvider);
        final articleStateListNotifier =
            ref.watch(articleStateListNotifierProvider);

        return ListView.builder(
          itemCount: articleStateListNotifier.value.length,
          itemBuilder: (context, index) {
            final articleState = articleStateListNotifier.value[index];
            return ArticleWidget(articleState: articleState);
          },
          padding: const EdgeInsets.all(10),
        );
      },
    );
  }
}

// --------------------------------------------------
//
// ArticleWidget
//
// --------------------------------------------------
class ArticleWidget extends StatelessWidget {
  const ArticleWidget({super.key, required this.articleState});

  final ArticleState articleState;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(3),
      child: ListTile(
        title: Text(articleState.title),
        onTap: () {
          context.go("/article/${articleState.id}");
        },
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          side: BorderSide(
            color: Colors.grey,
            width: 1,
          ),
        ),
      ),
    );
  }
}
