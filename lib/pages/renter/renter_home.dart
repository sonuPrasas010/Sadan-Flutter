import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sadan/pages/renter/chat/chats.dart';
import 'package:sadan/pages/renter/profile/profile.dart';
import 'package:sadan/pages/renter/profile/profile_home.dart';
import 'package:sadan/pages/renter/vehicles/add_vehicle.dart';
import 'package:sadan/pages/renter/vehicles/get_vehicles.dart';

import 'orders/my_booking.dart';

class RenterHome extends StatefulWidget {
  const RenterHome({super.key});

  @override
  State<RenterHome> createState() => _RenterHomeState();
}

class _RenterHomeState extends State<RenterHome> {
  int currentIndex = 0;

  var items = [
    GetVehicles(),
    Chats(),
    MyBooking(),
    ProfileHome(),
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
              label: "Home",
              icon: Icon(
                Icons.bus_alert,
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
            AddVehicleScreen(),
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
