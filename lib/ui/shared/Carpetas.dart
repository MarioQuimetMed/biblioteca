import 'package:flutter/material.dart';

class CarpetaWidget extends StatelessWidget {
  //carpetas
  final List<String> carpetas;
  final List<int> listaDeIds;
  int? idCarpetaPadre;
  int? idCarpetaActual;
  final Function(int, String) onCarpetaClick;
  //Archivos
  final List<String> listdeArchivos;
  final List<int> listaDeIdsArchivos;

  CarpetaWidget(
      {super.key,
      required this.carpetas,
      this.idCarpetaPadre,
      this.idCarpetaActual,
      required this.listaDeIds,
      required this.listdeArchivos,
      required this.listaDeIdsArchivos,
      required this.onCarpetaClick});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: carpetas.length + listdeArchivos.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
              index < carpetas.length
                  ? carpetas[index]
                  : listdeArchivos[index - carpetas.length],
              style: const TextStyle(fontSize: 20)),
          leading: index < carpetas.length
              ? const Icon(Icons.folder)
              : const Icon(Icons.file_copy),
          onTap: () {
            onCarpetaClick(listaDeIds[index], carpetas[index]);
            print("Carpeta seleccionada: ${carpetas[index]}");
          },
        );
      },
    );
  }
}
