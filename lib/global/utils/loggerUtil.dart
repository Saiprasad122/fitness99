import 'package:logger/logger.dart';

abstract class LoggerUtils {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2, // number of method calls to be displayed
      errorMethodCount: 8, // number of method calls if stacktrace is provided
      lineLength: 60, // width of the output
      colors: true, // Colorful log messages
      printEmojis: true, // Print an emoji for each log message
      printTime: true, // Should each log print contain a timestamp
    ),
  );
  static void logVerbose(Object msg) {
    _logger.v('🤯🤯🤯🤯🤯🤯🤯🤯🤯🤯🤯🤯 \n $msg \n 🤯🤯🤯🤯🤯🤯🤯🤯🤯🤯🤯🤯');
  }

  static void logDebug(Object msg) {
    _logger.d('🐛🐛🐛🐛🐛🐛🐛🐛🐛🐛🐛🐛 \n $msg \n 🐛🐛🐛🐛🐛🐛🐛🐛🐛🐛🐛🐛');
  }

  static void logError(Object msg, {Object? error, StackTrace? stackTrace}) {
    _logger.e('❌❌❌❌❌❌❌❌❌❌❌❌ \n $msg \n ❌❌❌❌❌❌❌❌❌❌❌❌', error, stackTrace);
  }

  static void logInfo(Object msg) {
    _logger
        .i('❕❕❕❕❕❕❕❕❕❕❕❕❕❕❕❕❕❕❕❕❕❕❕❕❕❕  \n $msg \n ❕❕❕❕❕❕❕❕❕❕❕❕❕❕❕❕❕❕❕❕❕❕❕❕❕❕');
  }

  static void logWarning(Object msg) {
    _logger.w('⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️ \n $msg \n ⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️');
  }

  static void logWTF(Object msg) {
    _logger.wtf('🚫🚫🚫🚫🚫🚫🚫🚫🚫🚫🚫🚫 \n $msg \n 🚫🚫🚫🚫🚫🚫🚫🚫🚫🚫🚫🚫');
  }
}
