import "package:flutter/material.dart";
import "package:flutter_login/screens/login_/components/body.dart";

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: body(),
    );
  }
}
