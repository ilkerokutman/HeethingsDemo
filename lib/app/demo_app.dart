import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heethings_demo/app/core/constants/strings.dart';
import 'package:heethings_demo/app/core/theme/dark.dart';
import 'package:heethings_demo/app/core/theme/light.dart';
import 'package:heethings_demo/app/data/routes/getpages.dart';
import 'package:heethings_demo/app/data/routes/routes.dart';
import 'package:heethings_demo/app/data/services/bindings.dart';

class DemoApp extends StatelessWidget {
  const DemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: UiStrings.appName,
      debugShowCheckedModeBanner: false,
      initialBinding: AwaitBindings(),
      getPages: getPages,
      initialRoute: Routes.home,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.light,
      defaultTransition: Transition.fadeIn,
    );
  }
}
