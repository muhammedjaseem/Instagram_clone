// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// class Bookmarked extends StatefulWidget {
//   getID() async {
//     print("ff");
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     //Return int
//     int intValue = prefs.getInt('ID') ?? 0;
//     print(getID().toString());
//     return intValue;
//   }
//   //const Bookmarked({Key? key}) : super(key: key);
//
//   @override
//   _BookmarkedState createState() => _BookmarkedState();
// }
//
// class _BookmarkedState extends State<Bookmarked> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView(
//         shrinkWrap: true,
//         children: [
//
//          //Text(prefs.getInt('ID')),
//         ],
//       ),
//     );
//   }
// }
