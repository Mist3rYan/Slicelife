import 'package:flutter/material.dart';

class TermScreen extends StatefulWidget {
  final Function(int) onChangedStep;
  const TermScreen({Key? key, required this.onChangedStep}) : super(key: key);

  @override
  State<TermScreen> createState() => _TermScreenState();
}

class _TermScreenState extends State<TermScreen> {
  late ScrollController _scrollController;
  bool _termsReaded = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.offset >=
              _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        setState(() => _termsReaded = true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            titleSpacing: 0.0,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0.0,
            title: const Text('Termes & Conditions',
                style: TextStyle(color: Colors.black)),
            leading: IconButton(
              onPressed: () => widget.onChangedStep(0),
              icon: const Icon(Icons.arrow_back),
              color: Colors.black,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(
              left: 15.0,
              right: 15.0,
              bottom: 15.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                              '''Bienvenue sur SliceLife, une application Android de partage de photos et de messages créée et détenue par MyCodeApps. Avant d'utiliser SliceLife, veuillez lire attentivement les présents Termes et Conditions. En utilisant notre application, vous acceptez de vous conformer à ces conditions. Si vous n'acceptez pas ces conditions, veuillez ne pas utiliser l'application SliceLife.

1. Compte utilisateur

  1.1 Vous devez avoir un compte utilisateur pour utiliser SliceLife. Lors de la création de votre compte, vous devez fournir une adresse e-mail valide et un mot de passe sécurisé. Vous êtes responsable de la confidentialité de vos informations d'identification et de tout accès non autorisé à votre compte. Vous acceptez de notifier immédiatement SliceLife de toute utilisation non autorisée de votre compte.

  1.2 Vous ne pouvez pas créer de compte pour une autre personne sans leur consentement explicite.

2. Contenu Utilisateur

  2.1 Vous êtes entièrement responsable du contenu que vous partagez sur SliceLife, que ce soit sous forme de photos, de messages ou d'autres médias. Vous acceptez de ne pas publier de contenu offensant, illégal, diffamatoire, ou qui enfreint les droits de propriété intellectuelle de tiers.

  2.2 MyCodeApps se réserve le droit de supprimer tout contenu jugé inapproprié ou en violation de ces Termes et Conditions.

3. Propriété Intellectuelle

  3.1 SliceLife et son contenu, y compris mais sans s'y limiter, le design, les textes, les graphiques, les images, les vidéos et les logos, sont la propriété exclusive de MyCodeApps et sont protégés par les lois sur la propriété intellectuelle.

  3.2 Vous ne pouvez pas reproduire, distribuer, modifier ou exploiter de quelque manière que ce soit le contenu de SliceLife sans l'autorisation écrite préalable de MyCodeApps.

4. Confidentialité

  4.1 Votre utilisation de SliceLife est soumise à notre Politique de Confidentialité, qui régit la collecte, l'utilisation et la divulgation de vos informations personnelles. En utilisant l'application, vous consentez à nos pratiques de confidentialité.

5. Modifications des Termes et Conditions

  5.1 MyCodeApps se réserve le droit de modifier ces Termes et Conditions à tout moment. Les modifications prendront effet dès leur publication sur l'application. Il est de votre responsabilité de consulter régulièrement ces Termes et Conditions pour vous tenir informé des mises à jour.

6. Résiliation

  6.1 MyCodeApps se réserve le droit de résilier ou de suspendre votre compte et votre accès à SliceLife à tout moment, sans préavis, en cas de violation de ces Termes et Conditions.

7. Loi Applicable

  7.1 Ces Termes et Conditions sont régis par les lois en vigueur. Tout litige découlant de l'utilisation de SliceLife sera soumis à la juridiction compétente.

En utilisant l'application SliceLife, vous acceptez d'être lié par ces Termes et Conditions. Si vous avez des questions ou des préoccupations, veuillez nous contacter à l'adresse mycodeapps@gmail.com.

Dernière mise à jour : 01/09/2023 '''),
                        ]),
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
                  onPressed: !_termsReaded ? null : () => widget.onChangedStep(2),
                  child: const Text('Accepter & Continuer'),
                ),
              ],
            ),
          )),
    );
  }
}
