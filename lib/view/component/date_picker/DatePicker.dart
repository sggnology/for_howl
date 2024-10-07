import 'package:flutter/material.dart';
import 'package:for_howl/service/shared_preference/SharedPreferenceKey.dart';
import 'package:for_howl/service/shared_preference/SharedPreferenceKey.dart';
import 'package:for_howl/service/shared_preference/SharedPreferenceKey.dart';
import 'package:for_howl/service/shared_preference/SharedPreferenceService.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({super.key});

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {

  List<String> dateTextList = ['월', '화', '수', '목', '금', '토', '일'];
  List<int> dateList = List.generate(7, (index) => 0);

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    List<String>? dateListString =
        SharedPreferencesService().getStringList(SharedPreferenceKey.SCHEDULED_START_TIME_KEY);

    if (dateListString != null) {
      dateList = dateListString.map((e) => int.parse(e)).toList();
    } else {
      SharedPreferencesService().setStringList(
        SharedPreferenceKey.SCHEDULED_START_TIME_KEY,
        dateList.map((e) => e.toString()).toList(),
      );
    }
  }

  void setDateInfo(int index) {
    if (dateList[index] == 0) {
      setState(() {
        dateList[index] = 1;
      });
    } else {
      setState(() {
        dateList[index] = 0;
      });
    }

    SharedPreferencesService().setStringList(
      SharedPreferenceKey.SCHEDULED_START_TIME_KEY,
      dateList.map((e) => e.toString()).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        for (int i = 0; i < dateList.length; i++)
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: const Size(50, 50),
              backgroundColor: dateList[i] == 0 ? Colors.white : Colors.black,
            ),
            onPressed: () => setDateInfo(i),
            child: Text(
              dateTextList[i],
              style: TextStyle(
                color: dateList[i] == 0 ? Colors.black : Colors.white,
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
