import 'package:chat_app_sockets/helpers/show_snack.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat_app_sockets/widgets/custom_input.dart';
import 'package:chat_app_sockets/widgets/logo.dart';
import 'package:chat_app_sockets/services/auth_service.dart';
import 'package:chat_app_sockets/widgets/custom_button.dart';
import 'package:chat_app_sockets/widgets/labels.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height * .9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Logo(),
                  _Form(),
                  Labels(
                    route: "register",
                  ),
                  Text("Terminos y condiciones",
                      style: TextStyle(fontWeight: FontWeight.w200))
                ],
              ),
            ),
          ),
        ));
  }
}

class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailTxtController = TextEditingController();
  final passwordTxtController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authSevice = Provider.of<AuthService>(
      context,
    );

    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.mail_outline,
            placeholder: "Correo electronico",
            controller: emailTxtController,
            keyboardType: TextInputType.emailAddress,
          ),
          CustomInput(
            icon: Icons.password_outlined,
            placeholder: "Contraseña",
            controller: passwordTxtController,
            isPassword: true,
          ),
          CustomButton(
            label: "Login",
            onPressed: (authSevice.loadingAuth)
                ? null
                : () async {
                    FocusScope.of(context).unfocus();
                    final loginSuccess = await authSevice.login(
                        emailTxtController.text.trim(),
                        passwordTxtController.text.trim());
                    if (loginSuccess.ok) {
                      Navigator.pushReplacementNamed(context, "users");
                      return showSnackBar(
                        context: context,
                        color: Colors.green,
                        title: loginSuccess.msj,
                      );
                    }
                    return showSnackBar(
                      context: context,
                      color: Colors.red,
                      title: loginSuccess.msj,
                    );
                  },
          )
        ],
      ),
    );
  }
}
