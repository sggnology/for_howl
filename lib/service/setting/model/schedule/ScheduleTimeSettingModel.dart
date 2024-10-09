import 'package:flutter/material.dart';
import 'package:for_howl/service/setting/model/schedule/ScheduleSettingModel.dart';
import 'package:for_howl/service/shared_preference/SharedPreferenceKey.dart';
import 'package:for_howl/service/shared_preference/SharedPreferenceService.dart';

class ScheduleTimeSettingModel extends ScheduleSettingModel {
  final String _START_TIME_NOT_BIGGER_THAN_END_TIME_VALIDATED_MESSAGE =
      "시작 시간이 종료 시간보다 늦을 수 없습니다.";

  TimeOfDay _startTime;

  TimeOfDay get startTime => _startTime;
  String get startTimeString => _formatTimeOfDay(_startTime);

  TimeOfDay _endTime;

  TimeOfDay get endTime => _endTime;
  String get endTimeString => _formatTimeOfDay(_endTime);

  ScheduleTimeSettingModel({
    required TimeOfDay startTime,
    required TimeOfDay endTime,
  })  : _startTime = startTime,
        _endTime = endTime;

  @override
  Future<void> init() async {
    var preRegisteredStartTime = SharedPreferencesService()
        .getString(SharedPreferenceKey.SCHEDULED_START_TIME_KEY);
    var preRegisteredEndTime = SharedPreferencesService()
        .getString(SharedPreferenceKey.SCHEDULED_END_TIME_KEY);

    if (preRegisteredStartTime == null) {
      SharedPreferencesService().setString(
        SharedPreferenceKey.SCHEDULED_START_TIME_KEY,
        _formatTimeOfDay(_startTime),
      );
    } else {
      _startTime = _parseHHmmToTimeOfDay(preRegisteredStartTime);
    }

    if (preRegisteredEndTime == null) {
      SharedPreferencesService().setString(
        SharedPreferenceKey.SCHEDULED_END_TIME_KEY,
        _formatTimeOfDay(_endTime),
      );
    } else {
      _endTime = _parseHHmmToTimeOfDay(preRegisteredEndTime);
    }
  }

  // 문자열 `HH:mm` 형식을 TimeOfDay로 변환하는 함수
  TimeOfDay _parseHHmmToTimeOfDay(String time) {
    var hourAndMinute = time.split(":");

    var hour = int.parse(hourAndMinute[0]);
    var minute = int.parse(hourAndMinute[1]);

    return TimeOfDay(
      hour: hour,
      minute: minute,
    );
  }

  // 시간을 문자열 `HH:mm` 형식으로 변환하는 함수
  String _formatTimeOfDay(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  void updateStartTime(
      BuildContext context, TimeOfDay newStartTime, VoidCallback cb) {
    if (_validateTimeCorrectness(context, newStartTime, _endTime) == false) {
      _showValidateResult(
        context,
        _START_TIME_NOT_BIGGER_THAN_END_TIME_VALIDATED_MESSAGE,
      );
    }

    _startTime = newStartTime;

    SharedPreferencesService().setString(
      SharedPreferenceKey.SCHEDULED_START_TIME_KEY,
      _formatTimeOfDay(_startTime),
    );

    cb();
  }

  void updateEndTime(
      BuildContext context, TimeOfDay newEndTime, VoidCallback cb) {
    if (_validateTimeCorrectness(context, _startTime, newEndTime) == false) {
      _showValidateResult(
        context,
        _START_TIME_NOT_BIGGER_THAN_END_TIME_VALIDATED_MESSAGE,
      );
    }

    _endTime = newEndTime;

    SharedPreferencesService().setString(
      SharedPreferenceKey.SCHEDULED_END_TIME_KEY,
      _formatTimeOfDay(_endTime),
    );

    cb();
  }

  bool _validateTimeCorrectness(
      BuildContext context, TimeOfDay startTime, TimeOfDay endTime) {
    var startTimeToMinute = startTime.hour * 60 + startTime.minute;
    var endTimeToMinute = endTime.hour * 60 + endTime.minute;

    if (endTimeToMinute < startTimeToMinute) {
      return false;
    }

    return true;
  }

  void _showValidateResult(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('오류'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('확인'),
            ),
          ],
        );
      },
    );
  }
}
