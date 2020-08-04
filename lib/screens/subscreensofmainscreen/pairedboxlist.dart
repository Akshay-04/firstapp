import 'package:wardlabs/widgets/contentinbox.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../../providerclasses/addedboxes.dart';
import 'package:flutter_blue/flutter_blue.dart';

class boxList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<BluetoothDevice> listofalreadypairedboxes =
        Provider.of<pairedboxes>(context).getListOfpairedBoxes;
    return Container(
        child: GridView(
      padding: EdgeInsets.all(25),
      children: <Widget>[ 
        if(listofalreadypairedboxes.isNotEmpty)
        ...listofalreadypairedboxes.map((element) {
          return contentInBox(
            element
          );
        }).toList()
        else
        Text('Empty'),
      ],
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 4 / 3,
          crossAxisSpacing: 30,
          mainAxisSpacing: 30),
    ));
  }
}
