import 'package:dog_book/pages/home.dart';
import 'package:dog_book/pages/sign_up.dart';
import 'package:dog_book/services/auth.service.dart';
import 'package:dog_book/widgets/password_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get_it/get_it.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LoginForm());
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final authService = GetIt.I.get<Auth>();
  final _formKey = GlobalKey<FormState>();

  final _mailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _mailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(15),
        children: <Widget>[
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 50),
                      ),
                      Container(
                        width: 180,
                        height: 180,
                        child: Image.asset(
                            'assets/logo.png',
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                      ),
                      Container(
                        width: 300,
                        child: TextFormField(
                          controller: _mailController,
                          validator: (input) {
                            if (input.isEmpty) {
                              return 'Ingresa un correo';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Email *',
                              prefixIcon: Icon(Icons.mail)),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                      ),
                      Container(
                        width: 300,
                        child: PasswordField(
                          controller: _passwordController,
                          validator: (input) {
                            if (input.isEmpty) {
                              return 'Introduce tu password';
                            }
                            return null;
                          },
                          labelText: 'Password *',
                          hintText: "Introduce tu password",
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                      ),
                      Container(
                        width: 300,
                        child: RaisedButton(
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              bool access = await authService.login(
                                _mailController.text,
                                _passwordController.text,
                              );

                              if (access) {
                                Navigator.push(context,
                                    MaterialPageRoute(
                                        builder: (context) => HomePageFull()));
                              } else {
                                Scaffold.of(context).showSnackBar(
                                  SnackBar(content: Text('Credenciales invalidas'),)
                                );
                              }
                            }
                            return null;
                          },
                          color: Colors.blue,
                          child: Text(
                            'Iniciar sesión',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 20)),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('¿No tienes cuenta?  '),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignUp()));
                              },
                              child: Text(
                                'Registrate',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
