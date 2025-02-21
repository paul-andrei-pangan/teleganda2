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

  Widget _buildAnimatedTextField({
    required TextEditingController controller,
    required String placeholder,
    required Widget prefix,
    bool obscureText = false,
    Widget? suffix,
    required bool isHovering,
    required VoidCallback onEnter,
    required VoidCallback onExit,
  }) {
    return MouseRegion(
        onEnter: (_) => onEnter(),
    onExit: (_) => onExit(),
    child: Stack(
    children: [
    AnimatedBuilder(
    animation: _controller,
    builder: (context, child) {
    return Container(
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    border: Border.all(color: _colorAnimation.value ?? Colors.blue, width: 2),
    boxShadow: [
    BoxShadow(
    color: _colorAnimation.value?.withOpacity(0.5) ?? Colors.blue.withOpacity(0.5),
    blurRadius: 8,
    spreadRadius: 2,
    ),
     ],
    ),

      child: CupertinoTextField(
        controller: controller,
        obscureText: obscureText,
        padding: const EdgeInsets.all(12),
        prefix: prefix,
        suffix: suffix,
        decoration: BoxDecoration(
          color: CupertinoColors.systemGrey6,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
    },
    ),
      Positioned(
        left: 45, // ✅ Pinalayo sa icon para hindi matakpan
        top: isHovering || controller.text.isNotEmpty ? 0 : 18,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: TextStyle(
            fontSize: isHovering || controller.text.isNotEmpty ? 12 : 16,
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
          child: Text(placeholder),
        ),
      ),
    ],
    ),
    );
  }