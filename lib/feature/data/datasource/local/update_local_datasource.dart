import 'package:shared_preferences/shared_preferences.dart';

const _lastUpdatedDateTime = "LAST_UPDATED_TIME";

abstract interface class UpdateLocalDatasource {
  Future<void> setUpdatedTime(DateTime dateTime);

  Future<DateTime?> getUpdatedTime();
}

final class UpdateLocalDatasourceImpl implements UpdateLocalDatasource {
  final SharedPreferences _sharedPreferences;

  const UpdateLocalDatasourceImpl(this._sharedPreferences);

  @override
  Future<DateTime?> getUpdatedTime() async {
    final date = _sharedPreferences.getString(_lastUpdatedDateTime);
    if (date == null) return null;
    return DateTime.parse(date);
  }

  @override
  Future<void> setUpdatedTime(DateTime dateTime) async {
    _sharedPreferences.setString(
        _lastUpdatedDateTime, dateTime.toIso8601String());
  }
}
