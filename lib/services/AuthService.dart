import 'package:firebase_auth/firebase_auth.dart';
class AuthService {

  //1- Create instance
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //2- return a user via Future async await

  //sign in anonyme
  Future signInAnom() async {

    try {

      AuthResult result = await _auth.signInAnonymously();

      FirebaseUser user = result.user;

      return user;

    }

    catch(e) {

      print(e.toString());

      return null;

    }

  }

  //sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async {

    try {

      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);

      FirebaseUser user = result.user;

      return user;

    } catch (error) {

      print(error.toString());

      return null;

    }

  }


  //register  with email & password

  Future registerWithEmailAndPassword(String email, String password) async {

    try {

      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);

      FirebaseUser user = result.user;

      return user;

    } catch (error) {

      print(error.toString());

      return null;

    }

  }

  //sign out
  Future signOut() async {

    try {

      return await _auth.signOut();

    } catch (error) {

      print(error.toString());

      return null;

    }

  }
}

