import 'package:wardlabs/widgets/contentinbox.dart';
import 'package:provider/provider.dart';
import '../../providerclasses/basicbox.dart';
import 'package:flutter/material.dart';
import '../../providerclasses/addedboxes.dart';
import 'package:flutter_blue/flutter_blue.dart';

class addNewBox extends StatelessWidget {
  Color boxcolor = Colors.blue;

  availablebluetoothdevices listofdevices;

  Widget build(BuildContext context) {
    listofdevices = availablebluetoothdevices();
    return StreamBuilder<List<BluetoothDevice>>(
        stream: listofdevices.availabledevices,
        builder: (context, snapshot) {
          List<BluetoothDevice> devices;
          devices = snapshot.data;
          if (devices == null) {
            listofdevices = availablebluetoothdevices();

            return Text('dfj');
          }
          if (devices.length == 0) {
            return Text('not found');
          }
          return GridView.builder(
            itemCount: devices.length,
            itemBuilder: (context, index) {
              BluetoothDevice q = devices[index];
              return contentInBox(q);
            },
            padding: EdgeInsets.all(25),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 4 / 3,
                crossAxisSpacing: 30,
                mainAxisSpacing: 30),
          );
        });
  }
}
