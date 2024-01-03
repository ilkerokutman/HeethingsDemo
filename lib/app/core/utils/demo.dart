class DemoUtils {
  //
  static String displayTemperature(int temperature, {int presicion = 1}) {
    return "${(temperature / 10).toStringAsFixed(1)} °C";
  }
}
