import 'package:flutter/material.dart';
import 'package:for_howl/service/setting/model/schedule/ScheduleDateSettingModel.dart';
import 'package:for_howl/service/setting/model/schedule/ScheduleTimeSettingModel.dart';

class SettingModel {

  final ScheduleDateSettingModel _scheduleDateSettingModel = ScheduleDateSettingModel(
    stringForDays: ["월", "화", "수", "목", "금", "토", "일"],
    checkedDates: List.generate(7, (index) => 0),
  );

  final ScheduleTimeSettingModel _scheduleTimeSettingModel = ScheduleTimeSettingModel(
    startTime: const TimeOfDay(hour: 10, minute: 0),
    endTime: const TimeOfDay(hour: 18, minute: 0),
  );

  ScheduleDateSettingModel get scheduleDateSettingModel => _scheduleDateSettingModel;
  ScheduleTimeSettingModel get scheduleTimeSettingModel => _scheduleTimeSettingModel;

  Future<void> init() async {
    await _scheduleDateSettingModel.init();
    await _scheduleTimeSettingModel.init();
  }
}
