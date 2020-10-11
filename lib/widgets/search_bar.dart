part of 'widgets.dart';

class SearchBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusquedaBloc, BusquedaState>(
      builder: (context, state) { 
        if ( state.seleccionarManual) {
          return Container();
        } else {
          return FadeInDown(
            duration: new Duration(milliseconds: 300),
            child: buildSearchBar(context)
          );
        }
      },
    );
  }
  
  Widget buildSearchBar(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        width: size.width,
        child: GestureDetector(
          onTap: () async {
            print('Mostrar search delegate');
            final proximidad = context.bloc<MiUbicacionBloc>().state.ubicacion;
            final historial = context.bloc<BusquedaBloc>().state.historial;
            final resultado = await showSearch(
              context: context, 
              delegate: SearchDestination(proximidad, historial)
            );
            restornoBusqueda(context, resultado);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 13),
            width: double.infinity,
            child: Text('Donde quieres ir?', style: TextStyle( color: Colors.black87, ),),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  offset: Offset(0,5)
                )
              ]
            ),
          ),
        ),
      ),
    );
  }

  Future restornoBusqueda(BuildContext context, SearchResult result) async {
    if(result.cancelo) return;
    if(result.manual) {
      BlocProvider.of<BusquedaBloc>(context).add(OnActivarMarcadorManual());
      return;
    }
    // calcular la ruta en base al valor del result
    calculandoAlerta(context);
    final trafficService = new TrafficService();
    final mapaBloc = context.bloc<MapasBloc>();
    final inicio = context.bloc<MiUbicacionBloc>().state.ubicacion;
    final destino = result.position;

    final drivinTraffic = await trafficService.getCoordsInicioYFinal(inicio, destino);
    final geometry = drivinTraffic.routes[0].geometry;
    final duracion = drivinTraffic.routes[0].duration;
    final distancia = drivinTraffic.routes[0].distance;
    final nombreDestino = result.nombreDestino;

    final points = Poly.Polyline.Decode(encodedString: geometry, precision: 6);
    final List<LatLng> rutaCoordenadas = points.decodedCoords.map((point) => new LatLng(point[0], point[1])).toList();
    mapaBloc.add(OnCrearRutaInicioDestino(rutaCoordenadas, distancia, duracion, nombreDestino));
    Navigator.of(context).pop();
    
    final busquedaBloc = context.bloc<BusquedaBloc>();
    busquedaBloc.add(OnAgregarHistorial(result));
  }
}
