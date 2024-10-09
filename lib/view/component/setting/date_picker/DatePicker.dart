import 'package:flutter/material.dart';
import 'package:for_howl/service/setting/SettingService.dart';
import 'package:for_howl/service/setting/model/schedule/ScheduleDateSettingModel.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({super.key});

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  ScheduleDateSettingModel scheduleDateSettingModel =
      SettingService().settingModel.scheduleDateSettingModel;

  final List<String> stringForDays =
      SettingService().settingModel.scheduleDateSettingModel.stringForDays;
  List<int> checkedDates =
      SettingService().settingModel.scheduleDateSettingModel.checkedDates;

  @override
  void initState() {
    super.initState();
  }

  void setDateInfo(int index) {
    int value = 0;

    if (checkedDates[index] == 0) {
      value = 1;
    } else {
      value = 0;
    }

    scheduleDateSettingModel.updateCheckedDates(
      index,
      value,
      () {
        setState(() {
          checkedDates[index] = value;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        for (int i = 0; i < stringForDays.length; i++)
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: const Size(50, 50),
              backgroundColor:
                  checkedDates[i] == 0 ? Colors.white : Colors.black,
            ),
            onPressed: () => setDateInfo(i),
            child: Text(
              stringForDays[i],
              style: TextStyle(
                color: checkedDates[i] == 0 ? Colors.black : Colors.white,
              ),
            ),
          ),
      ],
    );
    //   FutureBuilder(
    //
    //   future: init(),
    //   builder: (context, snapshot) {
    //     if(snapshot.connectionState == ConnectionState.done){
    //
    //     }
    //     else{
    //       return const Row(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           SizedBox(
    //             width: 50,
    //             height: 50,
    //             child: CircularProgressIndicator(),
    //           ),
    //         ],
    //       );
    //     }
    //   },
    // );
  }
}
