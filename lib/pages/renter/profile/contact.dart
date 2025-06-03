import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher_string.dart';

class ContactPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Get in Touch:',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    fontSize: 24),
              ),
              Form(
                child: Column(
                  children: [
                    ContactListItems(
                        Icons.email_outlined, 'Enter Email Address'),
                    SizedBox(height: 10),
                    ContactListItems(
                        Icons.email_outlined, 'Enter Email Address'),
                    SizedBox(height: 10),
                    ContactListItems(
                        Icons.email_outlined, 'Enter Email Address'),
                    SizedBox(height: 10),
                    ContactListItems(
                        Icons.email_outlined, 'Enter Email Address'),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Submit'),
                    ),
                  ],
                ),
              ),
              Center(
                child: Column(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          CircleAvatarWidget('Address', Icons.map_outlined),
                          Text(
                            'Urlabari, Jhapa, Nepal',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          CircleAvatarWidget(
                              'Phone', Icons.phone_android_outlined),
                          GestureDetector(
                            onTap: () async {
                              final phoneNumber = '+9779804055044';
                              final url = 'tel:$phoneNumber';

                              if (await canLaunchUrlString(url)) {
                                await launchUrlString(url);
                              }
                            },
                            child: Text(
                              '+9779804055044 (Sujan)',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () async {
                              final phoneNumber = '+9779804055044';
                              final url = 'tel:$phoneNumber';

                              if (await canLaunchUrlString(url)) {
                                await launchUrlString(url);
                              }
                            },
                            child: Text(
                              '+9779804055044 (Anil)',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              final phoneNumber = '+9779804055044';
                              final url = 'sms:$phoneNumber';

                              if (await canLaunchUrlString(url)) {
                                await launchUrlString(url);
                              }
                            },
                            child: const Text('make sms'),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          CircleAvatarWidget('Email', Icons.email),
                          GestureDetector(
                            onTap: () async {
                              final toEmail = 'Kingkarki320@gmail.com';
                              final subject = 'Enter New Subject';
                              final message = 'hello! flutter';
                              final url =
                                  'mailto:$toEmail?subject=${Uri.encodeFull(subject)}&body=${Uri.encodeFull(message)}';

                              if (await canLaunchUrlString(url)) {
                                await launchUrlString(url);
                              }
                            },
                            child: Text(
                              'Kingkarki320@gmail.com',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          CircleAvatarWidget('Website', Icons.web),
                          ElevatedButton(
                            onPressed: () async {
                              final url = 'https://flutter.dev';
                              if (await canLaunchUrlString(url)) {
                                await launchUrlString(
                                  url,
                                  mode: LaunchMode.externalApplication,
                                );
                              }
                            },
                            child: const Text('open in browser'),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              final url = 'https://flutter.dev';
                              if (await canLaunchUrlString(url)) {
                                await launchUrlString(
                                  url,
                                  mode: LaunchMode.inAppWebView,
                                );
                              }
                            },
                            child: const Text('open inside app'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CircleAvatarWidget extends StatelessWidget {
  final String contactName;
  final IconData iconName;

  CircleAvatarWidget(this.contactName, this.iconName);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 40,
        ),
        CircleAvatar(
          backgroundColor: Colors.grey[600],
          child: Icon(
            iconName,
            color: Colors.white,
          ),
        ),
        Text(
          contactName,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}

class ContactListItems extends StatelessWidget {
  final IconData iconName;
  final String hintText;
  ContactListItems(
    this.iconName,
    this.hintText,
  );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // controller: ,
      // validator: ,
      // cursorColor: secondarycolor,
      decoration: InputDecoration(
        prefixIcon: Icon(
          iconName,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        hintText: hintText,
      ),
    );
  }
}
