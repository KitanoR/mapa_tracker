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
            final resultado = await showSearch(
              context: context, 
              delegate: SearchDestination()
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

  void restornoBusqueda(BuildContext context, SearchResult result) {
    if(result.cancelo) return;
    if(result.manual) {
      BlocProvider.of<BusquedaBloc>(context).add(OnActivarMarcadorManual());
      return;
    }
  }
}
