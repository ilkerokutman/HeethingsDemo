import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heethings_demo/app/core/constants/keys.dart';
import 'package:heethings_demo/app/core/utils/box.dart';
import 'package:heethings_demo/app/core/utils/common.dart';
import 'package:heethings_demo/app/data/services/mqtt.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AppController extends GetxController {
  //

  @override
  void onReady() async {
    if (GetPlatform.isMobile) setCameras();
    super.onReady();
  }

  final RxList<CameraDescription> _cameras = <CameraDescription>[].obs;
  List<CameraDescription> get cameras => _cameras;

  final Rx<TextEditingController> _existingDemoIdTextController =
      TextEditingController().obs;
  TextEditingController get existingDemoIdTextController =>
      _existingDemoIdTextController.value;

  MaskTextInputFormatter get existingDemoIdMaskFormatter =>
      MaskTextInputFormatter(
        mask: 'XXX-XXXX-XXX',
        filter: {"X": RegExp(r'[a-z]')},
      );

  FocusNode get existingDemoIdFocusNode => FocusNode();

  void setCameras() async {
    _cameras.value = await availableCameras();
    update();
  }

  Future<String> startNewDemoSession() async {
    String demoId = CommonUtils.generateDemoId();
    return await continueExistingDemoSession(demoId);
  }

  Future<String> continueExistingDemoSession(String id) async {
    final MqttController mqtt = Get.find();
    mqtt.setDemoId(id);
    await Box.setString(Keys.demoId, id);
    return id;
  }
}
