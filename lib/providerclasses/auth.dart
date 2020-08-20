import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import './errorhandling/autherror.dart';

class authentiation with ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  AuthResultStatus _status;
  FirebaseUser authuser;

  ///
  /// Helper Functions
  ///
  Future<AuthResultStatus> signup(email, pass) async {
    try {
      AuthResult authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: pass);
      if (authResult.user != null) {
        authuser = await _auth.currentUser();
        _status = AuthResultStatus.successful;
      } else {
        _status = AuthResultStatus.undefined;
      }
    } catch (e) {
      print('Exception @createAccount: $e');
      _status = AuthExceptionHandler.handleException(e);
    }
    return _status;
  }

  Future<AuthResultStatus> login(email, pass) async {
    try {
      final authResult =
          await _auth.signInWithEmailAndPassword(email: email, password: pass);

      if (authResult.user != null) {
        authuser = await _auth.currentUser();
        _status = AuthResultStatus.successful;
      } else {
        _status = AuthResultStatus.undefined;
      }
    } catch (e) {
      print(e.toString());
      print('Exception @createAccount: $e');
      _status = AuthExceptionHandler.handleException(e);
    }
    return _status;
  }

  logout() {
    _auth.signOut();
  }

  String getuid() {
    return authuser.uid;
  }
}
