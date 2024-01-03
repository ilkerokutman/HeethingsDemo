import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:heethings_demo/app/core/constants/enums.dart';
import 'package:heethings_demo/app/core/constants/mqtt.dart';
import 'package:heethings_demo/app/core/utils/box.dart';
import 'package:heethings_demo/app/data/models/demo.dart';
import 'package:heethings_demo/app/data/models/mqtt.dart';
import 'package:heethings_demo/app/data/services/demo.dart';
import 'package:heethings_demo/app/secrets.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MqttController extends GetxController {
  @override
  void onReady() {
    _connectivitySubscription.value =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    super.onReady();
  }

  //#region DEFINITIONS
  final Connectivity _connectivity = Connectivity();
  final Rxn<StreamSubscription<ConnectivityResult>> _connectivitySubscription =
      Rxn();
  StreamSubscription<ConnectivityResult>? get connectivitySubscription =>
      _connectivitySubscription.value;

  final RxBool _isConnectedToInternet = true.obs;
  bool get isConnectedToInternet => _isConnectedToInternet.value;

  final Rx<ConnectivityResult> _connection = ConnectivityResult.other.obs;
  ConnectivityResult get connection => _connection.value;

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    _connection.value = result;
    switch (result) {
      case ConnectivityResult.bluetooth:
      case ConnectivityResult.wifi:
      case ConnectivityResult.ethernet:
      case ConnectivityResult.mobile:
      case ConnectivityResult.vpn:
      case ConnectivityResult.other:
        bool responseReceived = true; // TODO: await Network.fetchHealthStatus
        _isConnectedToInternet.value = responseReceived;
        break;
      case ConnectivityResult.none:
        _isConnectedToInternet.value = false;
        break;
    }
    update();
  }

  final RxBool _mqttReady = false.obs;
  bool get mqttReady => _mqttReady.value;

  final Rx<ConnectionStatus> _mqttInitialization = ConnectionStatus.idle.obs;
  ConnectionStatus get mqttInitialization => _mqttInitialization.value;
  String get mqttInitializationText {
    switch (mqttInitialization) {
      case ConnectionStatus.idle:
        return "Awaiting Mqtt initialization";
      case ConnectionStatus.connecting:
        return "Initializing Mqtt";
      case ConnectionStatus.connected:
        return "Mqtt initialized";
      case ConnectionStatus.error:
        return "Mqtt initialization failed";
    }
  }

  final Rx<ConnectionStatus> _mqttConnection = ConnectionStatus.idle.obs;
  ConnectionStatus get mqttConnection => _mqttConnection.value;
  String get mqttConnectionText {
    switch (mqttConnection) {
      case ConnectionStatus.idle:
        return "Awaiting Mqtt Server connection";
      case ConnectionStatus.connecting:
        return "Connecting to Mqtt Servers";
      case ConnectionStatus.connected:
        return "Connected to Mqtt Servers";
      case ConnectionStatus.error:
        return "Mqtt Server connection failed";
    }
  }

  final Rx<ConnectionStatus> _mqttSubscription = ConnectionStatus.idle.obs;
  ConnectionStatus get mqttSubscription => _mqttSubscription.value;
  String get mqttSubscriptionText {
    switch (mqttSubscription) {
      case ConnectionStatus.idle:
        return "Awaiting Mqtt Topic subscription";
      case ConnectionStatus.connecting:
        return "Subscribing to Topics";
      case ConnectionStatus.connected:
        return "Subscribed to Topics";
      case ConnectionStatus.error:
        return "Mqtt Subscription failed";
    }
  }

  final Rxn<String> _demoId = Rxn();
  String? get demoId => _demoId.value;
  void setDemoId(String? s) {
    _demoId.value = s;
    update();
  }

  MqttServerClient mqttClient = MqttServerClient(
    Secrets.mqttServerHost,
    Box.deviceId,
    maxConnectionAttempts: 3,
  );

  final List<MqttTopicDefinition> topicsToSubscribe = [
    MqttTopicDefinition(topic: MqttTopic.demoViewport),
    MqttTopicDefinition(topic: MqttTopic.boilerHardwareIndex),
    MqttTopicDefinition(topic: MqttTopic.roomHardwareIndex),
    MqttTopicDefinition(topic: MqttTopic.boilerStatus),
    MqttTopicDefinition(topic: MqttTopic.boilerMode),
    MqttTopicDefinition(topic: MqttTopic.boilerIndicator),

    ///
    MqttTopicDefinition(topic: MqttTopic.room1CurrentTemperature),
    MqttTopicDefinition(topic: MqttTopic.room2CurrentTemperature),
    MqttTopicDefinition(topic: MqttTopic.room3CurrentTemperature),

    ///
    MqttTopicDefinition(topic: MqttTopic.p1986SelectedRoomIndex),
    MqttTopicDefinition(topic: MqttTopic.p1986SetTemperature),

    ///
    MqttTopicDefinition(topic: MqttTopic.p1972d1),
    MqttTopicDefinition(topic: MqttTopic.p1972d2),
    MqttTopicDefinition(topic: MqttTopic.p1972d3),
    MqttTopicDefinition(topic: MqttTopic.p1972SelectedRoomIndex),
    MqttTopicDefinition(topic: MqttTopic.p1972SetTemperature),

    ///
    MqttTopicDefinition(topic: MqttTopic.p1975d1SetTemperature),
    MqttTopicDefinition(topic: MqttTopic.p1975d2SetTemperature),
    MqttTopicDefinition(topic: MqttTopic.p1975d3SetTemperature),
    MqttTopicDefinition(topic: MqttTopic.p1975d1Valve),
    MqttTopicDefinition(topic: MqttTopic.p1975d2Valve),
    MqttTopicDefinition(topic: MqttTopic.p1975d3Valve),

    ///
    MqttTopicDefinition(topic: MqttTopic.p1942Get),
    MqttTopicDefinition(topic: MqttTopic.p1942Set),
    MqttTopicDefinition(topic: MqttTopic.p1942Value),

    ///
    MqttTopicDefinition(topic: MqttTopic.p1999d1),
    MqttTopicDefinition(topic: MqttTopic.p1999d2),
    MqttTopicDefinition(topic: MqttTopic.p1999d3),

    ///
    MqttTopicDefinition(topic: MqttTopic.p1994z1d1),
    MqttTopicDefinition(topic: MqttTopic.p1994z1d2),
    MqttTopicDefinition(topic: MqttTopic.p1994z1d3),
    MqttTopicDefinition(topic: MqttTopic.p1994z2d1),
    MqttTopicDefinition(topic: MqttTopic.p1994z2d2),
    MqttTopicDefinition(topic: MqttTopic.p1994z3d1),

    ///
    MqttTopicDefinition(topic: MqttTopic.sensorP1972Set0d1),
    MqttTopicDefinition(topic: MqttTopic.sensorP1972Set0d2),
    MqttTopicDefinition(topic: MqttTopic.sensorP1972Set0d3),
    MqttTopicDefinition(topic: MqttTopic.sensorP1972Set0s),
  ];
  //#endregion

  //#region INITIALIZATION & CONNECTION
  void disconnectMqtt() async {
    _mqttInitialization.value = ConnectionStatus.idle;
    _mqttConnection.value = ConnectionStatus.idle;
    _mqttSubscription.value = ConnectionStatus.idle;
    _mqttReady.value = false;
    update();
    try {
      mqttClient.disconnect();
    } on Exception catch (_) {}
  }

  Future<bool> initMqtt() async {
    // _mqttInitialization.value = ConnectionStatus.connecting;
    // update();
    bool initializationResult = initMqttClient();

    // _mqttInitialization.value = initializationResult
    //     ? ConnectionStatus.connected
    //     : ConnectionStatus.error;
    // update();
    bool connectionResult = await connectMqtt();
    if (!initializationResult ||
        !connectionResult ||
        mqttClient.connectionStatus!.state ==
            MqttConnectionState.disconnected) {
      Future.delayed(const Duration(seconds: 2), () {
        log("retrying mqtt connection");
        initMqtt();
      });
      return false;
    }
    bool subscriptionResult = await subscribeToTopics();
    _mqttReady.value =
        initializationResult && connectionResult && subscriptionResult;
    update();
    log("Mqtt Ready: $mqttReady");
    return initializationResult && connectionResult && subscriptionResult;
  }

  bool initMqttClient() {
    try {
      mqttClient = MqttServerClient(
        Secrets.mqttServerHost,
        Box.deviceId,
        maxConnectionAttempts: 3,
      );
      mqttClient.port = Secrets.mqttServerPort;
      mqttClient.secure = true;
      mqttClient.onBadCertificate = ((dynamic certificate) => true);
      mqttClient.clientIdentifier = Box.deviceId;

      mqttClient.setProtocolV311();
      mqttClient.keepAlivePeriod = 20;
      mqttClient.onConnected = onConnected;
      mqttClient.onDisconnected = onDisconnected;
      mqttClient.onSubscribed = onSubscribed;
      mqttClient.pongCallback = pong;
      mqttClient.autoReconnect = true;
      mqttClient.resubscribeOnAutoReconnect = true;

      return true;
    } on Exception catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<bool> connectMqtt() async {
    // _mqttConnection.value = ConnectionStatus.connecting;
    // update();
    if (mqttClient.connectionStatus!.state == MqttConnectionState.connected) {
      log("mqtt client already connected");
      // _mqttConnection.value = ConnectionStatus.connected;
      // update();
      return true;
    }
    try {
      MqttClientConnectionStatus? connectionResult =
          await mqttClient.connect(Secrets.mqttUsername, Secrets.mqttPassword);
      log("mqtt connection result: $connectionResult");
      // _mqttConnection.value = ConnectionStatus.connected;
      // update();
      return true;
    } on NoConnectionException {
      log("noConnectionException");
      // _mqttConnection.value = ConnectionStatus.error;
      // update();
      mqttClient.disconnect();
    } on SocketException {
      log("onSocketException");
      // _mqttConnection.value = ConnectionStatus.error;
      // update();
      mqttClient.disconnect();
    } catch (e) {
      // _mqttConnection.value = ConnectionStatus.error;
      // update();
      log(e.toString());
    }
    return false;
  }

  Future<bool> subscribeToTopics() async {
    // _mqttSubscription.value = ConnectionStatus.connecting;
    // update();
    // final DemoController dc = Get.find();
    List<Subscription?> subscriptionResultList = <Subscription?>[];
    for (var tts in topicsToSubscribe) {
      String topic;
      if (tts.topic.startsWith("heethings")) {
        topic = tts.topic;
      } else {
        topic = "${MqttTopic.prefix}$demoId/${tts.topic}";
      }

      var result = mqttClient.subscribe(topic, tts.qos);
      subscriptionResultList.add(result);
    }
    for (var s in subscriptionResultList) {
      log("subscription result: ${s!.createdTime} ${s.topic} ");
    }
    _registerListeners();
    // _mqttSubscription.value = ConnectionStatus.connected;
    // update();
    return true;
  }

  void _registerListeners() {
    mqttClient.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      final receivedPayload = c![0].payload as MqttPublishMessage;
      final payloadText = MqttPublishPayload.bytesToStringAsString(
          receivedPayload.payload.message);
      final topicName = receivedPayload.variableHeader!.topicName;
      applyReceivedMessage(topic: topicName, message: payloadText);
    });
  }
  //#endregion

  //#region RECEIVER
  Future<void> applyReceivedMessage(
      {required String topic, required String message}) async {
    //
    final DemoController dc = Get.find();

    String t = topic
        .replaceAll(sensorTopicPrefix, '')
        .replaceAll(MqttTopic.prefix, '')
        .replaceAll("$demoId/", '');
    log("Topic: $t, Message: $message");
    // topic = topic.replaceAll("${MqttTopic.prefix}/$demoId/", "");
    Demo d = dc.demo;
    if (t == MqttTopic.sensorP1972Set0d1.replaceAll(sensorTopicPrefix, '')) {
      d.sensorP1972d1 = int.parse(message);
    } else if (t ==
        MqttTopic.sensorP1972Set0d2.replaceAll(sensorTopicPrefix, '')) {
      d.sensorP1972d2 = int.parse(message);
    } else if (t ==
        MqttTopic.sensorP1972Set0d3.replaceAll(sensorTopicPrefix, '')) {
      d.sensorP1972d3 = int.parse(message);
    } else if (t ==
        MqttTopic.sensorP1972Set0s.replaceAll(sensorTopicPrefix, '')) {
      d.sensorP1972s = int.parse(message);
    } else {
      switch (t) {
        case MqttTopic.demoViewport:
          dc.applyDemoViewport(DemoViewport.values[int.parse(message)]);
          break;
        case MqttTopic.boilerHardwareIndex:
          d.demoBoilerHardwareIndex = int.parse(message);
          break;
        case MqttTopic.roomHardwareIndex:
          d.demoRoomHardwareIndex = int.parse(message);
          break;
        case MqttTopic.boilerStatus:
          d.boilerStatus = int.parse(message);
          break;
        case MqttTopic.boilerMode:
          d.boilerMode = int.parse(message);
          break;
        case MqttTopic.boilerIndicator:
          d.boilerIndicator = int.parse(message);
          break;
        case MqttTopic.room1CurrentTemperature:
          d.room1CurrentTemperature = int.parse(message);
          break;
        case MqttTopic.room2CurrentTemperature:
          d.room2CurrentTemperature = int.parse(message);
          break;
        case MqttTopic.room3CurrentTemperature:
          d.room3CurrentTemperature = int.parse(message);
          break;
        case MqttTopic.p1986SelectedRoomIndex:
          d.p1986SelectedRoomIndex = int.parse(message);
          break;
        case MqttTopic.p1986SetTemperature:
          d.p1986SetTemperature = int.parse(message);
          break;
        case MqttTopic.p1972SelectedRoomIndex:
          d.p1972SelectedRoomIndex = int.parse(message);
          break;
        case MqttTopic.p1972SetTemperature:
          d.p1972SetTemperature = int.parse(message);
          break;

        case MqttTopic.p1975d1SetTemperature:
          d.p1975d1SetTemperature = int.parse(message);
          break;
        case MqttTopic.p1975d2SetTemperature:
          d.p1975d2SetTemperature = int.parse(message);
          break;
        case MqttTopic.p1975d3SetTemperature:
          d.p1975d3SetTemperature = int.parse(message);
          break;
        case MqttTopic.p1975d1Valve:
          d.p1975room1ValveStatus = int.parse(message);
          break;
        case MqttTopic.p1975d2Valve:
          d.p1975room2ValveStatus = int.parse(message);
          break;
        case MqttTopic.p1975d3Valve:
          d.p1975room3ValveStatus = int.parse(message);
          break;

        case MqttTopic.p1999d1:
          d.p1999z1d1 = int.parse(message);
          break;
        case MqttTopic.p1999d2:
          d.p1999z1d2 = int.parse(message);
          break;
        case MqttTopic.p1999d3:
          d.p1999z1d3 = int.parse(message);
          break;

        case MqttTopic.p1994z1d1:
          d.p1994z1d1 = int.parse(message);
          break;
        case MqttTopic.p1994z1d2:
          d.p1994z1d2 = int.parse(message);
          break;
        case MqttTopic.p1994z1d3:
          d.p1994z1d3 = int.parse(message);
          break;
        case MqttTopic.p1994z2d1:
          d.p1994z2d1 = int.parse(message);
          break;
        case MqttTopic.p1994z2d2:
          d.p1994z2d2 = int.parse(message);
          break;
        case MqttTopic.p1994z3d1:
          d.p1994z3d1 = int.parse(message);
          break;

        default:
          break;
      }
    }

    dc.setDemo(d);
  }

  //#endregion

  //#region SENDER
  void broadcastMessage({required String topic, required String message}) {
    if (mqttClient.connectionStatus!.state != MqttConnectionState.connected) {
      return;
    }
    final builder = MqttClientPayloadBuilder();
    builder.addString((message));
    int messageId = mqttClient.publishMessage(
      topic.startsWith(sensorTopicPrefix)
          ? topic
          : "${MqttTopic.prefix}$demoId/$topic",
      MqttQos.atLeastOnce,
      builder.payload!,
      retain: false,
    );
    log("topic: $topic ,message: $message", name: "MQTT SEND ($messageId)");
  }
  //#endregion

  //#region MQTT initialization callbacks
  void onConnected() {
    log("MQTT connected: ${DateTime.now().toIso8601String()} ${mqttClient.clientIdentifier}");
    _mqttConnection.value = ConnectionStatus.connected;
    update();
  }

  void onDisconnected() {
    log("MQTT disconnected: ${DateTime.now().toIso8601String()}");
  }

  void onSubscribed(String topic) {
    log("MQTT subscribed to $topic");
    _mqttSubscription.value = ConnectionStatus.connected;
    update();
  }

  void pong() {
    log("ponged");
  }
  //#endregion
}
