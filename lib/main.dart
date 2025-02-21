import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'home_page.dart'; // Import HomePage

void main() {
  runApp(CupertinoApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => TelegramLogin(),
      '/login': (context) => TelegramLogin(),
      '/home': (context) => HomePage(),
    },
  ));
}

class TelegramLogin extends StatefulWidget {
  const TelegramLogin({super.key});

  @override
  State<TelegramLogin> createState() => _TelegramLoginState();
}

class _TelegramLoginState extends State<TelegramLogin>
    with SingleTickerProviderStateMixin {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;
  String? errorMessage;

  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  bool _isHoveringUsername = false;
  bool _isHoveringPassword = false;

  @override
  void initState() {
    super.initState();

    // Animation controller for glowing border
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: false);

    _colorAnimation = _controller.drive(
      ColorTween(
        begin: Colors.blue.shade300,
        end: Colors.blue.shade900,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _login(BuildContext context) {
    String username = _usernameController.text;
    String password = _passwordController.text;

    setState(() {
      if (username == "tele" && password == "ganda") {
        errorMessage = null;
        Navigator.pushReplacement(
          context,
          CupertinoPageRoute(builder: (context) => const HomePage()),
        );
      } else {
        errorMessage = "Invalid username or password";
      }
    });
  }