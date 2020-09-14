import 'package:bubbled_navigation_bar/bubbled_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:wardlabs/providerclasses/addedboxes.dart';
import 'package:wardlabs/screens/subscreensofmainscreen/pairedboxlist.dart';
import 'package:wardlabs/screens/drawerscreen.dart';
import 'package:provider/provider.dart';
import 'package:wardlabs/screens/subscreensofmainscreen/settingscreen.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

class mainscreen extends StatefulWidget {
  @override
  static String routeName = '/home';
  int screenindex = 0;
  mainscreen(Key key) : super(key: key);
  State<StatefulWidget> createState() {
    return mainscreenState();
  }
}

class mainscreenState extends State<mainscreen> {
  PageController _pageController;
  void _changescreen(int index) {
    setState(() {
      widget.screenindex = index;
    });
  }

  final List<Map<String, Object>> _screens = [
    {
      'Title': 'Live Streaming',
      'screen': boxlist(0,UniqueKey()),
    },
    {
      'Title': 'Settings',
      'screen': settingscreen(),
    }
  ];
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Consumer<pairedboxes>(
      builder: (context, value, child) {
        return Scaffold(
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(60), // here the desired height
                child: AppBar(
                  elevation: 10,
                  title: Text(_screens[widget.screenindex]['Title']),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(30),
                    ),
                  ),
                  centerTitle: true,
                )),
            drawer: drawerScreen(),
            body: _screens[widget.screenindex]['screen'],
            bottomNavigationBar: BottomNavyBar(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              selectedIndex: widget.screenindex,
              showElevation: true, // use this to remove appBar's elevation
              onItemSelected: (index) => setState(() {
                widget.screenindex = index;
                _changescreen(index);
                _pageController.animateToPage(index,
                    duration: Duration(milliseconds: 300), curve: Curves.ease);
              }),
              items: [
                BottomNavyBarItem(
                  icon: Icon(Icons.home),
                  inactiveColor: Colors.blueGrey,
                  title: Text('Home'),
                  activeColor: Theme.of(context).accentColor,
                ),
                BottomNavyBarItem(
                    inactiveColor: Colors.blueGrey,
                    icon: Icon(Icons.settings),
                    title: Text('Settings'),
                    activeColor: Theme.of(context).accentColor),
              ],
            ));
      },
    );
  }
}
