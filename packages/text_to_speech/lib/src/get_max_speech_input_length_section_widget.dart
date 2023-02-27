import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'tts_repository_impl.dart';

final inputLengthStateProvider = StateProvider<int?>((ref) => 0);

class GetMaxSpeechInputLengthSectionWidget extends StatelessWidget {
  const GetMaxSpeechInputLengthSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final ttsRepository = ref.watch(ttsRepositoryProvider);

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            child: const Text('Get max speech input length'),
            onPressed: () async {
              final inputLength = await ttsRepository.getMaxSpeechInputLength();
              ref
                  .read(inputLengthStateProvider.notifier)
                  .update((state) => inputLength);

              // setState(() {});
            },
          ),
          Text("${ref.watch(inputLengthStateProvider)} characters"),
        ],
      );
    });
  }
}
