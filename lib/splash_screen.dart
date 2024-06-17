import 'package:flutter/material.dart';
import 'package:todo_app/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => const HomeScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/splash_back_image.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 170,
            ),
            Container(
              height: 250,
              width: 250,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red,
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/logo/todo_logo.jpeg',
                  fit: BoxFit.cover,
                  width: 20,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              'Todo App',
              style: TextStyle(
                fontSize: 40,
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
