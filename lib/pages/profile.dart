import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:dog_book/services/auth.service.dart';
import 'package:dog_book/services/dogs.service.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final authService = GetIt.I.get<Auth>();
  final dogService = GetIt.I.get<Dogs>();

  final _mailController = TextEditingController();
  final _nameController = TextEditingController();
  final _birthDayController = TextEditingController();
  final _breedController = TextEditingController();
  final _photoController = TextEditingController();

  @override
  void initState() {
    dogService.loadProfile(authService.userCurrent.breed.path);
    this._photoController.text = authService.userCurrent.breed.path;
    this._nameController.text = authService.userCurrent.name;
    this._mailController.text = authService.userCurrent.email;
    this._breedController.text = authService.userCurrent.breed.name;
    this._birthDayController.text = authService.userCurrent.birthday;
    super.initState();
  }

  @override
  void dispose() {
    _mailController.dispose();
    _nameController.dispose();
    _breedController.dispose();
    _birthDayController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
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
                    Padding(padding: EdgeInsets.only(top: 20)),
                    Container(
                      width: 190,
                      height: 190,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                            dogService.profileCurrent
                          ),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 20)),
                    Container(
                      width: 300,
                      child: TextField(
                        enabled: false,
                        controller: _mailController,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Correo',
                          prefixIcon: Icon(Icons.mail),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 20)),
                    Container(
                      width: 300,
                      child: TextField(
                        enabled: false,
                        controller: _nameController,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Nombre',
                          prefixIcon: Icon(Icons.person),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 20)),
                    Container(
                      width: 300,
                      child: TextField(
                        enabled: false,
                        controller: _birthDayController,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Fecha de cumpleaños',
                          prefixIcon: Icon(Icons.cake),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 20)),
                    Container(
                      width: 300,
                      child: TextField(
                        enabled: false,
                        controller: _breedController,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Raza favorita',
                          prefixIcon: Icon(Icons.pets),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
