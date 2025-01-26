import 'package:logger/logger.dart';

class AppLogger {
  static final logger = Logger();

  ///
  /// Print error message to the console.
  ///
  static void e(dynamic message) {
    String error = message is String ? message : message.toString();
    logger.e(error);
  }

  ///
  /// Print warning message to the console.
  ///
  static void i(dynamic message) {
    String info = message is String ? message : message.toString();
    logger.i(info);
  }
}
