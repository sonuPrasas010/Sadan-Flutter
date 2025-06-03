import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';


import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../configs/strings.dart';
import '../admin/category.dart';
import '../renter/chat/chats.dart';
import '../renter/profile/profile.dart';
import '../renter/vehicles/get_vehicles.dart';
import 'profile/profile_home.dart';
import 'vehicle/user_my_booking.dart';

class UserHome extends StatefulWidget {
  const UserHome({super.key});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  int currentIndex = 0;
  var items = [
    Categories(roles[0]),
    Chats(),
    UserMyBooking(),
    UserProfileHome(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: items[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) {
          currentIndex = value;
          setState(() {});
        },
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.black,
        items: [
          BottomNavigationBarItem(
              label: "Vehicles",
              icon: Icon(
                Icons.home,
              )),
          BottomNavigationBarItem(
              label: "Chats",
              icon: Icon(
                Icons.chat_bubble,
              )),
          BottomNavigationBarItem(
              label: "History",
              icon: Icon(
                Icons.location_pin,
              )),
          BottomNavigationBarItem(
              label: "Profile",
              icon: Icon(
                Icons.person_pin,
              )),
        ],
      ),
    );
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Renter"),
          bottom: TabBar(
            isScrollable: true,
            tabs: [
              Tab(child: Text("Add Vehicle")),
              Tab(child: Text("My Vehicle")),
              Tab(icon: Text('Chats')),
              Tab(icon: Text('verified')),
              Tab(icon: Text('Profile')),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            GetVehicles(),
            Chats(),
            Text("Logn"),
            Profile(),
          ],
        ),
      ),
    );
  }
}

// class UserHome extends StatelessWidget {
//   const UserHome({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 5,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text("User Home"),
//           bottom: TabBar(
//             isScrollable: true,
//             tabs: [
//               Text("Add Profile"),
//               Text("Change Password "),
//               Text("Chats"),
//               Text("Get Vehicles"),
//               Text("My Booking"),
//             ],
//           ),
//         ),
//         body: TabBarView(
//           children: [
//             Text("user profile"),
//             ChangePassword(),
//             Chats(),
//             GetVehicles(),
//             GetUserBookedVehicle()
//           ],
//         ),
//       ),
//     );
//   }
// }
