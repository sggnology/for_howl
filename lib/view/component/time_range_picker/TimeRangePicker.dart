import 'package:flutter/material.dart';
import 'package:for_howl/service/shared_preference/SharedPreferenceKey.dart';
import 'package:for_howl/service/shared_preference/SharedPreferenceService.dart';

class TimeRangePicker extends StatefulWidget {
  const TimeRangePicker({super.key});

  @override
  State<TimeRangePicker> createState() => _TimeRangePickerState();
}

class _TimeRangePickerState extends State<TimeRangePicker> {
  TimeOfDay _startTime = const TimeOfDay(hour: 10, minute: 0);
  TimeOfDay _endTime = const TimeOfDay(hour: 18, minute: 0);

  @override
  void initState() {
    super.initState();

    init();
  }

  Future<void> init() async {
    _startTime = SharedPreferencesService()
                .getString(SharedPreferenceKey.SCHEDULED_START_TIME_KEY) !=
            null
        ? TimeOfDay(
            hour: int.parse(
              SharedPreferencesService()
                  .getString(SharedPreferenceKey.SCHEDULED_START_TIME_KEY)!
                  .split(":")[0],
            ),
            minute: int.parse(
              SharedPreferencesService()
                  .getString(SharedPreferenceKey.SCHEDULED_START_TIME_KEY)!
                  .split(":")[1],
            ),
          )
        : _startTime;

    _endTime = SharedPreferencesService()
                .getString(SharedPreferenceKey.SCHEDULED_START_TIME_KEY) !=
            null
        ? TimeOfDay(
            hour: int.parse(
              SharedPreferencesService()
                  .getString(SharedPreferenceKey.SCHEDULED_START_TIME_KEY)!
                  .split(":")[0],
            ),
            minute: int.parse(
              SharedPreferencesService()
                  .getString(SharedPreferenceKey.SCHEDULED_START_TIME_KEY)!
                  .split(":")[1],
            ),
          )
        : _endTime;
  }

  // 시간을 문자열 HH:mm 형식으로 변환하는 함수
  String _formatTimeOfDay(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  // 시작 시간을 선택하는 함수
  Future<void> _pickStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _startTime,
    );
    if (picked != null && picked != _startTime) {
      var pickedToNumber = picked.hour * 60 + picked.minute;
      var endTimeToNumber = _endTime.hour * 60 + _endTime.minute;

      if (pickedToNumber > endTimeToNumber) {
        _showAlertDialog();
        return;
      }

      setState(() {
        _startTime = picked;
      });

      SharedPreferencesService().setString(
        SharedPreferenceKey.SCHEDULED_START_TIME_KEY,
        _formatTimeOfDay(_startTime),
      );
    }
  }

  // 종료 시간을 선택하는 함수
  Future<void> _pickEndTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _endTime,
    );
    if (picked != null && picked != _endTime) {
      var pickedToNumber = picked.hour * 60 + picked.minute;
      var startTimeToNumber = _startTime.hour * 60 + _startTime.minute;

      if (pickedToNumber < startTimeToNumber) {
        _showAlertDialog();
        return;
      }

      setState(() {
        _endTime = picked;
      });

      SharedPreferencesService().setString(
        SharedPreferenceKey.SCHEDULED_END_TIME_KEY,
        _formatTimeOfDay(_endTime),
      );
    }
  }

  void _showAlertDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('오류'),
          content: const Text('종료 시간이 시작 시간보다 빠를 수 없습니다.'),
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          // 시작 시간 선택 버튼
          ElevatedButton(
            onPressed: () => _pickStartTime(context),
            child: Text('시작: ${_formatTimeOfDay(_startTime)}'),
          ),
          Text('~'),
          // 종료 시간 선택 버튼
          ElevatedButton(
            onPressed: () => _pickEndTime(context),
            child: Text('종료: ${_formatTimeOfDay(_endTime)}'),
          ),
        ],
      ),
    );
  }
}
