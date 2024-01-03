import 'package:mqtt_client/mqtt_client.dart';

class MqttTopicDefinition {
  String topic;
  MqttQos qos;
  MqttTopicDefinition({
    required this.topic,
    this.qos = MqttQos.atLeastOnce,
  });
}
