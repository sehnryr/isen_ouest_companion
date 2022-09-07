import 'package:flutter/material.dart';
import 'package:isen_ouest_companion/recover_password/recover_password_app_bar.dart';
import 'package:isen_ouest_companion/recover_password/recover_password_footer.dart';
import 'package:progress_hud/progress_hud.dart';

import 'package:isen_ouest_companion/base/base_constant.dart';
import 'package:isen_ouest_companion/base/code_input.dart';
import 'package:isen_ouest_companion/base/username_input.dart';
import 'package:isen_ouest_companion/recover_password/recover_password_send_link_button.dart';

class RecoverPasswordPage extends StatefulWidget {
  final TextEditingController? usernameController;

  const RecoverPasswordPage({Key? key, this.usernameController})
      : super(key: key);

  @override
  RecoverPasswordPageState createState() => RecoverPasswordPageState();
}

class RecoverPasswordPageState extends State<RecoverPasswordPage> {
  late TextEditingController usernameController;
  late TextEditingController codeController;
  bool usernameError = false;
  bool codeError = false;

  @override
  void initState() {
    usernameController = widget.usernameController ?? TextEditingController();
    codeController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: Scaffold(
        appBar: const RecoverPasswordAppBar(),
        body: Container(
          padding: padding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Mot de passe oublié ?",
                style: Theme.of(context).textTheme.headline1,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                "Indiquez votre identifiant et code¹ et recevez un lien par mail pour réinitialiser votre mot de passe.",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              UsernameInput(
                controller: usernameController,
                error: usernameError,
                onChanged: (String string) => setState(() => usernameError =
                    string.isEmpty || !RegExp(r'^[a-z0-9]+$').hasMatch(string)),
              ),
              CodeInput(
                controller: codeController,
                error: codeError,
                onChanged: (String string) => setState(() => codeError =
                    string.isEmpty || !RegExp(r'^[0-9]+$').hasMatch(string)),
              ),
              SendLinkButton(onPressed: () {
                if (usernameController.text.isEmpty) {
                  setState(() => usernameError = true);
                }
                if (codeController.text.isEmpty) {
                  setState(() => codeError = true);
                }
                // TODO: make the request to the server to do the password reset
              }),
            ],
          ),
        ),
        bottomNavigationBar: const RecoverPasswordFooter(),
      ),
    );
  }
}