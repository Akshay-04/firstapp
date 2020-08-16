import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  static String routeName = '/signup';

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  Map<String, String> au = {'name': '', 'email': '', 'password': ''};
  TextEditingController pass=TextEditingController();
  final _key = GlobalKey<FormState>();
  final FocusNode emailfocus = FocusNode(),
      namefocus = FocusNode(),
      passwordfocus = FocusNode(),
      confirmfocus = FocusNode();

  @override
  void dispose() {
    emailfocus.dispose();
    passwordfocus.dispose();
    confirmfocus.dispose();
    super.dispose();
  }

  void saveform() {
     //print(pass);
   if (!_key.currentState.validate()) {
        return;
    }
    _key.currentState.save();
    print(au['email']);
    print(au['password']);
    print(pass);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signup'),
      ),
      body: Form(
          key: _key,
          child: ListView(
            padding: EdgeInsets.all(30),
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'email'),
                focusNode: emailfocus,
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(namefocus);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Field required';
                  }
                },
                onSaved: (newValue) {
                  au['email'] = newValue;
                },
              ),
              TextFormField(
                  decoration: InputDecoration(labelText: 'Name'),
                  focusNode: namefocus,
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(passwordfocus);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'fieldb required';
                    }
                  },
                  onSaved: (newValue) {
                    au['name'] = newValue;
                  }),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                focusNode: passwordfocus,
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(confirmfocus);
                },
                onSaved: (newValue) {
                  au['password'] = newValue;
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'field required';
                  }
                },
              ),
              TextFormField(
                  decoration: InputDecoration(labelText: 'Confirm Password'),
                  focusNode: confirmfocus,
                  textInputAction: TextInputAction.done,
                  controller: pass,

                  validator: (value) {
                    if (value.isEmpty) {
                      return 'field required';
                    }
                    if (pass.text == au['password']) {
                      return 'password must match';
                    }
                  }),
              FormField(
                builder: (field) {
                  return RaisedButton(
                      onPressed: () {
                        saveform();
                      },
                      child: Text('Submit'));
                },
              )
            ],
          )),
    );
  }
}
