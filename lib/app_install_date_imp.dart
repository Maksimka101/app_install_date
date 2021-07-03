import 'dart:async';
import 'dart:io';

import 'package:app_install_date/utils.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

/// This is a plugin class which is used to get install date of the application
///
/// Example:
/// ```dart
/// late String installDate;
/// // Platform messages may fail, so we use a try/catch PlatformException.
/// try {
///   installDate = (await AppInstallDate().installDate).toString();
/// } catch (e, st) {
///   print('Failed to load install date due to $e\n$st');
///   installDate = 'Failed to load install date';
/// }
/// ```
class AppInstallDate {
  const AppInstallDate._();
  factory AppInstallDate() => _instance;

  static const _instance = AppInstallDate._();

  static const MethodChannel _channel = MethodChannel('app_install_date');

  /// Returns the install date of the application
  ///
  /// In case when platform is Android the installation date given by the platform is used
  ///
  /// In case when platform is iOS the application document directory creation date is used.
  /// This method is used in native iOS development to determine the install date of the application
  /// https://stackoverflow.com/questions/4090512/how-to-determine-the-date-an-app-is-installed-or-used-for-the-first-time
  Future<DateTime> get installDate async {
    if (PlatformUtils.isAndroid) {
      final installDateInMilliseconds =
          await _channel.invokeMethod<int>('getInstallDate');
      if (installDateInMilliseconds != null) {
        return DateTime.fromMillisecondsSinceEpoch(installDateInMilliseconds);
      } else {
        throw FailedToGetInstallDateException(
            'Install time from platform is null');
      }
    } else {
      return _getInstallDate();
    }
  }

  /// Returns application documents directory creation time
  ///
  /// This method is used in native iOS development to determine the install date of the application
  /// https://stackoverflow.com/questions/4090512/how-to-determine-the-date-an-app-is-installed-or-used-for-the-first-time
  Future<DateTime> _getInstallDate() async {
    var applicationDocumentsDirectory =
        await getApplicationDocumentsDirectory();
    var stat = await FileStat.stat(applicationDocumentsDirectory.path);
    return stat.accessed;
  }
}

/// This exception is thrown when it is failed to get install date
class FailedToGetInstallDateException {
  FailedToGetInstallDateException(this.reason);

  final String reason;

  @override
  String toString() => reason;
}
