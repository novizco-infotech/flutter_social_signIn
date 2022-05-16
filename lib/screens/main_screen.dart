import 'package:firebase_google_signin/provider/auth_provider.dart';
import 'package:firebase_google_signin/screens/login_screen.dart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool checking = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Select Option For Login"),
        backgroundColor: Colors.brown,
      ),
      body: checking
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    label: const Text("Login with Google"),
                    icon: const FaIcon(
                      FontAwesomeIcons.google,
                      color: Colors.white,
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.green)),
                    onPressed: () async {
                      setState(() {
                        checking = true;
                      });
                      await Provider.of<AuthProvider>(context, listen: false)
                          .signInWithGoogle();
                      setState(() {
                        checking = false;
                      });
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(
                            title: 'google',
                          ),
                        ),
                      );
                    },
                  ),
                  ElevatedButton.icon(
                    label: const Text("Login with facebook"),
                    icon: const FaIcon(
                      FontAwesomeIcons.facebook,
                      color: Colors.white,
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.green)),
                    onPressed: () async {
                      setState(() {
                        checking = true;
                      });
                      await Provider.of<AuthProvider>(context, listen: false)
                          .loginWithFacebook(context);
                          
                      setState(() {
                        checking = false;
                      });
                      Provider.of<AuthProvider>(context, listen: false)
                                  .userName ==
                              ''
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomeScreen(),
                              ))
                          : Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    const LoginScreen(title: 'facebook'),
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
