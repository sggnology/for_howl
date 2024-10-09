import 'package:flutter/material.dart';
import 'package:for_howl/service/setting/model/schedule/ScheduleDateSettingModel.dart';
import 'package:for_howl/service/setting/model/schedule/ScheduleTimeSettingModel.dart';
import 'package:for_howl/service/shared_preference/SharedPreferenceKey.dart';
import 'package:for_howl/service/shared_preference/SharedPreferenceService.dart';

class SettingModel {

  bool _isUseScheduleSetting = false;

  bool get isUseScheduleSetting => _isUseScheduleSetting;

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

  SettingModel({
    required isUseScheduleSetting,
  });

  Future<void> init() async {

    bool? preRegisteredIsUseScheduleSetting = SharedPreferencesService()
        .getBool(SharedPreferenceKey.IS_USE_SCHEDULE_SETTING);

    if(preRegisteredIsUseScheduleSetting == null) {
      SharedPreferencesService().setBool(
        SharedPreferenceKey.IS_USE_SCHEDULE_SETTING,
        _isUseScheduleSetting,
      );
    }
    else{
      _isUseScheduleSetting = preRegisteredIsUseScheduleSetting;
    }

    await _scheduleDateSettingModel.init();
    await _scheduleTimeSettingModel.init();
  }

  void updateIsUseScheduleSetting(bool value, VoidCallback cb) {
    _isUseScheduleSetting = value;

    SharedPreferencesService().setBool(
      SharedPreferenceKey.IS_USE_SCHEDULE_SETTING,
      _isUseScheduleSetting,
    );

    cb();
  }
}
