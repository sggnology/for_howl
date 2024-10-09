import 'package:flutter/material.dart';
import 'package:for_howl/service/setting/SettingService.dart';

class DecideIsUseSchedule extends StatefulWidget {
  const DecideIsUseSchedule({super.key});

  @override
  State<DecideIsUseSchedule> createState() => _DecideIsUseScheduleState();
}

class _DecideIsUseScheduleState extends State<DecideIsUseSchedule> {

  bool isUseSchedule = SettingService().settingModel.isUseScheduleSetting;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('스케줄 사용 여부'),
        Switch(
          value: isUseSchedule,
          onChanged: (value) {
            SettingService().settingModel.updateIsUseScheduleSetting(
              value,
              () {
                setState(() {
                  isUseSchedule = value;
                });
              },
            );
          },
        ),
      ],
    );
  }
}
