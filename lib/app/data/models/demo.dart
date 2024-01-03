import 'dart:math' as math;
import 'dart:convert';

class Demo {
  int boilerStatus;
  int pressure;
  int boilerMode;
  int domesticHotWaterSetTemperature;
  int domesticHotWaterCurrentTemperature;
  int outsideTemperature;
  int boilerIndicator;
  int waterIndicator;
  int flameIndicator;
  int room1CurrentTemperature;
  int room2CurrentTemperature;
  int room3CurrentTemperature;
  int p1975d1SetTemperature;
  int p1975d2SetTemperature;
  int p1975d3SetTemperature;
  int p1975room1ValveStatus;
  int p1975room2ValveStatus;
  int p1975room3ValveStatus;
  int p1972SetTemperature;
  int p1972SelectedRoomIndex;
  int p1986SetTemperature;
  int p1986SelectedRoomIndex;
  int p1999z1d1;
  int p1999z1d2;
  int p1999z1d3;
  int p1994z1d1;
  int p1994z1d2;
  int p1994z1d3;
  int p1994z2d1;
  int p1994z2d2;
  int p1994z2d3;
  int p1994z3d1;
  int p1994z3d2;
  int p1994z3d3;

  int sensorP1972d1;
  int sensorP1972d2;
  int sensorP1972d3;
  int sensorP1972s;

  int demoRoomHardwareIndex;
  int demoBoilerHardwareIndex;
  int demoBoilerOpenThermEnabled;
  Demo({
    required this.boilerStatus,
    required this.pressure,
    required this.boilerMode,
    required this.domesticHotWaterSetTemperature,
    required this.domesticHotWaterCurrentTemperature,
    required this.outsideTemperature,
    required this.boilerIndicator,
    required this.waterIndicator,
    required this.flameIndicator,
    required this.room1CurrentTemperature,
    required this.room2CurrentTemperature,
    required this.room3CurrentTemperature,
    required this.p1975d1SetTemperature,
    required this.p1975d2SetTemperature,
    required this.p1975d3SetTemperature,
    required this.p1975room1ValveStatus,
    required this.p1975room2ValveStatus,
    required this.p1975room3ValveStatus,
    required this.p1972SetTemperature,
    required this.p1972SelectedRoomIndex,
    required this.p1986SetTemperature,
    required this.p1986SelectedRoomIndex,
    required this.p1999z1d1,
    required this.p1999z1d2,
    required this.p1999z1d3,
    required this.p1994z1d1,
    required this.p1994z1d2,
    required this.p1994z1d3,
    required this.p1994z2d1,
    required this.p1994z2d2,
    required this.p1994z2d3,
    required this.p1994z3d1,
    required this.p1994z3d2,
    required this.p1994z3d3,
    required this.sensorP1972d1,
    required this.sensorP1972d2,
    required this.sensorP1972d3,
    required this.sensorP1972s,
    required this.demoRoomHardwareIndex,
    required this.demoBoilerHardwareIndex,
    required this.demoBoilerOpenThermEnabled,
  });

  int get currentRoomTemperature => p1986SelectedRoomIndex == 1
      ? room1CurrentTemperature
      : p1986SelectedRoomIndex == 2
          ? room2CurrentTemperature
          : room3CurrentTemperature;

  int get averageCurrentTemperature => ((room1CurrentTemperature +
              room2CurrentTemperature +
              room3CurrentTemperature) /
          3)
      .round();

  int get p1999Max => math.max(p1999z1d1, math.max(p1999z1d2, p1999z1d3));
  int get p1994z1Max => math.max(p1994z1d1, math.max(p1994z1d2, p1994z1d3));
  int get p1994z2Max => math.max(p1994z2d1, math.max(p1994z2d2, p1994z2d3));
  int get p1994z3Max => math.max(p1994z3d1, math.max(p1994z3d2, p1994z3d3));

  Map<String, dynamic> toMap() {
    return {
      'boilerStatus': boilerStatus,
      'pressure': pressure,
      'boilerMode': boilerMode,
      'domesticHotWaterSetTemperature': domesticHotWaterSetTemperature,
      'domesticHotWaterCurrentTemperature': domesticHotWaterCurrentTemperature,
      'outsideTemperature': outsideTemperature,
      'boilerIndicator': boilerIndicator,
      'waterIndicator': waterIndicator,
      'flameIndicator': flameIndicator,
      'room1CurrentTemperature': room1CurrentTemperature,
      'room2CurrentTemperature': room2CurrentTemperature,
      'room3CurrentTemperature': room3CurrentTemperature,
      'p1975d1SetTemperature': p1975d1SetTemperature,
      'p1975d2SetTemperature': p1975d2SetTemperature,
      'p1975d3SetTemperature': p1975d3SetTemperature,
      'p1975room1ValveStatus': p1975room1ValveStatus,
      'p1975room2ValveStatus': p1975room2ValveStatus,
      'p1975room3ValveStatus': p1975room3ValveStatus,
      'p1972SetTemperature': p1972SetTemperature,
      'p1972SelectedRoomIndex': p1972SelectedRoomIndex,
      'p1986SetTemperature': p1986SetTemperature,
      'p1986SelectedRoomIndex': p1986SelectedRoomIndex,
      'p1999z1d1': p1999z1d1,
      'p1999z1d2': p1999z1d2,
      'p1999z1d3': p1999z1d3,
      'p1994z1d1': p1994z1d1,
      'p1994z1d2': p1994z1d2,
      'p1994z1d3': p1994z1d3,
      'p1994z2d1': p1994z2d1,
      'p1994z2d2': p1994z2d2,
      'p1994z2d3': p1994z2d3,
      'p1994z3d1': p1994z3d1,
      'p1994z3d2': p1994z3d2,
      'p1994z3d3': p1994z3d3,
      'sensorP1972d1': sensorP1972d1,
      'sensorP1972d2': sensorP1972d2,
      'sensorP1972d3': sensorP1972d3,
      'sensorP1972s': sensorP1972s,
      'demoRoomHardwareIndex': demoRoomHardwareIndex,
      'demoBoilerHardwareIndex': demoBoilerHardwareIndex,
      'demoBoilerOpenThermEnabled': demoBoilerOpenThermEnabled,
    };
  }

  factory Demo.initial() {
    return Demo(
      boilerStatus: 1,
      pressure: 10,
      boilerMode: 1,
      domesticHotWaterSetTemperature: 450,
      domesticHotWaterCurrentTemperature: 180,
      outsideTemperature: 140,
      boilerIndicator: 0,
      waterIndicator: 0,
      flameIndicator: 0,
      room1CurrentTemperature: 182,
      room2CurrentTemperature: 186,
      room3CurrentTemperature: 188,
      p1975d1SetTemperature: 180,
      p1975d2SetTemperature: 190,
      p1975d3SetTemperature: 216,
      p1975room1ValveStatus: 0,
      p1975room2ValveStatus: 0,
      p1975room3ValveStatus: 0,
      p1972SetTemperature: 180,
      p1972SelectedRoomIndex: 1,
      p1986SetTemperature: 180,
      p1986SelectedRoomIndex: 1,
      p1999z1d1: 0,
      p1999z1d2: 0,
      p1999z1d3: 0,
      p1994z1d1: 0,
      p1994z1d2: 0,
      p1994z1d3: 0,
      p1994z2d1: 0,
      p1994z2d2: 0,
      p1994z2d3: 0,
      p1994z3d1: 0,
      p1994z3d2: 0,
      p1994z3d3: 0,
      sensorP1972d1: 180,
      sensorP1972d2: 180,
      sensorP1972d3: 180,
      sensorP1972s: 0,
      demoRoomHardwareIndex: 0,
      demoBoilerHardwareIndex: 0,
      demoBoilerOpenThermEnabled: 1,
    );
  }

  factory Demo.fromMap(Map<String, dynamic> map) {
    return Demo(
      boilerStatus: map['boilerStatus']?.toInt() ?? 0,
      pressure: map['pressure']?.toInt() ?? 0,
      boilerMode: map['boilerMode']?.toInt() ?? 0,
      domesticHotWaterSetTemperature:
          map['domesticHotWaterSetTemperature']?.toInt() ?? 0,
      domesticHotWaterCurrentTemperature:
          map['domesticHotWaterCurrentTemperature']?.toInt() ?? 0,
      outsideTemperature: map['outsideTemperature']?.toInt() ?? 0,
      boilerIndicator: map['boilerIndicator']?.toInt() ?? 0,
      waterIndicator: map['waterIndicator']?.toInt() ?? 0,
      flameIndicator: map['flameIndicator']?.toInt() ?? 0,
      room1CurrentTemperature: map['room1CurrentTemperature']?.toInt() ?? 0,
      room2CurrentTemperature: map['room2CurrentTemperature']?.toInt() ?? 0,
      room3CurrentTemperature: map['room3CurrentTemperature']?.toInt() ?? 0,
      p1975d1SetTemperature: map['p1975d1SetTemperature']?.toInt() ?? 0,
      p1975d2SetTemperature: map['p1975d2SetTemperature']?.toInt() ?? 0,
      p1975d3SetTemperature: map['p1975d3SetTemperature']?.toInt() ?? 0,
      p1975room1ValveStatus: map['p1975room1ValveStatus']?.toInt() ?? 0,
      p1975room2ValveStatus: map['p1975room2ValveStatus']?.toInt() ?? 0,
      p1975room3ValveStatus: map['p1975room3ValveStatus']?.toInt() ?? 0,
      p1972SetTemperature: map['p1972SetTemperature']?.toInt() ?? 0,
      p1972SelectedRoomIndex: map['p1972SelectedRoomIndex']?.toInt() ?? 0,
      p1986SetTemperature: map['p1986SetTemperature']?.toInt() ?? 0,
      p1986SelectedRoomIndex: map['p1986SelectedRoomIndex']?.toInt() ?? 0,
      p1999z1d1: map['p1999z1d1']?.toInt() ?? 0,
      p1999z1d2: map['p1999z1d2']?.toInt() ?? 0,
      p1999z1d3: map['p1999z1d3']?.toInt() ?? 0,
      p1994z1d1: map['p1994z1d1']?.toInt() ?? 0,
      p1994z1d2: map['p1994z1d2']?.toInt() ?? 0,
      p1994z1d3: map['p1994z1d3']?.toInt() ?? 0,
      p1994z2d1: map['p1994z2d1']?.toInt() ?? 0,
      p1994z2d2: map['p1994z2d2']?.toInt() ?? 0,
      p1994z2d3: map['p1994z2d3']?.toInt() ?? 0,
      p1994z3d1: map['p1994z3d1']?.toInt() ?? 0,
      p1994z3d2: map['p1994z3d2']?.toInt() ?? 0,
      p1994z3d3: map['p1994z3d3']?.toInt() ?? 0,
      sensorP1972d1: map['sensorP1972d1']?.toInt() ?? 0,
      sensorP1972d2: map['sensorP1972d2']?.toInt() ?? 0,
      sensorP1972d3: map['sensorP1972d3']?.toInt() ?? 0,
      sensorP1972s: map['sensorP1972s']?.toInt() ?? 0,
      demoRoomHardwareIndex: map['demoRoomHardwareIndex']?.toInt() ?? 0,
      demoBoilerHardwareIndex: map['demoBoilerHardwareIndex']?.toInt() ?? 0,
      demoBoilerOpenThermEnabled:
          map['demoBoilerOpenThermEnabled']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Demo.fromJson(String source) => Demo.fromMap(json.decode(source));
}
