import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:chat_app_sockets/widgets/custom_input.dart';
import 'package:chat_app_sockets/widgets/logo.dart';
import 'package:chat_app_sockets/helpers/show_snack.dart';
import 'package:chat_app_sockets/services/auth_service.dart';
import 'package:chat_app_sockets/widgets/custom_button.dart';
import 'package:chat_app_sockets/widgets/labels.dart';

class RegisterPage extends StatelessWidget {
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
                  Logo(
                    title: "Registro",
                  ),
                  _Form(),
                  Labels(
                    title: "¿Ya tienes cuenta?",
                    subtitle: "Iniciar sesión ahora",
                    route: "login",
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
  final nameTxtController = TextEditingController();
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
            icon: Icons.group,
            placeholder: "Nombre",
            controller: nameTxtController,
            keyboardType: TextInputType.emailAddress,
          ),
          CustomInput(
            icon: Icons.email_outlined,
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
            label: "Registro",
            onPressed: (authSevice.loadingAuth)
                ? null
                : () async {
                    FocusScope.of(context).unfocus();
                    final registerSuccess = await authSevice.register(
                      nameTxtController.text.trim(),
                      emailTxtController.text.trim(),
                      passwordTxtController.text.trim(),
                    );
                    if (registerSuccess.ok) {
                      Navigator.pushReplacementNamed(context, "login");
                      return showSnackBar(
                        context: context,
                        color: Colors.green,
                        title: registerSuccess.msj,
                      );
                    }
                    return showSnackBar(
                      context: context,
                      color: Colors.red,
                      title: registerSuccess.msj,
                    );
                  },
          )
        ],
      ),
    );
  }
}
