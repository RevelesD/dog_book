import 'package:dog_book/model/Breed.dart';
import 'package:dog_book/pages/select_breeed.dart';
import 'package:dog_book/pages/home.dart';
import 'package:dog_book/services/auth.service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

class SignUpData extends StatelessWidget {
  final String password;
  final String email;
  SignUpData({@required this.password, @required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          title: Text(
            'Registro',
            textAlign: TextAlign.center,
          ),
          backgroundColor: Color.fromARGB(200, 178, 235, 242),
        ),
        body: SignUpDataForm(
          password: this.password,
          email: this.email,
        ));
  }
}

class SignUpDataForm extends StatefulWidget {
  final String password;
  final String email;
  SignUpDataForm({@required this.password, @required this.email});

  @override
  _SignUpDataFormState createState() => _SignUpDataFormState(
        email: this.email,
        password: this.password,
      );
}

class _SignUpDataFormState extends State<SignUpDataForm> {
  final service = GetIt.I.get<Auth>();
  final String password;
  final String email;
  _SignUpDataFormState({@required this.password, @required this.email});
  Breed breedSelected;

  final _formKey = GlobalKey<FormState>();

  final _breedController = TextEditingController();
  final _nameController = TextEditingController();
  final _birthdayController = TextEditingController();

  @override
  void dispose() {
    _breedController.dispose();
    _nameController.dispose();
    _birthdayController.dispose();
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
                          controller: _nameController,
                          validator: (input) {
                            if (input.isEmpty) {
                              return 'Ingresa un nombre';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Name *',
                            prefixIcon: Icon(Icons.person),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 20)),
                      Container(
                        width: 300,
                        child: TextFormField(
                          onTap: () async {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                            DateTime picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: new DateTime(1900),
                              lastDate: DateTime.now().add(Duration(days: 365)),
                            );
                            if (picked != null) {
                              _birthdayController.text =
                                  DateFormat('dd-MMMM-yyyy').format(picked);
                            }
                          },
                          controller: _birthdayController,
                          validator: (input) {
                            if (input.isEmpty) {
                              return 'Selecciona una fecha';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Cumpleaños *',
                            prefixIcon: Icon(Icons.cake),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 20)),
                      Container(
                        width: 300,
                        child: TextFormField(
                          onTap: () async {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                            Breed selectedBreed = await Navigator.of(context)
                                .push(MaterialPageRoute(
                                    builder: (context) => SelectBreed()));
                            breedSelected = selectedBreed;
                            _breedController.text = selectedBreed.name;
                          },
                          controller: _breedController,
                          validator: (input) {
                            if (input.isEmpty) {
                              return 'Selecciona una raza';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Raza favorita *',
                            prefixIcon: Icon(Icons.pets),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 20)),
                      Container(
                        width: 300,
                        child: RaisedButton(
                          onPressed: () {
                            if (_formKey.currentState.validate() &&
                                breedSelected != null) {
                              service.signUp(
                                email,
                                password,
                                _nameController.text,
                                breedSelected,
                                _birthdayController.text,
                              );
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePageFull()));
                            }
                            return null;
                          },
                          color: Color.fromARGB(250, 38, 198, 218),
                          child: Text(
                            'Registrar',
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
        ));
  }
}
