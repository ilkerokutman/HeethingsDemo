enum ScreenSize {
  xs,
  // 360
  s, //mobile or smaller
  // [600]
  m, // portrait tablet
  // [840]
  l, // landscape tablet or low-res desktop
  // [1024]
  xl, // desktop or higher
  // [1400]
  xxl,
}

enum ConnectionStatus {
  idle,
  connecting,
  connected,
  error,
}

enum DemoRole {
  none,
  viewer,
  controller,
}

enum DemoViewport {
  none,
  home,
  cafe,
  factory,
  sensor,
}

enum DemoRoomHardwareSet {
  p1986, // single thermostat
  p1972, // multi thermostat
  p1975, // thermostatic valve
}

enum DemoBoilerHardwareSet {
  p1986,
  p2010,
}
