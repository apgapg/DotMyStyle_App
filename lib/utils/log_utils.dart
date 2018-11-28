import 'package:salon/utils/app_utils.dart';

/// Prints a string representation of the object to the console.
///
/// Prints only in 'debug' mode
printLog(dynamic o, {bool upload = false, StackTrace stackTrace}) {
  if (isDebug) {
    print(o.toString() ?? "");
  }
  /*if (upload) {
    CrashUtils.logError(error: o.toString(), stackTrace: stackTrace);
  }*/
}
