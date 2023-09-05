import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  final Function(int) onChangedStep;
  const AuthScreen({Key? key, required this.onChangedStep}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final RegExp emailRegex = RegExp(
    r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
  );

  String _email = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                      text: 'Tout le monde a\n'.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 30.0,
                      ),
                      children: [
                        TextSpan(
                          text: 'quelque chose'.toUpperCase(),
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: '\nà partager'.toUpperCase(),
                        )
                      ]),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Text(
                  'Tout commence ici',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                const SizedBox(
                  height: 50.0,
                ),
                Form(
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text('Entrez votre email'),
                          const SizedBox(
                            height: 10.0,
                          ),
                          TextFormField(
                            onChanged: (value) =>
                                setState(() => _email = value),
                            validator: (value) =>
                                value == '' || !emailRegex.hasMatch(value!)
                                    ? 'Veuillez entrer un email valide'
                                    : null,
                            decoration: const InputDecoration(
                              hintText: 'Ex: john.doe@domain.fr',
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 1.0),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(0.0),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 1.0),
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
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15.0),
                              elevation: 0.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0.0),
                              ),
                            ),
                            onPressed: !emailRegex.hasMatch(_email)
                                ? null
                                : () {
                                    if (_formKey.currentState!.validate()) {
                                      widget.onChangedStep(1);
                                    }
                                  },
                            child: Text(
                              'Continuer'.toUpperCase(),
                            ),
                          ),
                        ]))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
