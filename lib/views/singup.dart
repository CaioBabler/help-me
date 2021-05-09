import 'package:flutter/material.dart';
import 'package:help_me/controllers/account_controller.dart';
import 'package:help_me/view_model/singup_view_model.dart';
import 'package:help_me/views/home.dart';

class Singup extends StatefulWidget {
  Singup({Key key}) : super(key: key);

  @override
  _SingupState createState() => _SingupState();
}

class _SingupState extends State<Singup> {
  SingupViewModel model = SingupViewModel();
  AccountController accountController = new AccountController();
  final _formKeySingup = GlobalKey<FormState>();

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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Fique tranquilo nenhum de seu seus dados será divulgado!",
                    style: TextStyle(
                        color: Colors.black87, fontWeight: FontWeight.w400),
                  ),
                ),
                Form(
                    key: _formKeySingup,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            onSaved: (value) {
                              model.name = value;
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
                                hintText: "Nome",
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
                              model.email = value;
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
                                model.password = value;
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
                                      borderRadius:
                                          BorderRadius.circular(32)))),
                        ),
                      ],
                    )),
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
                      "Registrar-se",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w700),
                    ),
                    onPressed: () {
                      var result;
                      if (_formKeySingup.currentState.validate()) {
                        _formKeySingup.currentState.save();
                        result = accountController.registerUser(model);
                      }
                      if (result == "sucess") {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => Home()));
                      }
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
