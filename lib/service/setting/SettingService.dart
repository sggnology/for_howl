import 'package:for_howl/service/setting/model/SettingModel.dart';

class SettingService {

  //<editor-fold desc="Singleton Composition">
  static final SettingService _instance = SettingService._internal();

  factory SettingService() {
    return _instance;
  }

  SettingService._internal();
  // </editor-fold>

  final SettingModel _settingModel = SettingModel(isUseScheduleSetting: false);

  SettingModel get settingModel => _settingModel;

  Future<void> init() async {
    _settingModel.init();
  }
}