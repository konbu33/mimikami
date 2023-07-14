import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:text_to_speech/text_to_speech.dart';
import 'package:url_launcher/url_launcher.dart';

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
        actions: [
          IconButton(
            icon: const Icon(Icons.open_in_browser_outlined),
            onPressed: () async {
              final uri = Uri.parse(currentArticleState.uriString);
              logger.d("uri: $uri");

              if (await canLaunchUrl(uri)) {
                await launchUrl(
                  uri,
                  mode: LaunchMode.externalApplication,
                );
              } else {
                throw 'Could not launch $uri';
              }
            },
          ),
        ],
      ),
      body: Center(
        child: TextToSpeechWidget(
          contents: currentArticleState.contents,
        ),
      ),
    );
  }
}
