part of 'grind.dart';

@Task("build_runner watch -d")
void br() {
  const command = "flutter pub run build_runner watch -d";
  runCommand(command: command);
}

@Task("build_runner build -d")
void brb() {
  const command = "flutter pub run build_runner build -d";
  runCommand(command: command);
}

// @Task("fluter pub run build_runner")
// br() {
//   run(
//     "flutter",
//     arguments: [
//       "pub",
//       "run",
//       "build_runner",
//       "watch",
//       "-d",
//     ],
//   );
// }
