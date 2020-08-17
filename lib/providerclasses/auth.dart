import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class authentiation with ChangeNotifier {
  Future<String> getuid() async{
  FirebaseUser _user = await FirebaseAuth.instance.currentUser();
  return _user.uid;
  }
  
}
