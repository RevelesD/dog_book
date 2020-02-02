import 'package:dog_book/pages/profile.dart';
import 'package:dog_book/pages/random_dogs.dart';
import 'package:dog_book/pages/search_dogs.dart';
import 'package:dog_book/services/auth.service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class HomePageFull extends StatefulWidget {
  @override
  _HomePageFullState createState() => _HomePageFullState();
}

class _HomePageFullState extends State<HomePageFull> {
  final authService = GetIt.I.get<Auth>();
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    RandomDogs(),
    Profile(),
    SearchDogs(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  
  @override
  void initState() {
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/DogBook.png',
              color: Color.fromARGB(150, 200, 0, 0),
              height: 50,
            ),
          ],
        ),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        leading: Container(),
        actions: <Widget>[
          PopupMenuButton(
            icon: Icon(
              Icons.account_circle,
              color: Color.fromARGB(150, 200, 0, 0),
            ),
            onSelected: (result) {
              authService.logOut();
              Navigator.popUntil(context, ModalRoute.withName('/'));
            },
            itemBuilder: (context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                child: Text('Cerrar sesión'),
                value: 'close',
              ),
            ],
          ),
        ],
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_pin),
            title: Text('Perfil'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('Buscar'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromARGB(200, 244, 143, 177),
        onTap: _onItemTapped,
      ),
    );
  }
}
