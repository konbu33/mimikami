import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'platform_state.dart';
import 'text_to_speech_widget_state.dart';
import 'tts_repository_impl.dart';

final engineStateProvider =
    StateProvider<String?>((ref) => "com.google.android.tts");

// final engineStateProvider = StateProvider<String?>((ref) {
//   final ttsRepository = ref.watch(ttsRepositoryProvider);
//   return ttsRepository.getDefaultEngine() as String?;
// });

class EngineListWidget extends StatelessWidget {
  const EngineListWidget({super.key});

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

        return Container(
          padding: const EdgeInsets.only(top: 50.0),
          child: DropdownButton(
            value: engine,
            items: getEnginesDropDownMenuItems(engines),
            onChanged: (Object? selectedEngine) async {
              await ttsRepository.setEngine(selectedEngine! as String);
              ref
                  .read(TextToSpeechWidgetState.languageStateProvider.notifier)
                  .update((state) => "en-US");
              ref
                  .read(engineStateProvider.notifier)
                  .update((state) => selectedEngine as String?);
            },
          ),
        );
      });
    }

    return Consumer(builder: (context, ref, child) {
      final ttsRepository = ref.watch(ttsRepositoryProvider);
      final isAndroid = ref.watch(PlatformState.isAndroidStateProvider);

      if (!isAndroid) return const SizedBox(width: 0, height: 0);

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
