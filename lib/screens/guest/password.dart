import 'package:flutter/material.dart';

class PasswordScreen extends StatefulWidget {
  final Function(int, String) onChangedStep;
  const PasswordScreen({Key? key, required this.onChangedStep})
      : super(key: key);

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isSecret = true;
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () => widget.onChangedStep(0,''),
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
        ),
      ),
      body: Center(
          child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                children: [
                  Text(
                    "Mot de passe".toUpperCase(),
                    style: const TextStyle(
                      fontSize: 30.0,
                    ),
                  ),
                  const SizedBox(
                    height: 50.0,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text('Entrez votre mot de passe'),
                        const SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          obscureText: _isSecret,
                          onChanged: (value) =>
                              setState(() => _password = value),
                          validator: (value) => value!.length < 6
                              ? 'Le mot de passe doit contenir au moins 6 caractères'
                              : null,
                          decoration: InputDecoration(
                            suffixIcon: InkWell(
                              onTap: () => setState(
                                () => _isSecret = !_isSecret,
                              ),
                              child: Icon(!_isSecret
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                            ),
                            hintText: 'Ex: gh;Mi5@sT',
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.all(
                                Radius.circular(0.0),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                            elevation: 0.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0.0),
                            ),
                          ),
                          onPressed: _password.length < 6
                              ? null
                              : () {
                                  if (_formKey.currentState!.validate()) {
                                    widget.onChangedStep(2, _password);
                                  }
                                },
                          child: const Text('Continuer'),
                        ),
                      ],
                    ),
                  ),
                ],
              ))),
    ));
  }
}
