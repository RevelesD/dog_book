import 'package:dog_book/main.dart';
import 'package:dog_book/services/dogs.service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

//class RandomDogs extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Container();
//  }
//}

class RandomDogs extends StatefulWidget {
  @override
  _RandomDogsState createState() => _RandomDogsState();
}

class _RandomDogsState extends State<RandomDogs> {
  final dogs = GetIt.I.get<Dogs>();

  @override
  void initState() {
    final service = GetIt.I.get<Dogs>();
    service.getRandomDogs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: dogs.randomStream$,
      builder: (BuildContext context, AsyncSnapshot snap) {
        if(snap.data != [] && snap.data != null) {
          return Center(
            child: GridView.count(
              primary: false,
              padding: EdgeInsets.all(20),
              crossAxisCount: 3,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              children: <Widget>[
                ...snap.data.map((e) {
                  return Container(
                    padding: EdgeInsets.all(2),
                    child: Image.network(e),
                  );
                }),
              ],
            ),
          );
        }else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
