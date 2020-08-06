import 'package:flutter/material.dart';
import 'package:wardlabs/providerclasses/addedboxes.dart';
import 'package:wardlabs/providerclasses/basicbox.dart';
import 'package:wardlabs/widgets/deviceinformation.dart';
import 'package:wardlabs/screens/mainscreen.dart';
import 'package:wardlabs/screens/subscreensofmainscreen/settingscreen.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(MyApp());
}

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
          theme: ThemeData(primarySwatch: Colors.red),
          home: mainscreen(),
          routes: {
            mainscreen.routeName: (co) {
              return mainscreen();
            },
            deviceInformation.routeName: (cont) {
              return deviceInformation();
            },
            settingscreen.routeName: (con) {
              return settingscreen();
            }
          },
        ));
  }
}
