import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sadan/pages/auth/login.dart';
import 'package:sadan/pages/user/profile/User_kyc_screen.dart';
import 'package:sadan/pages/user/profile/change_password.dart';

import '../../renter/profile/contact.dart';

class UserProfileHome extends StatelessWidget {
  const UserProfileHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        leading: SizedBox.shrink(),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 20,
          ),
          Center(
            child: Stack(
              children: [
                CircleAvatar(
                  // backgroundColor: Colors.blue[50],
                  radius: 60,
                  child: Image.asset(
                    'images/profile.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                    top: 80,
                    left: 80,
                    child: GestureDetector(
                      onTap: () {},
                      child: CircleAvatar(
                        backgroundColor: Colors.amber,
                        child: Icon(
                          Icons.camera_alt_outlined,
                        ),
                      ),
                    )),
              ],
            ),
          ),
          ProfileItems(Icons.contact_emergency,
              Icons.arrow_forward_ios_outlined, 'Add KYC Profile', () {
            Get.to(() => UserKycScreen());
          }),
          ProfileItems(Icons.password, Icons.arrow_forward_ios_outlined,
              'Change Password', () {
            Get.to(() => ChangePassword());
          }),
          ProfileItems(Icons.contact_emergency,
              Icons.arrow_forward_ios_outlined, 'Policies'),
          ProfileItems(
              Icons.contact_emergency, Icons.arrow_forward_ios_outlined, 'Help',
              () {
            Get.to(() => ContactPage());
          }),
          ProfileItems(
              Icons.logout_outlined, Icons.arrow_forward_ios_outlined, 'Logout',
              () {
            Get.offAll(() => LoginScreen());
          }),
        ]),
      ),
    );
  }
}

class ProfileItems extends StatelessWidget {
  ProfileItems(this.iconNameLeading, this.iconNameTrailing, this.titleName,
      [this.onClick]);
  final IconData iconNameLeading;
  final IconData iconNameTrailing;
  final String titleName;
  final Function? onClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.blue[50],
      ),
      child: ListTile(
        onTap: () {
          onClick!();
        },
        leading: Icon(
          iconNameLeading,
          color: Colors.orange,
        ),
        title: Text(
          titleName,
        ),
        trailing: Icon(
          iconNameTrailing,
          color: Colors.orange,
        ),
      ),
    );
  }
}
