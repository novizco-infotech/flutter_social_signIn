import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider with ChangeNotifier {
  String? googleUserName = 'User Name';
  String? googleUserEmail = 'Email Id';
  String? googleImageUrl =
      "https://www.freepnglogos.com/uploads/google-logo-png/google-logo-png-suite-everything-you-need-know-about-google-newest-0.png";
  

  String? fbUserName = 'User Name';
  String? fbUserEmail = 'Email Id';
  String? fbImageUrl =
      'https://upload.wikimedia.org/wikipedia/commons/4/44/Facebook_Logo.png?20170210095314';

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

    googleUserName = googleUser.displayName;
    googleUserEmail = googleUser.email;
    googleImageUrl = googleUser.photoUrl;

    print("google user..............$googleUser");
    notifyListeners();
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  void googleSignOut() async {
    await FirebaseAuth.instance.signOut();
    googleUserEmail = 'Email Id';
    googleImageUrl =
        "https://www.freepnglogos.com/uploads/google-logo-png/google-logo-png-suite-everything-you-need-know-about-google-newest-0.png";
    googleUserName = 'User Name';
    notifyListeners();
  }

  loginWithFacebook() async {
    Map<String, dynamic>? _userData;
    final LoginResult result = await FacebookAuth.instance.login();

    if (result.status == LoginStatus.success) {
      final userData = await FacebookAuth.instance.getUserData();
      _userData = userData;
    } else {
      print(result.status);
      print(result.message);
    }
    fbUserName = _userData!['name'];
    fbUserEmail = _userData['email'];
    fbImageUrl = _userData['picture']['data']['url'];
    notifyListeners();
  }

  facebookLogout() async {
    await FacebookAuth.instance.logOut();
    fbUserName = 'User Name';
    fbUserEmail = 'Email Id';
    fbImageUrl =
        'https://upload.wikimedia.org/wikipedia/commons/4/44/Facebook_Logo.png?20170210095314';
    notifyListeners();
  }
}
