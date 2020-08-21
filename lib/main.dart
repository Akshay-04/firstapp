import 'package:flutter/material.dart';
import 'package:wardlabs/ScreensforAuth/Screens/Welcome/welcome_screen.dart';
import 'package:wardlabs/providerclasses/addedboxes.dart';
import 'package:wardlabs/providerclasses/auth.dart';
import 'package:wardlabs/providerclasses/basicboxprev.dart';
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
              return authentiation();
            },
          ),
           ChangeNotifierProvider(
            create: (context) {
              return pairedboxes();
            },)
        ],
        child: Consumer<authentiation>(
          builder: (context, value, child) {
            bool islogged = value.checktoken;
            return MaterialApp(
              key: UniqueKey(),
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primaryColor: Color.fromRGBO(255, 66, 85, 1),
                accentColor: Color.fromRGBO(60, 250, 199, 1),
                scaffoldBackgroundColor: Colors.white,
              ),
              home: islogged ? mainscreen(UniqueKey()) : WelcomeScreen(),
              routes: {
                mainscreen.routeName: (co) {
                  return mainscreen(UniqueKey());
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
            );
          },
        ));
  }
}
