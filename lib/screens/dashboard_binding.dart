import 'package:get/get.dart';
import 'package:weather_weather/screens/dashboard_controller.dart';

class DashboardBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DashboardController());
  }
}
