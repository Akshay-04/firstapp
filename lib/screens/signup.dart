import 'package:flutter/material.dart';

class Signup extends StatelessWidget {
  static String routeName = '/signup';
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signup'),
      ),
      body: Form(
          child: ListView(
        padding: EdgeInsets.all(30),
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: 'email'),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Name'),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Password'),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Confirm Password'),
          ),
          RaisedButton(
            onPressed: () {
              if (!Form.of(context).validate()) {
                return;
              }
              Form.of(context).save();
            },
            child: Text('Submit'),
          )
        ],
      )),
    );
  }
}
