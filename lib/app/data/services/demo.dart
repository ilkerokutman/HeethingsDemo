import 'package:get/get.dart';
import 'package:heethings_demo/app/core/constants/enums.dart';
import 'package:heethings_demo/app/core/constants/mqtt.dart';
import 'package:heethings_demo/app/data/models/demo.dart';
import 'package:heethings_demo/app/data/services/mqtt.dart';

class DemoController extends GetxController {
  @override
  void onReady() {
    triggerSimulator();
    super.onReady();
  }

  //#region REAL 1972
  final RxBool _r1972 = false.obs;
  bool get r1972 => _r1972.value;
  void setR1972(bool b) {
    _r1972.value = b;
    update();
  }
  //#endregion

  //#region DEMO ROLE
  final Rx<DemoRole> _demoRole = DemoRole.none.obs;
  DemoRole get demoRole => _demoRole.value;
  void setDemoRole(DemoRole d) {
    _demoRole.value = d;
    update();
  }
  //#endregion

  //#region DEMO VIEWPORT
  final Rx<DemoViewport> _demoViewport = DemoViewport.none.obs;
  DemoViewport get demoViewport => _demoViewport.value;
  void setDemoViewport(DemoViewport d) {
    broadcast(MqttTopic.demoViewport, d.index);
  }

  void applyDemoViewport(DemoViewport d) {
    _demoViewport.value = d;
    update();
  }
  //#endregion

  //#region DEMO
  final Rx<Demo> _demo = Demo.initial().obs;
  Demo get demo => _demo.value;
  void setDemo(Demo d) {
    _demo.value = d;
    update();
  }

  void setBoilerHardwareIndex(int i) {
    Demo d = demo;
    d.demoBoilerHardwareIndex = i;
    setDemo(d);
    broadcast(MqttTopic.boilerHardwareIndex, i);
  }

  void setRoomHardwareIndex(int i) {
    Demo d = demo;
    d.demoRoomHardwareIndex = i;
    setDemo(d);
    broadcast(MqttTopic.roomHardwareIndex, i);
  }

  void setP1986SelectedRoomIndex(int i) {
    Demo d = demo;
    d.p1986SelectedRoomIndex = i;
    setDemo(d);
    broadcast(MqttTopic.p1986SelectedRoomIndex, i);
  }

  void setP1986SetTemperature(int i) {
    Demo d = demo;
    d.p1986SetTemperature = i;
    setDemo(d);
    broadcast(MqttTopic.p1986SetTemperature, i);
  }

  void setP1972SelectedIndex(int i) {
    Demo d = demo;
    d.p1972SelectedRoomIndex = i;
    setDemo(d);
    broadcast(MqttTopic.p1972SelectedRoomIndex, i);
  }

  void setP1972SetTemperature(int i) {
    Demo d = demo;
    d.p1972SetTemperature = i;
    setDemo(d);
    broadcast(MqttTopic.p1972SetTemperature, i);
  }

  void setP1975SetTemperature({required int roomIndex, required int value}) {
    Demo d = demo;
    String topic = '';
    switch (roomIndex) {
      case 1:
        d.p1975d1SetTemperature = value;
        topic = MqttTopic.p1975d1SetTemperature;
        break;
      case 2:
        d.p1975d2SetTemperature = value;
        topic = MqttTopic.p1975d2SetTemperature;
        break;
      case 3:
        d.p1975d3SetTemperature = value;
        topic = MqttTopic.p1975d3SetTemperature;
        break;
    }
    setDemo(d);
    broadcast(topic, value);
  }

  void setP1999Value({required int index, required int value}) {
    Demo d = demo;
    String topic = '';
    switch (index) {
      case 1:
        d.p1999z1d1 = value;
        topic = MqttTopic.p1999d1;
        break;
      case 2:
        d.p1999z1d2 = value;
        topic = MqttTopic.p1999d2;
        break;
      case 3:
        d.p1999z1d3 = value;
        topic = MqttTopic.p1999d3;
        break;
    }
    setDemo(d);
    broadcast(topic, value);
  }

  void setP1994Value({required int index, required int zone, required int value}) {
    // Demo d = demo;
    String topic = "1994/z${zone}d$index";
    broadcast(topic, value);
  }

  ////////
  void broadcast(String topic, int value) {
    final MqttController mqtt = Get.find();
    mqtt.broadcastMessage(topic: topic, message: "$value");
  }
  //#endregion

  //#region SIM
  void triggerSimulator() async {
    if (demoRole != DemoRole.viewer) {
      // print("no sim");
    } else {
      if (demo.boilerMode == 0 || demo.boilerStatus == 0) {
        adjustRoomsByOutside();
      } else {
        if (demo.boilerIndicator == 1) {
          adjustRoomsByBoiler();
        } else {
          adjustRoomsByOutside();
        }
      }
      determineFlame();
    }
    Future.delayed(const Duration(milliseconds: 800), () {
      triggerSimulator();
    });
  }

  void adjustRoomsByOutside() async {
    if (r1972 && demo.demoRoomHardwareIndex == 1) {
      return;
    }
    if (demo.room1CurrentTemperature > demo.outsideTemperature) {
      decreaseRoom1();
    }

    if (demo.room2CurrentTemperature > demo.outsideTemperature) {
      decreaseRoom2();
    }

    if (demo.room3CurrentTemperature > demo.outsideTemperature) {
      decreaseRoom3();
    }
  }

  void adjustRoomsByBoiler() async {
    if (r1972 && demo.demoRoomHardwareIndex == 1) {
      return;
    }
    if (demo.demoRoomHardwareIndex == 2) {
      if (demo.p1975room1ValveStatus == 1) {
        if (demo.room1CurrentTemperature < 350) {
          increaseRoom1();
        }
      } else {
        decreaseRoom1();
      }
      if (demo.p1975room2ValveStatus == 1) {
        if (demo.room2CurrentTemperature < 350) {
          increaseRoom2();
        }
      } else {
        decreaseRoom2();
      }
      if (demo.p1975room3ValveStatus == 1) {
        if (demo.room3CurrentTemperature < 350) {
          increaseRoom3();
        }
      } else {
        decreaseRoom3();
      }
    } else {
      if (demo.room1CurrentTemperature < 350) {
        increaseRoom1();
      }
      if (demo.room2CurrentTemperature < 350) {
        increaseRoom2();
      }
      if (demo.room3CurrentTemperature < 350) {
        increaseRoom3();
      }
    }
  }

  void determineFlame() async {
    switch (demo.demoRoomHardwareIndex) {
      case 0: //1986
        switch (demo.p1986SelectedRoomIndex) {
          case 1:
            if (demo.room1CurrentTemperature < demo.p1986SetTemperature - 9) {
              enableFlame();
            }
            if (demo.room1CurrentTemperature > demo.p1986SetTemperature + 9) {
              disableFlame();
            }
            break;
          case 2:
            if (demo.room2CurrentTemperature < demo.p1986SetTemperature - 9) {
              enableFlame();
            }
            if (demo.room2CurrentTemperature > demo.p1986SetTemperature + 9) {
              disableFlame();
            }
            break;
          case 3:
            if (demo.room3CurrentTemperature < demo.p1986SetTemperature - 9) {
              enableFlame();
            }
            if (demo.room3CurrentTemperature > demo.p1986SetTemperature + 9) {
              disableFlame();
            }
            break;
        }
        break;
      case 1: //1972
        switch (demo.p1972SelectedRoomIndex) {
          case 0:
            if (demo.averageCurrentTemperature < demo.p1972SetTemperature - 9) {
              enableFlame();
            }
            if (demo.averageCurrentTemperature > demo.p1972SetTemperature + 9) {
              disableFlame();
            }
            break;
          case 1:
            if (demo.room1CurrentTemperature < demo.p1972SetTemperature - 9) {
              enableFlame();
            }
            if (demo.room1CurrentTemperature > demo.p1972SetTemperature + 9) {
              disableFlame();
            }
            break;
          case 2:
            if (demo.room2CurrentTemperature < demo.p1972SetTemperature - 9) {
              enableFlame();
            }
            if (demo.room2CurrentTemperature > demo.p1972SetTemperature + 9) {
              disableFlame();
            }
            break;
          case 3:
            if (demo.room3CurrentTemperature < demo.p1972SetTemperature - 9) {
              enableFlame();
            }
            if (demo.room3CurrentTemperature > demo.p1972SetTemperature + 9) {
              disableFlame();
            }
            break;
        }
        break;
      case 2: //1975
        if (demo.room1CurrentTemperature < demo.p1975d1SetTemperature - 9) {
          Future.delayed(const Duration(milliseconds: 300), () {
            broadcast(MqttTopic.p1975d1Valve, 1);
          });
        }
        if (demo.room1CurrentTemperature > demo.p1975d1SetTemperature + 9) {
          Future.delayed(const Duration(milliseconds: 300), () {
            broadcast(MqttTopic.p1975d1Valve, 0);
          });
        }
        if (demo.room2CurrentTemperature < demo.p1975d2SetTemperature - 9) {
          Future.delayed(const Duration(milliseconds: 300), () {
            broadcast(MqttTopic.p1975d2Valve, 1);
          });
        }
        if (demo.room2CurrentTemperature > demo.p1975d2SetTemperature + 9) {
          Future.delayed(const Duration(milliseconds: 300), () {
            broadcast(MqttTopic.p1975d2Valve, 0);
          });
        }
        if (demo.room3CurrentTemperature < demo.p1975d3SetTemperature - 9) {
          Future.delayed(const Duration(milliseconds: 300), () {
            broadcast(MqttTopic.p1975d3Valve, 1);
          });
        }
        if (demo.room3CurrentTemperature > demo.p1975d3SetTemperature + 9) {
          Future.delayed(const Duration(milliseconds: 300), () {
            broadcast(MqttTopic.p1975d3Valve, 0);
          });
        }
        if (demo.p1975room1ValveStatus == 0 &&
            demo.p1975room2ValveStatus == 0 &&
            demo.p1975room3ValveStatus == 0) {
          disableFlame();
        } else {
          enableFlame();
        }
        break;
    }
  }

  void enableFlame() async {
    Future.delayed(const Duration(milliseconds: 300), () {
      // print("enabling flame");
      broadcast(MqttTopic.boilerIndicator, 1);
    });
  }

  void disableFlame() async {
    Future.delayed(const Duration(milliseconds: 300), () {
      // print("disabling flame");
      broadcast(MqttTopic.boilerIndicator, 0);
    });
  }

  void increaseRoom1() async {
    Future.delayed(const Duration(milliseconds: 300), () {
      broadcast(MqttTopic.room1CurrentTemperature, demo.room1CurrentTemperature + 2);
    });
  }

  void increaseRoom2() async {
    Future.delayed(const Duration(milliseconds: 300), () {
      broadcast(MqttTopic.room2CurrentTemperature, demo.room2CurrentTemperature + 1);
    });
  }

  void increaseRoom3() async {
    Future.delayed(const Duration(milliseconds: 300), () {
      broadcast(MqttTopic.room3CurrentTemperature, demo.room3CurrentTemperature + 1);
    });
  }

  void decreaseRoom1() async {
    Future.delayed(const Duration(milliseconds: 300), () {
      broadcast(MqttTopic.room1CurrentTemperature, demo.room1CurrentTemperature - 2);
    });
  }

  void decreaseRoom2() async {
    Future.delayed(const Duration(milliseconds: 300), () {
      broadcast(MqttTopic.room2CurrentTemperature, demo.room2CurrentTemperature - 1);
    });
  }

  void decreaseRoom3() async {
    Future.delayed(const Duration(milliseconds: 300), () {
      broadcast(MqttTopic.room3CurrentTemperature, demo.room3CurrentTemperature - 1);
    });
  }
  //#endregion
}
