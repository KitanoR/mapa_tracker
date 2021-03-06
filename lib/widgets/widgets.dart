import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapa_tracker/helpers/helpers.dart';
import 'package:polyline/polyline.dart' as Poly;


import 'package:mapa_tracker/bloc/busqueda/busqueda_bloc.dart';
import 'package:mapa_tracker/bloc/mapa/mapas_bloc.dart';
import 'package:mapa_tracker/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';


import 'package:mapa_tracker/models/search_result.dart';
import 'package:mapa_tracker/search/search_destino.dart';
import 'package:mapa_tracker/services/traffic_service.dart';

part 'btn_ubicacion.dart';
part 'btn_mi_ruta.dart';
part 'btn_seguir_ubicacion.dart';
part 'search_bar.dart';
part 'marcador_manual.dart';