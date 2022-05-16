import 'package:firebase_google_signin/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key, this.title}) : super(key: key);
  final String? title;
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
     final userData = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: Text('Signin With ${widget.title}'),
        backgroundColor: Colors.brown,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_outlined),
            onPressed: () async {
              Provider.of<AuthProvider>(context, listen: false)
                  .signOut('google');
              Navigator.of(context).pop();
              setState(() {});
            },
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 80,
              backgroundImage: NetworkImage(userData.imageUrl!),
            ),
            const SizedBox(height: 10),
            Text(
              userData.userName!,
              style: const TextStyle(fontSize: 30),
            ),
            const SizedBox(height: 5),
            Text(
              userData.userEmail!,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
