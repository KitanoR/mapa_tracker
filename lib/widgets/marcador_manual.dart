part of 'widgets.dart';

class MarcadorManual extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusquedaBloc, BusquedaState>(
      builder: (context, state) { 
        if ( state.seleccionarManual ){
          return _BuildMarcadorManual();
        } else {
          return Container();
        }
       },
    );
  }


}


class _BuildMarcadorManual extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        // Boton regresar
        Positioned(
          top: 70,
          left: 20,
          child: FadeInLeft(
            duration: new Duration(milliseconds: 150),
            child: CircleAvatar(
              maxRadius: 25,
              backgroundColor: Colors.white,
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black87,),
                onPressed: () {
                  BlocProvider.of<BusquedaBloc>(context).add(OnDesactivarMarcadorManual());
                },
              ),
            ),
          ),
        ),

        Center(
          child: Transform.translate(
            offset: Offset(0, -12),
            child: BounceInDown(
              from: 200,
              child: Icon(Icons.location_on, size: 50,)
            )
          ),
        ),

        // Confirmar destino
        Positioned(
          bottom: 70,
          left: 40,
          child: FadeIn(
            child: MaterialButton(
              minWidth: size.width - 120,
              child: Text(
                'Confirmar destino',
                style: TextStyle(
                  color: Colors.white
                ),
              ),
              color: Colors.black,
              shape: StadiumBorder(),
              elevation: 0,
              splashColor: Colors.transparent,
              onPressed: () {
                this.calcularDestino(context);
              },
            ),
          ),
        )
      ],
    );
  }


  void calcularDestino(BuildContext context) async {
    final trafficService = new TrafficService();
    final inicio = context.bloc<MiUbicacionBloc>().state.ubicacion;
    final destino = context.bloc<MapasBloc>().state.ubicacionCentral;
    await trafficService.getCoordsInicioYFinal(inicio, destino);
  }
}