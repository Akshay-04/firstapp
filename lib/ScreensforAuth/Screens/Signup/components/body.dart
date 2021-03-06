import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wardlabs/providerclasses/auth.dart';
import 'package:wardlabs/providerclasses/errorhandling/autherror.dart';
import 'package:wardlabs/screens/mainscreen.dart';
import '../../../Screens/Login/login_screen.dart';
import './background.dart';
import '../../../components/already_have_an_account_acheck.dart';
import '../../../components/rounded_button.dart';
import '../../../components/rounded_input_field.dart';
import '../../../components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String email = "", password = "";
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "SIGNUP",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/signup.svg",
              height: size.height * 0.35,
            ),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {
                email = value;
              },
            ),
            RoundedPasswordField(
              onChanged: (value) {
                password = value;
              },
            ),
            RoundedButton(
              text: "SIGNUP",
              press: () async {
                var result =
                    await Provider.of<authentiation>(context, listen: false)
                        .signup(email, password);
                if (result == AuthResultStatus.successful) {
                  //Navigator.pushReplacementNamed(context, mainscreen.routeName);
                } else {
                  String message =
                      AuthExceptionHandler.generateExceptionMessage(result);
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Could not signup'),
                      content: Text(message),
                      actions: [
                        FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Okay'))
                      ],
                    ),
                  );
                }
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
