import 'package:dog_book/pages/select_breeed.dart';
import 'package:dog_book/services/dogs.service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:dog_book/model/Breed.dart';

class SearchDogs extends StatefulWidget {
  @override
  _SearchDogsState createState() => _SearchDogsState();
}

class _SearchDogsState extends State<SearchDogs> {
  final service = GetIt.I.get<Dogs>();
  final _searchController = TextEditingController();
  String search;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    this._searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(padding: EdgeInsets.only(top: 20)),
        Container(
          width: 300,
          child: TextField(
            onTap: () async {
              FocusScope.of(context).requestFocus(new FocusNode());
              Breed selectedBreed = await Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => SelectBreed()));
              _searchController.text = selectedBreed.name;
              service.getBreedDogs(selectedBreed.path);
            },
            controller: _searchController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Selecciona una raza',
              suffixIcon: Icon(Icons.search),
            ),
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 20)),
        Expanded(
            child: StreamBuilder(
                stream: service.breedStream$,
                builder: (BuildContext context, AsyncSnapshot snap) {
                  if (snap.data != [] && snap.data != null) {
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
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }))
      ],
    );
  }
}
