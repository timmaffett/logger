import 'package:logger/src/log_printer.dart';
import 'package:logger/src/logger.dart';

/// Outputs a logfmt message:
/// ```
/// level=debug msg="hi there" time="2015-03-26T01:27:38-04:00" animal=walrus number=8 tag=usum
/// ```
class LogfmtPrinter extends LogPrinter {
  static final levelPrefixes = {
    Level.verbose: 'verbose',
    Level.debug: 'debug',
    Level.info: 'info',
    Level.warning: 'warning',
    Level.error: 'error',
    Level.wtf: 'wtf',
  };

  @override
  List<String> log(LogEvent event) {
    var output = StringBuffer('level=${levelPrefixes[event.level]}');
    final finalMessage = event.message is Function ? event.message() : event.message;
    if (finalMessage is String) {
      output.write(' msg="$finalMessage"');
    } else if (finalMessage is Map) {
      finalMessage.entries.forEach((entry) {
        if (entry.value is num) {
          output.write(' ${entry.key}=${entry.value}');
        } else {
          output.write(' ${entry.key}="${entry.value}"');
        }
      });
    }

    return [output.toString()];
  }
}
