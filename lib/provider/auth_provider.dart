import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider with ChangeNotifier {
  String? userName = '';
  String? userEmail = '';
  String? imageUrl = "";

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    userName = googleUser.displayName;
    userEmail = googleUser.email;
    imageUrl = googleUser.photoUrl;
    notifyListeners();
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  void signOut(String? title) async {
    title == 'google'
        ? await GoogleSignIn().signOut()
        : await FacebookAuth.instance.logOut();
    await FirebaseAuth.instance.signOut();    
    userName ='';
    userEmail='';
    imageUrl = '';    
    notifyListeners();
  }

  loginWithFacebook(BuildContext context) async {
    Map<String, dynamic>? _userData;
    final LoginResult result = await FacebookAuth.instance.login();

    if (result.status == LoginStatus.success) {
      final userData = await FacebookAuth.instance.getUserData();
      _userData = userData;
    } else {
      // ignore: avoid_print
      print(result.status);
      // ignore: avoid_print
      print(result.message);
    }
    if(_userData != null) {
    userName = _userData['name'];
    userEmail = _userData['email'];
    imageUrl = _userData['picture']['data']['url'];
    notifyListeners();
    } 
}
}