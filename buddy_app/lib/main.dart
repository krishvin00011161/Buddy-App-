import 'package:buddy_app/screens/Home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:buddy_app/screens/LoginScreens/welcome_screen.dart';
import 'package:buddy_app/screens/LoginScreens/login_screen.dart';
import 'package:buddy_app/screens/LoginScreens/registration_screen.dart';
import 'package:buddy_app/screens/LoginScreens/chat_screen.dart';

void main() => runApp(FlashChat());

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        ChatScreen.id: (context) => ChatScreen(),
        Homescreen.id: (context) => Homescreen(),
      },
    );
  }
}