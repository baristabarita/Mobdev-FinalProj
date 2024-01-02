
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFF011627),
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         systemOverlayStyle: SystemUiOverlayStyle(
//           statusBarBrightness: Brightness.dark,
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.fromLTRB(45, 1 * kToolbarHeight, 45, 20),
//         child: SizedBox(
//           height: MediaQuery.of(context).size.height,
//           child: Stack(
//             children: [
//               Align(
//                 alignment: AlignmentDirectional(5, -0.3),
//                 child: Container(
//                   height: 300,
//                   width: 300,
//                   decoration: BoxDecoration(
//                       shape: BoxShape.circle, color: Colors.white),
//                 ),
//               ),
//               Align(
//                 alignment: AlignmentDirectional(0, -1.2),
//                 child: Container(
//                   height: 300,
//                   width: 600,
//                   decoration: BoxDecoration(color: Colors.orange),
//                 ),
//               ),
//               BackdropFilter(
//                 filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.transparent,
//                   ),
//                 ),
//               ),
//               BlocBuilder<WeatherBlocBloc, WeatherBlocState>(
//                 builder: (context, state) {
//                   return SizedBox(
//                     width: MediaQuery.of(context).size.width,
//                     height: MediaQuery.of(context).size.height,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           '📍 Cebu City',
//                           style: TextStyle(
//                               color: Colors.white, fontWeight: FontWeight.w300),
//                         ),
//                         Text(
//                           'Good morning!',
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 25,
//                               fontWeight: FontWeight.bold),
//                         ),
//                         Image.asset(
//                           'assets/1.png',
//                           scale: 1,
//                         ),
//                         Center(
//                           child: Text(
//                             '21°C',
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 53,
//                                 fontWeight: FontWeight.w600),
//                           ),
//                         ),
//                         Center(
//                           child: Text('Thunderstorm',
//                               style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.w300)),
//                         ),
//                         Center(
//                             child: Text('Tuesday 2 · 12:00AM',
//                                 style: TextStyle(
//                                     color: Colors.white, fontSize: 13))),
//                         SizedBox(height: 25),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Row(
//                               children: [
//                                 Image.asset(
//                                   'assets/11.png',
//                                   scale: 8,
//                                 ),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       'Sunrise',
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.w300,
//                                       ),
//                                     ),
//                                     SizedBox(height: 3),
//                                     Text(
//                                       '5:00AM',
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.w700,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                             Row(
//                               children: [
//                                 Image.asset(
//                                   'assets/12.png',
//                                   scale: 8,
//                                 ),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       'Sunset',
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.w300,
//                                       ),
//                                     ),
//                                     SizedBox(height: 3),
//                                     Text(
//                                       '5:30PM',
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.w700,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                         Padding(
//                           padding: EdgeInsets.symmetric(vertical: 5.0),
//                           child: Divider(
//                             color: Colors.blueGrey,
//                           ),
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Row(
//                               children: [
//                                 Image.asset(
//                                   'assets/13.png',
//                                   scale: 8,
//                                 ),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       'Temp Max',
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.w300,
//                                       ),
//                                     ),
//                                     SizedBox(height: 3),
//                                     Text(
//                                       '25°C',
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.w700,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                             Row(
//                               children: [
//                                 Image.asset(
//                                   'assets/14.png',
//                                   scale: 8,
//                                 ),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       'Temp Min',
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.w300,
//                                       ),
//                                     ),
//                                     SizedBox(height: 3),
//                                     Text(
//                                       '21°C',
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.w700,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: BottomNavbar(
//         currentIndex: _currentIndex,
//         onTap: (index) {
//           setState(() {
//             _currentIndex = index;
//           });
//           // Handle navigation or any other logic based on the selected index
//           if (_currentIndex == 1) {
//             Navigator.pushNamed(context, ForecastScreen.routeName);
//           } else if (_currentIndex == 2) {
//             Navigator.pushNamed(context, ProfileScreen.routeName);
//           }
//         },
//       ),
//     );
//   }
// }
