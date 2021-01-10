import 'dart:ui';
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:vibration/vibration.dart';
import 'package:just_audio/just_audio.dart';

part 'data.dart';
part 'drawer.dart';
part 'background.dart';
part 'measure.dart';
part 'firstpage.dart';
part 'spinkit.dart';

void main() {
  runApp(MehekBox());
}

class MehekBox extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mehek Box',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      initialRoute: "/measure",
      routes: {
        '/measure': (context) => FirstPage(boxData: measureData),
        '/beat': (context) => FirstPage(boxData: beatData),
        '/threeFour': (context) => FirstPage(boxData: threeFourData),
        '/privacy': (context) => PrivacyPolicy(),
      },
    );
  }
}




class PrivacyPolicy extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Policy'),
      ),
      body: Text(
          'At the present (7/21/20), the Mehek Box app and webapp do not intake any user data, in any form.'
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Menu'),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
            ),
            ListTile(
              title: Text('Measure Box'),
              onTap: () {
                Navigator.pushNamed(context, '/measure');
              },
            ),
            ListTile(
              title: Text('Beat Box'),
              onTap: () {
                Navigator.pushNamed(context, '/beat');
              },
            ),
            ListTile(
              title: Text('3/4 Box'),
              onTap: () {
                Navigator.pushNamed(context, '/threeFour');
              },
            ),
            ListTile(
              title: Text('Privacy Policy'),
              onTap: () {
                Navigator.pushNamed(context, '/privacy');
              },
            ),
          ],
        ),
      ),
    );
  }
}
