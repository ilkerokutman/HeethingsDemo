import 'package:get/get.dart';
import 'package:heethings_demo/app/data/routes/routes.dart';
import 'package:heethings_demo/app/ui/screens/connection.dart';
import 'package:heethings_demo/app/ui/screens/demo_controller.dart';
import 'package:heethings_demo/app/ui/screens/demo_viewer.dart';
import 'package:heethings_demo/app/ui/screens/existing_demo_session.dart';
import 'package:heethings_demo/app/ui/screens/home.dart';
import 'package:heethings_demo/app/ui/screens/p1972/p1972_listener.dart';
import 'package:heethings_demo/app/ui/screens/role_options.dart';

final List<GetPage> getPages = [
  GetPage(
    name: Routes.home,
    page: () => const HomeScreen(),
  ),
  GetPage(
    name: Routes.existingDemoSession,
    page: () => const ExistingDemoSessionScreen(),
  ),
  GetPage(
    name: Routes.connecting,
    page: () => const ConnectionScreen(),
  ),
  GetPage(
    name: Routes.demoRoleOptions,
    page: () => const RoleOptionsScreen(),
  ),
  GetPage(
    name: Routes.demoViewer,
    page: () => const DemoViewerScreen(),
  ),
  GetPage(
    name: Routes.demoController,
    page: () => const DemoControllerScreen(),
  ),
  GetPage(
    name: Routes.p1972Listener,
    page: () => const P1972ListenerScreen(),
  ),
];
