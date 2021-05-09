import 'package:flutter/material.dart';
import 'package:help_me/components/componets.dart';
import 'package:help_me/controllers/account_controller.dart';
import 'package:help_me/view_model/login_view_model.dart';
import 'package:help_me/views/home.dart';
import 'package:help_me/views/singup.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  LoginViewModel loginViewModel = LoginViewModel();
  AccountController accountController = AccountController();
  final _formKeyLogin = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.yellow[50],
        padding: EdgeInsets.all(15),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CircleAvatar(
                  minRadius: 70,
                  backgroundColor: Colors.yellow[100],
                  child: Column(
                    children: [
                      Icon(
                        Icons.healing,
                        color: Colors.yellow[700],
                        size: 50,
                      ),
                      Text(
                        "Help-me",
                        style: TextStyle(color: Colors.black87, fontSize: 20),
                      ),
                    ],
                  ),
                ),
                Form(
                  key: _formKeyLogin,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          onSaved: (value) {
                            loginViewModel.email = value;
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Informe o valor';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              fillColor: Colors.white38,
                              filled: true,
                              hintText: "E-mail",
                              contentPadding:
                                  EdgeInsets.fromLTRB(32, 16, 32, 16),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32))),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                            onSaved: (value) {
                              loginViewModel.password = value;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Informe o valor';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            decoration: InputDecoration(
                                fillColor: Colors.white38,
                                filled: true,
                                hintText: "Senha",
                                contentPadding:
                                    EdgeInsets.fromLTRB(32, 16, 32, 16),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(32)))),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 8, right: 8, top: 20, bottom: 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.orange[400],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32)),
                      padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                    ),
                    child: Text(
                      "Entrar",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w700),
                    ),
                    onPressed: () async {
                      var result;
                      if (_formKeyLogin.currentState.validate()) {
                        _formKeyLogin.currentState.save();

                        result =
                            await accountController.loginUser(loginViewModel);
                      }
                      if (result == "sucess") {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Home(),
                            ));
                      } else {
                        showErrorToast(
                            context,
                            "Não foi possível efetuar o login",
                            [Colors.red, Colors.red]);
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Align(
                    alignment: Alignment.center,
                    child: Text("Ainda não tem conta?")),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 8, right: 8, top: 20, bottom: 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.orange[200],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32)),
                      padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                    ),
                    child: Text(
                      "Cadastre-se",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w700),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Singup(),
                          ));
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
