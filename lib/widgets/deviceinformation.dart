import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:wardlabs/providerclasses/addedboxes.dart';
import 'package:flutter_blue/flutter_blue.dart';
<<<<<<< HEAD
import 'package:wardlabs/providerclasses/basicbox.dart';
import '../screens/subscreensofmainscreen/addnewboxes.dart';

class deviceInformation extends StatefulWidget {
  static String routeName = '/deviceInformation';

  @override
  _deviceInformationState createState() => _deviceInformationState();
}

class _deviceInformationState extends State<deviceInformation> {
  bool isLoading = false;
=======
class deviceInformation extends StatelessWidget {
  static String routeName = '/deviceInformation';
>>>>>>> parent of f807b8e... df
  Widget build(BuildContext context) {
    bool _paired(BluetoothDevice device) {
      List<BluetoothDevice> temp =
          Provider.of<pairedboxes>(context).listofpairedboxes;
      for (int i = 0; i < temp.length; i++) {
        if (device.id == temp[i].id) {
          return true;
        }
      }
      return false;
    }

    final args =
<<<<<<< HEAD
        ModalRoute.of(context).settings.arguments as Map<String, Object>;
    BluetoothDevice thisdevice = args['selecteddevice'];
    List<BluetoothService> _services = args['services'];
=======
        ModalRoute.of(context).settings.arguments as BluetoothDevice;
    String name = args.name;
>>>>>>> parent of f807b8e... df
    return Scaffold(
        appBar: AppBar(
          title: Text(name),
        ),
        body: Container(
<<<<<<< HEAD
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : Card(
                    child: Column(children: <Widget>[
                      if (!_paired(thisdevice))
                        RaisedButton(
                          onPressed: () {
                            setState(() {
                              isLoading = true;
                            });
                            Provider.of<pairedboxes>(context, listen: false)
                                .pairnewbox(thisdevice)
                                .then((_) {
                              setState(() {
                                isLoading = false;
                              });
                              Navigator.pop(context);
                            });
                          },
                          child: Text('Pair'),
                        )
                      else
                        RaisedButton(
                            child: Text('Unpair'),
                            onPressed: () {
                              setState(() {
                                isLoading = true;
                              });

                              Provider.of<pairedboxes>(context, listen: false)
                                  .unpairbox(thisdevice);

                              Navigator.pop(context);
                            }),
                      if (_paired(thisdevice))
                        RaisedButton(
                          child: Text('On'),
                          onPressed: () {
                            print(_services);
                            try {
                              _services[0]
                                  .characteristics[0]
                                  .write(utf8.encode('ON'));
                            } catch (error) {
                              showDialog(
                                  context: context,
                                  child: AlertDialog(
                                    title: Text('error'),
                                    content: Text(error.toString()),
                                  ));
                            }
                          },
                        ),
                      if (_paired(thisdevice))
                        RaisedButton(
                            child: Text('Off'),
                            onPressed: () {
                              try {
                                _services[0]
                                    .characteristics[0]
                                    .write(utf8.encode('OFF'));
                              } catch (error) {
                                showDialog(
                                    context: context,
                                    child: AlertDialog(
                                      title: Text('error'),
                                      content: Text(error.toString()),
                                    ));
                              }
                            })
                    ]),
                    elevation: 20,
                  ),
=======
            child: Card(
              child: Column(children: <Widget>[
                if (!_paired(args))
                  RaisedButton(
                    onPressed: () {
                      Provider.of<pairedboxes>(context,listen:false).pairnewbox(args);
                      Navigator.pop(context);
                    },
                    child: Text('Pair'),
                  )
                else
                  RaisedButton(
                    onPressed: () {
                      Provider.of<pairedboxes>(context,listen: false).unpairbox(args);
                      Navigator.pop(context);
                    },
                    child: Text('Unpair'),
                  )
              ]),
              elevation: 20,
            ),
>>>>>>> parent of f807b8e... df
            width: double.infinity));
  }
}
