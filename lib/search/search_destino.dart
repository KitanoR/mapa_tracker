import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:mapa_tracker/models/search_response.dart' show SearchResponse;
import 'package:mapa_tracker/models/search_result.dart';
import 'package:mapa_tracker/services/traffic_service.dart';

class SearchDestination extends SearchDelegate<SearchResult> {

  @override
  final String searchFieldLabel;

  final List<SearchResult> historial;

  final TrafficService _trafficService;
  final LatLng proximidad;

  SearchDestination(this.proximidad, this.historial): 
    this.searchFieldLabel = 'Buscar...', 
    this._trafficService = new TrafficService();

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
      
      return this._construirResultadosSugerencias();
    }
  
    @override
    Widget buildSuggestions(BuildContext context) {
      if ( this.query.length == 0 ) {
        return ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.location_on),
              title: Text('Colocar ubicacion manualmente'),
              onTap: () {
                this.close(context, new SearchResult(cancelo: false, manual: true));
              },
            ),

            ...this.historial.map((resultado) => ListTile(
                leading: Icon(Icons.history),
                title: Text(resultado.nombreDestino),
                subtitle: Text(resultado.descripcion),
                onTap: () {
                  this.close(context, resultado);
                },
                ),
              ).toList()

          ],
        );
      }
      return _construirResultadosSugerencias();
    }

    Widget _construirResultadosSugerencias() {
      if (this.query == 0) {
        return Container();
      }
      this._trafficService.getSugerenciasPorQuery(this.query.trim(), proximidad);
      //this.query.trim(), proximidad
      return StreamBuilder(
        stream: this._trafficService.sugerenciasStream,
        builder: (BuildContext context, AsyncSnapshot<SearchResponse> snapshot) { 
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator(),);
          }
          final lugares = snapshot.data.features;
          if ( lugares.length == 0 ) {
            return ListTile(
              title: Text('No hay resyltados con $query'),
            );
          }
          return ListView.separated(
            separatorBuilder: (_, i) => Divider(), 
            itemCount: lugares.length,
            itemBuilder: (_, i) {
              final lugar = lugares[i];
              return ListTile(
                leading: Icon(Icons.place),
                title: Text(lugar.textEs),
                subtitle: Text(lugar.placeNameEs),
                onTap: () {
                  this.close(context, new SearchResult(
                      cancelo: false, 
                      manual: false,
                      position: LatLng(lugar.center[1], lugar.center[0]),
                      nombreDestino: lugar.textEs,
                      descripcion: lugar.placeNameEs
                    )
                  );
                },
              );
            }, 
          );
        },
      );
    }

}