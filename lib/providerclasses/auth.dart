import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import './errorhandling/autherror.dart';

class authentiation with ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  AuthResultStatus _status;
  FirebaseUser authuser;
  IdTokenResult token;

  ///
  /// Helper Functions
  ///
  Future<AuthResultStatus> signup(email, pass) async {
    try {
      AuthResult authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: pass);

      if (authResult.user != null) {
        authuser = await _auth.currentUser();
        token = await authuser.getIdToken(refresh: true);

        _status = AuthResultStatus.successful;
        notifyListeners();
      } else {
        _status = AuthResultStatus.undefined;
      }
    } catch (e) {
      print('Exception @createAccount: $e');
      _status = AuthExceptionHandler.handleException(e);
    }
    return _status;
  }

  bool get checktoken {
    if (token == null) {
      return false;
    }
    //  else if (token.expirationTime.isAfter(DateTime.now())) {
    //   return false;
    // }
  
    return true;
  }

  String get authkey {
    return token.token;
  }

  Future<AuthResultStatus> login(String email, String pass) async {
    try {
      AuthResult authResult =
          await _auth.signInWithEmailAndPassword(email: email, password: pass);

      if (authResult.user != null) {
        authuser = await _auth.currentUser();
        token = await authuser.getIdToken();
        _status = AuthResultStatus.successful;
        notifyListeners();
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

  logout() async {
    await _auth.signOut();
    token = null;
    notifyListeners();
  }

  String getuid() {
    return authuser.uid;
  }
}
