import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:text_to_speech/text_to_speech.dart';

import 'article_state_list.dart';

// --------------------------------------------------
//
// ArticleDetailPage
//
// --------------------------------------------------
class ArticleDetailPage extends HookConsumerWidget {
  const ArticleDetailPage({
    super.key,
    required this.articleId,
  });

  final String articleId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final articleStateListNotifier =
        ref.watch(articleStateListNotifierProvider);

    final currentArticleState = articleStateListNotifier.value
        .where((element) => element.id == articleId)
        .first;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          currentArticleState.title,
          style: const TextStyle(fontSize: 16),
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            TextToSpeechWidget(
              contents: currentArticleState.contents,
            ),
          ],
        ),
      ),
    );
  }
}
