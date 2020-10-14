import 'package:flutter/material.dart';
import './add_place.dart';
import 'package:provider/provider.dart';
import '../provider/great_places.dart';
import './place_detail.dart';

class place_list extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(add_place.routedname);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false)
            .fetchAndAetPlaces(),
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<GreatPlaces>(
                child: Center(
                  child: Text('مضافش حاجه لسه ، ضيف يا ابن الظريفه '),
                ),
                builder: (ctx, greatPlaces, ch) =>
                    greatPlaces.iteams.length <= 0
                        ? ch
                        : ListView.builder(
                            itemBuilder: (ctx, i) => ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    FileImage(greatPlaces.iteams[i].image),
                              ),
                              title: Text(greatPlaces.iteams[i].title),
                              subtitle:
                                  Text(greatPlaces.iteams[i].location.address),
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                    Place_detail.routedname,
                                    arguments: greatPlaces.iteams[i].id);
                              },
                            ),
                            itemCount: greatPlaces.iteams.length,
                          ),
              ),
      ),
    );
  }
}
