import 'package:get/get.dart';
import 'package:heethings_demo/app/data/services/app.dart';
import 'package:heethings_demo/app/data/services/demo.dart';
import 'package:heethings_demo/app/data/services/mqtt.dart';

class AwaitBindings extends Bindings {
  @override
  Future<void> dependencies() async {
    Get.putAsync(() async => AppController(), permanent: true);
    Get.putAsync(() async => MqttController(), permanent: true);
    Get.putAsync(() async => DemoController(), permanent: true);
  }
}
