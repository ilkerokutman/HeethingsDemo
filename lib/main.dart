import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:heethings_demo/app/core/constants/assets.dart';
import 'package:heethings_demo/app/core/extensions/httpoverrides.dart';
import 'package:heethings_demo/app/data/services/bindings.dart';
import 'package:heethings_demo/app/demo_app.dart';

Future<void> main() async {
  // shared preferences
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();

  // fix Android 7 Letsencrypt certificate problem
  if (!kIsWeb) {
    ByteData data = await PlatformAssetBundle().load(UiAssets.certificate);
    SecurityContext.defaultContext
        .setTrustedCertificatesBytes(data.buffer.asUint8List());
  }
  HttpOverrides.global = MyHttpOverrides();

  // init controllers
  await AwaitBindings().dependencies();

  // run app
  runApp(const DemoApp());
}
