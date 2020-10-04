import 'package:flutter/material.dart';
import 'package:mapa_tracker/models/search_result.dart';

class SearchDestination extends SearchDelegate<SearchResult> {

  @override
  final String searchFieldLabel;

  SearchDestination(): this.searchFieldLabel = 'Buscar...';

  @override
  List<Widget> buildActions(BuildContext context) {
      return [
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: () => this.query = '',
        )
      ];
    }
  
    @override
    Widget buildLeading(BuildContext context) {
      final searchResult = SearchResult(cancelo: true);
      return IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: (){
          this.close(context, searchResult);
        },
      );
    }
  
    @override
    Widget buildResults(BuildContext context) {
      return Text('Build Results');
    }
  
    @override
    Widget buildSuggestions(BuildContext context) {
      return ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.location_on),
            title: Text('Colocar ubicacion manualmente'),
            onTap: () {
              this.close(context, new SearchResult(cancelo: false, manual: true));
            },
          )
        ],
      );
    }

}