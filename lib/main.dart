import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:slicelife/screens/dashboard/home.dart';
import 'package:slicelife/screens/guest.dart';
import 'package:slicelife/services/user_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final UserService _userService = UserService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slicelife',
      home: StreamBuilder(
        stream: _userService.user,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomeScreen();
          } else {
            return const GuestScreen();
          }
        },
      ),
    );
  }
}
