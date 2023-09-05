import 'package:flutter/material.dart';
import 'package:slicelife/models/user_model.dart';
import 'package:slicelife/screens/dashboard/home.dart';
import 'package:slicelife/services/common_service.dart';
import 'package:slicelife/services/user_service.dart';

import 'guest/auth.dart';
import 'guest/password.dart';
import 'guest/term.dart';

class GuestScreen extends StatefulWidget {
  const GuestScreen({super.key});

  @override
  State<GuestScreen> createState() => _GuestScreenState();
}

class _GuestScreenState extends State<GuestScreen> {
  final UserService _userService = UserService();
  final CommonService _commonService = CommonService();

  final List<Widget> _widgets = [];
  int _indexSelected = 0;

  // ignore: unused_field
  String _email = '';

  @override
  void initState() {
    super.initState();

    AuthScreen authScreen = AuthScreen(
      onChangedStep: (index, value) async {
        StateRegistration stateRegistration =
            await _userService.mailingList(value, stateRegistration: null);

        setState(() {
          _indexSelected = index;
          _email = value;
          if (stateRegistration == StateRegistration.COMPLETE) {
            _indexSelected = _widgets.length - 1;
          }
        });
      },
    );

    PasswordScreen passwordScreen =
        PasswordScreen(onChangedStep: (index, value) async {
      UserModel connectedUserModel = await _userService.auth(
        UserModel(
          email: _email,
          password: value,
        ),
      );
      if (mounted) {
        setState(() {
          if (index == 0) {
            _indexSelected = index;
          }
          // ignore: unnecessary_null_comparison
          if (connectedUserModel != null) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ));
          }
        });
      }
    });

    _commonService.terms.then(
      (terms) => setState(
        () => _widgets.addAll([
          authScreen,
          TermScreen(
            terms: terms,
            onChangedStep: (index) => setState(() => _indexSelected = index),
          ),
          passwordScreen,
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _widgets.isEmpty
          ? const SafeArea(
              child: Scaffold(
              body: Center(
                child: Text("Chargement..."),
              ),
            ))
          : _widgets.elementAt(_indexSelected),
    );
  }
}
