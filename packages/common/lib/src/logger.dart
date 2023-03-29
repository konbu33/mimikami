import 'package:logger/logger.dart';

// --------------------------------------------------
//
// ロギングのインスタンス生成し、保持
//
// --------------------------------------------------
// improve: グローバル変変になっている？
LogPrinter logPrinter = PrettyPrinter(
  printTime: true,
);

Logger logger = Logger(
  printer: logPrinter,
);

void changeLoggerLevel(String level) {
  Level newLevel = Level.debug;

  switch (level) {
    case 'debug':
      newLevel = Level.debug;
      break;

    case 'info':
      newLevel = Level.info;
      break;

    default:
  }

  logger = Logger(
    printer: logPrinter,
    level: newLevel,
  );
}
