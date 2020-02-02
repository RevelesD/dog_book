import 'package:dog_book/pages/sign_up_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dog_book/widgets/password_field.dart';

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: null,
          ),
          centerTitle: true,
          title: Text(
            'Registro',
            textAlign: TextAlign.center,
          ),
          backgroundColor: Color.fromARGB(200, 178, 235, 242),
        ),
        body: SignUpForm());
  }
}

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final passMinChars = 6;
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
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
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: double.infinity,
                child: Column(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(top: 50)),
                    Container(
                      width: 300,
                      child: TextFormField(
                        controller: _emailController,
                        validator: (input) {
                          if (input.isEmpty) {
                            return 'Provide an email';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email *',
                            prefixIcon: Icon(Icons.mail)),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 20)),
                    Container(
                      width: 300,
                      child: PasswordField(
                        controller: _passwordController,
                        validator: (input) {
                          if (input.isEmpty) {
                            return 'El password no puede estar vacio.';
                          }
                          if (input.length < passMinChars) {
                            return 'El password debe tener minimo $passMinChars caracteres.';
                          }
                          return null;
                        },
                        labelText: 'Password *',
                        hintText: "Introduce tu password",
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 20)),
                    Container(
                      width: 300,
                      child: PasswordField(
                        controller: _confirmController,
                        validator: (input) {
                          if (input.isEmpty) {
                            return 'La confirmación no puede estar vacia.';
                          }
                          if (input != _passwordController.text) {
                            return 'Los password no coinciden';
                          }
                          return null;
                        },
                        labelText: 'Confirma password *',
                        hintText: "Confirma tu password",
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 20)),
                    Container(
                      width: 300,
                      child: RaisedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpData(
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                    )));
                          }
                          return null;
                        },
                        color: Color.fromARGB(250, 38, 198, 218),
                        child: Text(
                          'Siguiente',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      )
    );
  }
}

// 178,235,242
// 38,198,218
