import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tgp_firma/bloc/buscar_solicitud_bloc.dart';
import 'package:tgp_firma/bloc/provider/bloc_provider.dart';
import 'package:tgp_firma/ui/buscar_solicitud/propiedad_solicitud.dart';

class ResultadoProvider extends StatelessWidget {
  const ResultadoProvider({
    Key key,
    @required BuscarSolicitudBloc bloc,
    @required bool isFetching,
  })  : _bloc = bloc,
        _isFetching = isFetching,
        super(key: key);

  final BuscarSolicitudBloc _bloc;
  final bool _isFetching;

  Column buildSearchResult(SolicitudFirmanteDTO solicitud) {
    return Column(
      children: AnimationConfiguration.toStaggeredList(
        duration: Duration(milliseconds: 300),
        childAnimationBuilder: (widget) => SlideAnimation(
          verticalOffset: 50.0,
          child: FadeInAnimation(
            child: widget,
          ),
        ),
        children: <Widget>[
          PropiedadSolicitud(
            propertyName: 'Firmante',
            propertyValue: solicitud.firmante,
          ),
          PropiedadSolicitud(
            propertyName: 'En nombre de',
            propertyValue: solicitud.ente,
          ),
          PropiedadSolicitud(
            propertyName: 'Documento',
            propertyValue: solicitud.documento,
          ),
          PropiedadSolicitud(
            propertyName: 'Identificación',
            propertyValue: solicitud.id.toString(),
          ),
          PropiedadSolicitud(
            propertyName: 'Aplicación',
            propertyValue: solicitud.app,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: _bloc,
      child: StreamBuilder(
        stream: _bloc.stream,
        builder: (context, snapshot) {
          if (_isFetching) {
            return Container(
              margin: const EdgeInsets.only(top: 100),
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
              ),
            );
          }
          if (snapshot.hasData) {
            ResultadoBusquedaSolicitudDTO resultadoBusqueda = snapshot.data;
            if (resultadoBusqueda.hasResult) {
              return Container(
                margin: const EdgeInsets.only(bottom: 50),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: buildSearchResult(resultadoBusqueda.solicitud),
                ),
              );
            } else {
              return Container(
                margin: const EdgeInsets.only(top: 50),
                child: Text(
                  'No existe la solicitud ingresada.',
                  textAlign: TextAlign.center,
                  style:
                      GoogleFonts.encodeSans(color: Colors.white, fontSize: 22),
                ),
              );
            }
          }
          return Container();
        },
      ),
    );
  }
}