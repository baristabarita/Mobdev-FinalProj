import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:weather_weather/screens/dashboard_controller.dart';
import 'package:weather_weather/screens/forecast_screen.dart';
import 'package:weather_weather/screens/profile_screen.dart';
import 'package:weather_weather/widgets/BottomNavbar.dart';

class DashboardScreen extends StatefulWidget {
  static String routeName = "/dashboard";
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() {
    return _DashboardState();
  }
}

class _DashboardState extends State<DashboardScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GetBuilder<DashboardController>(
          builder: ((controller) => Column(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/cloud-in-blue.jpg'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                        ),
                      ),
                      child: Stack(
                        children: <Widget>[
                          Container(
                            child: AppBar(
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                              leading: IconButton(
                                icon: Icon(
                                  Icons.menu,
                                  color: Colors.white,
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ),
                          Container(
                            padding:
                                EdgeInsets.only(top: 100, left: 20, right: 20),
                            child: TextField(
                              onChanged: (value) {},
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              textInputAction: TextInputAction.search,
                              onSubmitted: (value) {},
                              decoration: InputDecoration(
                                suffix: Icon(
                                  Icons.search,
                                  color: Colors.white,
                                ),
                                hintStyle: TextStyle(color: Colors.white),
                                hintText: 'Search'.toUpperCase(),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment(0.0, 1.0),
                            child: SizedBox(
                              height: 10,
                              width: 10,
                              child: OverflowBox(
                                minWidth: 0.0,
                                maxWidth: MediaQuery.of(context).size.width,
                                minHeight: 0.0,
                                maxHeight:
                                    (MediaQuery.of(context).size.height / 4),
                                child: Stack(
                                  children: <Widget>[
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 15),
                                      width: double.infinity,
                                      height: double.infinity,
                                      child: Card(
                                        color: Colors.white,
                                        elevation: 5,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.only(
                                                  top: 15, left: 20, right: 20),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Center(
                                                    child: Text(
                                                      (controller.currentWeatherData !=
                                                              null)
                                                          ? '${controller.currentWeatherData.name}'
                                                          : '',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall
                                                          ?.copyWith(
                                                            color:
                                                                Colors.black45,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(flex: 2, child: Container())
                ],
              ))),
      bottomNavigationBar: BottomNavbar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          // Handle navigation or any other logic based on the selected index
          if (_currentIndex == 1) {
            Navigator.pushNamed(context, ForecastScreen.routeName);
          } else if (_currentIndex == 2) {
            Navigator.pushNamed(context, ProfileScreen.routeName);
          }
        },
      ),
    );
  }
}
