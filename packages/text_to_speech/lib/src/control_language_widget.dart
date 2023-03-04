import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'platform_state.dart';
import 'text_to_speech_widget_state.dart';
import 'tts_repository_impl.dart';

final isCurrentLanguageInstalledStateProvider =
    StateProvider<bool>((ref) => false);

class ControlLanguageWidget extends StatelessWidget {
  const ControlLanguageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<String>> getLanguageDropDownMenuItems(
        dynamic languages) {
      var items = <DropdownMenuItem<String>>[];
      for (dynamic type in languages) {
        items.add(DropdownMenuItem(
            value: type as String?, child: Text(type as String)));
      }
      return items;
    }

    Widget languageDropDownSection(dynamic languages) {
      return Consumer(
        builder: (context, ref, child) {
          final language =
              ref.watch(TextToSpeechWidgetState.languageStateProvider);
          final isAndroid = ref.watch(PlatformState.isAndroidStateProvider);
          final ttsRepository = ref.watch(ttsRepositoryProvider);
          final isCurrentLanguageInstalled =
              ref.watch(isCurrentLanguageInstalledStateProvider);

          return Container(
            padding: const EdgeInsets.only(top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton(
                  value: language,
                  items: getLanguageDropDownMenuItems(languages),
                  onChanged: (String? selectedType) {
                    ref
                        .read(TextToSpeechWidgetState
                            .languageStateProvider.notifier)
                        .update((state) => selectedType);

                    ttsRepository.setLanguage(language!);
                    if (isAndroid) {
                      ttsRepository.isLanguageInstalled(language).then((value) {
                        ref
                            .read(isCurrentLanguageInstalledStateProvider
                                .notifier)
                            .update((state) => value as bool);
                      });
                    }
                  },
                ),
                Visibility(
                  visible: isAndroid,
                  child: Text("Is installed: $isCurrentLanguageInstalled"),
                ),
              ],
            ),
          );
        },
      );
    }

    return Consumer(builder: (context, ref, child) {
      final ttsRepository = ref.watch(ttsRepositoryProvider);

      return FutureBuilder<dynamic>(
          future: ttsRepository.getLanguages(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              return languageDropDownSection(snapshot.data);
            } else if (snapshot.hasError) {
              return const Text('Error loading languages...');
            } else {
              return const Text('Loading Languages...');
            }
          });
    });
  }
}
