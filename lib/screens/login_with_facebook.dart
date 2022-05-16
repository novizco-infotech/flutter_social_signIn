import 'package:firebase_google_signin/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class LoginWithFacebook extends StatefulWidget {
  const LoginWithFacebook({Key? key}) : super(key: key);

  @override
  State<LoginWithFacebook> createState() => _LoginWithFacebookState();
}

class _LoginWithFacebookState extends State<LoginWithFacebook> {
  

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<AuthProvider>(context, listen: false);
    
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Facebook Auth Project')),
        body:
            
            Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
             
              Container(
                height: 100.0,
                width: 100.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(userData.fbImageUrl!),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(userData.fbUserName!),
              const SizedBox(height: 5),
              Text(userData.fbUserEmail!),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton.icon(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green)),
                icon: const FaIcon(
                  FontAwesomeIcons.facebook,
                  color: Colors.white,
                ),
                label: const Text("Login in with Facebook"),
                onPressed: () async {
                  await Provider.of<AuthProvider>(context, listen: false)
                      .loginWithFacebook();
                  setState(() {});
                },
              ),
              ElevatedButton.icon(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red)),
                icon: const FaIcon(
                  FontAwesomeIcons.facebook,
                  color: Colors.white,
                ),
                label: const Text("Logout"),
                onPressed: () async {
                  await Provider.of<AuthProvider>(context, listen: false)
                      .facebookLogout();
                  setState(() {});
                },
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  size: 30,
                ),
                tooltip: 'back to home screen',
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
