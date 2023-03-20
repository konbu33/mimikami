import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'platform_state.dart';
import 'tts_repository_impl.dart';

part 'control_engine_widget.g.dart';

@riverpod
class EngineState extends _$EngineState {
  @override
  String build() {
    const initialEngine = "com.google.android.tts";
    return initialEngine;
  }

  void update(String? engine) {
    if (engine == null) return;
    state = engine;
  }
}

class ControlEngineWidget extends StatelessWidget {
  const ControlEngineWidget({super.key});

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<String>> getEnginesDropDownMenuItems(
        dynamic engines) {
      var items = <DropdownMenuItem<String>>[];
      for (dynamic type in engines) {
        items.add(DropdownMenuItem(
            value: type as String?, child: Text(type as String)));
      }
      return items;
    }

    Widget enginesDropDownSection(dynamic engines) {
      return Consumer(builder: (context, ref, child) {
        final ttsRepository = ref.watch(ttsRepositoryProvider);
        final engine = ref.watch(engineStateProvider);

        return DropdownButton(
          value: engine,
          items: getEnginesDropDownMenuItems(engines),
          onChanged: (Object? selectedEngine) async {
            await ttsRepository.setEngine(selectedEngine! as String);
            // ref
            //     .read(TextToSpeechWidgetState.languageStateProvider.notifier)
            //     .update((state) => "en-US");
            ref
                .read(engineStateProvider.notifier)
                .update(selectedEngine as String?);
          },
        );
      });
    }

    return Consumer(builder: (context, ref, child) {
      final ttsRepository = ref.watch(ttsRepositoryProvider);
      final isAndroid = ref.watch(PlatformState.isAndroidStateProvider);

      if (!isAndroid) return const SizedBox(height: 30);

      return FutureBuilder<dynamic>(
        future: ttsRepository.getEngines(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            logger.d("Engines: ${snapshot.data}");
            return enginesDropDownSection(snapshot.data);
          } else if (snapshot.hasError) {
            return const Text('Error loading engines...');
          } else {
            return const Text('Loading engines...');
          }
        },
      );
    });
  }
}
