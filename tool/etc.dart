part of 'grind.dart';

// @DefaultTask()
// @Depends(test)
// build() {
//   TaskArgs args = context.invocation.arguments;
//   bool isRelease = args.getFlag('release'); // will be set to true
//   String mode = args.getOption('mode') ?? ""; // will be set to topaz

//   log("execute build isRelase: $isRelease, mode: $mode");
//   // Pub.build();
// }

@Task("Test Staff")
// test() => new TestRunner().testAsync();
void test() {
  // print("execute test");
  log("execute test");
}

@Task("out file clean")
void clean() {
  log("execute clean");
}
