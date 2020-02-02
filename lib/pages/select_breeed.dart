import 'package:dog_book/model/Breed.dart';
import 'package:dog_book/services/dogs.service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class SelectBreed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => Navigator.pop(context, null),
        ),
        centerTitle: true,
        title: Text(
          'Selecciona una raza',
          textAlign: TextAlign.center,
        ),
        backgroundColor: Color.fromARGB(200, 178, 235, 242),
      ),
      body: BreedList(),
    );
  }
}

class BreedList extends StatefulWidget {
  @override
  _BreedListState createState() => _BreedListState();
}

class _BreedListState extends State<BreedList> {
  final service = GetIt.I.get<Dogs>();
  final _filterController = TextEditingController();
  String _filter;
  String response;

  @override
  void dispose() {
    _filterController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    service.loadBreedList();
    _filterController.addListener(() {
      setState(() {
        _filter = _filterController.text;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(padding: EdgeInsets.only(top: 20)),
        TextField(
          controller: _filterController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Filtrar razas",
            suffixIcon: Icon(Icons.search),
          ),
        ),
        Expanded(
            child: StreamBuilder(
                stream: service.breedListStream$,
                builder: (BuildContext context, AsyncSnapshot snap) {
                  if (snap.connectionState == ConnectionState.active &&
                      snap.hasData) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snap.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (_filter == null || _filter == "") {
                            if(snap.data[index].name != null) {
                              return ListTile(
                                title: Text(snap.data[index].name),
                                onTap: () {
                                  Navigator.pop(
                                    this.context,
                                    snap.data[index]
                                  );
                                },
                              );
                            } else {
                              return Container();
                            }
                          } else {
                            if (snap.data[index].name.toLowerCase().contains(_filter.toLowerCase(),)) {
                              if (snap.data[index].name != null) {
                                return ListTile(
                                  title: Text(snap.data[index].name),
                                  onTap: () {
                                    Navigator.pop(
                                      this.context,
                                      snap.data[index]
                                    );
                                  },
                                );
                              } else {
                                return Container();
                              }
                            } else {
                              return Container();
                            }
                          }
                        });
                  } else {
                    return Container();
                  }
                })),
      ],
    );
  }
}

class BreedListItem extends StatelessWidget {
  final BuildContext context;
  final String itemName;
  BreedListItem({this.context, this.itemName});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(this.itemName),
      onTap: () {
        Navigator.pop(this.context, this.itemName);
      },
    );
  }
}
