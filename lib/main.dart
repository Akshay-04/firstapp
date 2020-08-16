import 'package:flutter/material.dart';
import 'package:wardlabs/providerclasses/addedboxes.dart';
import 'package:wardlabs/providerclasses/basicbox.dart';
import 'package:wardlabs/screens/signup.dart';
import 'package:wardlabs/screens/subscreensofmainscreen/addnewboxes.dart';
import 'package:wardlabs/widgets/deviceinformationfornewdevices.dart';
import 'package:wardlabs/widgets/deviceinformationforpaireddevices.dart';
import 'package:wardlabs/screens/mainscreen.dart';
import 'package:wardlabs/screens/subscreensofmainscreen/settingscreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}
const kPrimaryColor = Color(0xFF6F35A5);
const kPrimaryLightColor = Color(0xFFF1E6FF);

//done
class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) {
              return pairedboxes();
            },
          )
        ],
        child: MaterialApp(
           theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
          home: mainscreen(),
          routes: {
            mainscreen.routeName: (co) {
              return mainscreen();
            },
            Signup.routeName: (co) {
              return Signup();
            },
            deviceInformationfornewdevices.routeName: (cont) {
              return deviceInformationfornewdevices();
            },
            settingscreen.routeName: (con) {
              return settingscreen();
            },
            deviceInformationforpaireddevices.routeName: (cont) {
              return deviceInformationforpaireddevices();
            },
            addNewBox.routename: (context) {
              return addNewBox();
            }
          },
        ));
  }
}
