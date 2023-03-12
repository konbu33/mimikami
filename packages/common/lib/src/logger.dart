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
