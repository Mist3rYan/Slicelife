import 'package:flutter/material.dart';
import 'package:slicelife/screens/guest.dart';
import 'package:slicelife/services/user_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final UserService _userService = UserService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: TextButton(
              onPressed: () async {
                await _userService.signOut();
                // ignore: use_build_context_synchronously
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const GuestScreen(),
                    ),
                    (route) => false);
              },
              child: const Text('Deconnexion')),
        ),
      ),
    );
  }
}
