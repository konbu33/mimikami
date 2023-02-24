import 'package:article/article.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'design_layer_widget.dart';

class RoutingLayerWidget extends StatelessWidget {
  const RoutingLayerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: goRouter,
      builder: (context, child) {
        return DesignLayerWidget(
          child:
              child ?? const Scaffold(body: Center(child: Text('Loading...'))),
        );
      },
    );
  }
}

GoRouter goRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const ArticlePage(),
      routes: [
        GoRoute(
          path: 'article/:id',
          builder: (context, state) => ArticleDetailPage(
            articleId: state.params['id'] ?? "",
          ),
        ),
      ],
    ),
  ],
);
