import 'package:flutter/material.dart';
import 'package:quran_lang_test/view/onboarding/onboarding_pages.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FlutterLogo(),
          SizedBox(height: 20),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
          SizedBox(height: 20),
          Text(
            'Preparing the app for you...',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meeting Exchange'),
      ),
      body: const Center(
        child: Text('Welcome to Meeting Exchange!'),
      ),
    );
  }
}

class MeetingExchangeApp extends StatefulWidget {
  const MeetingExchangeApp({super.key});

  @override
  _MeetingExchangeAppState createState() => _MeetingExchangeAppState();
}

class _MeetingExchangeAppState extends State<MeetingExchangeApp> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const BoardPages()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meeting Exchange',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}
