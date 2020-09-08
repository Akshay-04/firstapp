import 'dart:convert';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:wardlabs/providerclasses/addedboxes.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:wardlabs/providerclasses/auth.dart';
import 'package:wardlabs/providerclasses/basicboxprev.dart';
import 'package:wardlabs/screens/designofcard/designofcardfordevicedetailscreen.dart';
import '../screens/subscreensofmainscreen/addnewboxes.dart';

class deviceInformationfornewdevices extends StatefulWidget {
  BluetoothDevice thisdevice;
  Map<String, Object> select;
  deviceInformationfornewdevices(this.thisdevice, this.select);
  @override
  _deviceInformationfornewdevicesState createState() =>
      _deviceInformationfornewdevicesState();
}

class _deviceInformationfornewdevicesState
    extends State<deviceInformationfornewdevices> {
  bool isLoading = false;
  Widget build(BuildContext context) {
    // bool _paired(BluetoothDevice device) {
    //   List<BluetoothDevice> temp =
    //       Provider.of<pairedboxes>(context).listofpairedboxes;
    //   for (int i = 0; i < temp.length; i++) {
    //     if (device.id == temp[i].id) {
    //       return true;
    //     }
    //   }
    //   return false;
    // }
    @override
    void dispose() {
      widget.thisdevice.disconnect();
      super.dispose();
    }

    Provider.of<authentiation>(context);

    return Container(
        height: MediaQuery.of(context).size.height * 0.4,
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : cardfordetaildevices(
                widths: MediaQuery.of(context).size.width,
                primary: widget.select['primary'],
                chipColor: widget.select['chipColor'],
                backWidget: widget.select['backWidget'],
                chipText1: widget.thisdevice.name,
                chipText2: "online",
                functions: [
                  {
                    'name': 'Add Box',
                    'functiontoexecute': () {
                      adddevice(context, widget.thisdevice);
                    }
                  }
                ],
              ),
        width: double.infinity);
  }
}

// Card(
//                     child: Column(children: <Widget>[
//                       RaisedButton(
//                         onPressed: () async {
//                           setState(() {
//                             isLoading = true;
//                           });

//                           String uid =
//                               Provider.of<authentiation>(context, listen: false)
//                                   .getuid();
//                           String authkey =
//                               Provider.of<authentiation>(context, listen: false)
//                                   .authkey;

//                           await Provider.of<pairedboxes>(context, listen: false)
//                               .pairnewbox(widget.thisdevice, uid, authkey);

//                           setState(() {
//                             isLoading = false;
//                           });
//                           Navigator.pop(context);
//                         },
//                         child: Text('Pair'),
//                       )
//                     ]),
//                     elevation: 20,
//                   )

void adddevice(BuildContext context, BluetoothDevice device) async {
  {
    showDialog(
        context: context,
        child: AlertDialog(
          title: Center(child: CircularProgressIndicator()),
          content: Text('Adding Box'),
        ));

    String uid = Provider.of<authentiation>(context, listen: false).getuid();
    String authkey = Provider.of<authentiation>(context, listen: false).authkey;

    await Provider.of<pairedboxes>(context, listen: false)
        .pairnewbox(device, uid, authkey);
    Navigator.pop(context);
    Navigator.pop(context);
  }
}
