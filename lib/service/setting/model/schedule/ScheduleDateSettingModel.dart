import 'package:flutter/material.dart';
import 'package:for_howl/service/setting/model/schedule/ScheduleSettingModel.dart';
import 'package:for_howl/service/shared_preference/SharedPreferenceKey.dart';
import 'package:for_howl/service/shared_preference/SharedPreferenceService.dart';

class ScheduleDateSettingModel extends ScheduleSettingModel {

  List<String> _stringForDays;
  List<int> _checkedDates;

  List<String> get stringForDays => _stringForDays;

  List<int> get checkedDates => _checkedDates;

  ScheduleDateSettingModel({
    required List<String> stringForDays,
    required List<int> checkedDates,
  })  : _stringForDays = stringForDays,
        _checkedDates = checkedDates;

  @override
  Future<void> init() async {
    var preRegisteredCheckedDates = SharedPreferencesService()
        .getStringList(SharedPreferenceKey.SCHEDULED_DATE_LIST_KEY)
        ?.map((e) => int.parse(e));

    if (preRegisteredCheckedDates == null) {
      SharedPreferencesService().setStringList(
        SharedPreferenceKey.SCHEDULED_DATE_LIST_KEY,
        _checkedDates.map((e) => e.toString()).toList(),
      );
    } else {
      _checkedDates = preRegisteredCheckedDates.toList();
    }
  }

  void updateCheckedDates(int index, int value, VoidCallback cb) {
    _checkedDates[index] = value;

    SharedPreferencesService().setStringList(
      SharedPreferenceKey.SCHEDULED_DATE_LIST_KEY,
      _checkedDates.map((e) => e.toString()).toList(),
    );

    cb();
  }
}
