part of 'widgets.dart';

class BtnSeguirUbicacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return  BlocBuilder<MapasBloc, MapasState>(
      builder: (BuildContext context, state) => this._crearBoton(context),
    );
  }

  Widget _crearBoton(BuildContext context) {
    final mapaBloc = context.bloc<MapasBloc>();
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          icon: Icon( 
            mapaBloc.state.seguirUbicacion 
            ? Icons.directions_run
            :
            Icons.accessibility_new, 
            color: Colors.black87,
          ),
          onPressed: (){
            mapaBloc.add(OnSeguirUbicacion());
          },
        ),
      ),
    );
  }
}