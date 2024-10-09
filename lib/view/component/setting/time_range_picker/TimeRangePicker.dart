import 'package:flutter/material.dart';
import 'package:for_howl/service/setting/SettingService.dart';
import 'package:for_howl/service/setting/model/schedule/ScheduleTimeSettingModel.dart';

class TimeRangePicker extends StatefulWidget {
  const TimeRangePicker({super.key});

  @override
  State<TimeRangePicker> createState() => _TimeRangePickerState();
}

class _TimeRangePickerState extends State<TimeRangePicker> {
  ScheduleTimeSettingModel scheduleTimeSettingModel =
      SettingService().settingModel.scheduleTimeSettingModel;

  TimeOfDay _startTime =
      SettingService().settingModel.scheduleTimeSettingModel.startTime;
  TimeOfDay _endTime =
      SettingService().settingModel.scheduleTimeSettingModel.endTime;

  @override
  void initState() {
    super.initState();
  }

  // 시작 시간을 선택하는 함수
  Future<void> _pickStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _startTime,
    );

    if (picked != null && picked != _startTime) {
      scheduleTimeSettingModel.updateStartTime(
        context,
        picked,
        () {
          setState(() {
            _startTime = picked;
          });
        },
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
      scheduleTimeSettingModel.updateEndTime(
        context,
        picked,
        () {
          setState(() {
            _endTime = picked;
          });
        },
      );
    }
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
            child: Text('시작: ${scheduleTimeSettingModel.startTimeString}'),
          ),
          const Text('~'),
          // 종료 시간 선택 버튼
          ElevatedButton(
            onPressed: () => _pickEndTime(context),
            child: Text('종료: ${scheduleTimeSettingModel.endTimeString}'),
          ),
        ],
      ),
    );
  }
}
