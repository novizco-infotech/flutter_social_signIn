import 'package:firebase_google_signin/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class LoginWithGoogle extends StatefulWidget {
  const LoginWithGoogle({Key? key}) : super(key: key);

  @override
  State<LoginWithGoogle> createState() => _LoginWithGoogleState();
}

class _LoginWithGoogleState extends State<LoginWithGoogle> {
  


  
  
  @override
  Widget build(BuildContext context) {
     final userData = Provider.of<AuthProvider>(context,listen: false);
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 40,
            backgroundImage: NetworkImage(userData.googleImageUrl!),
            
          ),
          const SizedBox(height: 10),
          Text(userData.googleUserName!),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(userData.googleUserEmail!),
            ],
          ),
          const SizedBox(height: 30),
          ElevatedButton.icon(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green)),
            icon: const FaIcon(
              FontAwesomeIcons.google,
              color: Colors.white,
            ),
            label: const Text("Sign in with Google"),
            onPressed: () async {
              await Provider.of<AuthProvider>(context,listen: false).signInWithGoogle();
              setState(() {
          
              });
              
            },
          ),
          ElevatedButton.icon(
            icon: const FaIcon(
              FontAwesomeIcons.google,
              color: Colors.white,
            ),
            label: const Text("signout"),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red)),
            onPressed: () async {
               Provider.of<AuthProvider>(context,listen: false).googleSignOut();
             
              setState(() {
                
              });
            },
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back,size: 30,),
            tooltip: 'back to home screen',
            color: Colors.black,
          ),
        ],
      ),
    );
  }

  
}
