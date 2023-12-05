import 'package:biblioteca/models/carpeta.dart';
import 'package:biblioteca/providers/carpeta_provider.dart';
import 'package:biblioteca/ui/shared/Carpetas.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:biblioteca/providers/auth_provider.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  List<String>? list;
  List<int>? listaDeIds;

  int? idCarpetaActual;
  int? idCarpetaPadre;

  String carpetaActual = 'Mi Unidad';

  List<int?> pilaDeIdsPadres = [];
  List<String> pilaDeCarpetasPadres = [];
  //archivos
  List<String>? listdeArchivos;
  List<int>? listaDeIdsArchivos = [1, 2, 3];

  Future<void> obtener() async {
    // Marcar la función main como async para permitir el uso de await
    // ignore: unrelated_type_equality_checks
    if (idCarpetaActual == null) {
      list = await CarpetaProvider.getCarpetas();
      listaDeIds = await CarpetaProvider.getIds();
      listdeArchivos = await CarpetaProvider.getArchivos('2');
    } else {
      list = await CarpetaProvider.getSubCarpetas(idCarpetaActual.toString());
      listaDeIds = await CarpetaProvider.getIds(idCarpetaActual.toString());
    }
    // Ahora puedes trabajar con la lista como si fuera síncrona
    print(list);
  }

  //DashboardView({Key? key}) : super(key: key);
  // Función para recargar el widget
  void recargarWidget() {
    setState(() {
      obtener();
    });
  }

  void onCarpetaClick(int idCarpeta, String carpeta) {
    // Actualizar la carpeta actual y recargar el widget
    setState(() {
      idCarpetaActual = idCarpeta;
      carpetaActual = carpeta;
      obtener();
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).user!;
    // Función para recargar el widget
    void recargarWidget() {
      setState(() {
        obtener();
      });
    }

    void onCarpetaClick(int idCarpeta, String carpeta) {
      // Actualizar la carpeta actual y recargar el widget
      setState(() {
        pilaDeCarpetasPadres.add(carpetaActual);
        pilaDeIdsPadres.add(idCarpetaActual);

        idCarpetaActual = idCarpeta;
        carpetaActual = carpeta;
        obtener();
      });
    }

    double screenHeight = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async {
        //das hacia atraas
        //acciones cuando le das al boton de ATRAS
        idCarpetaActual = pilaDeIdsPadres.removeLast();
        carpetaActual = pilaDeCarpetasPadres.removeLast();

        await obtener();
        recargarWidget();
        return false;
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Stack(
          children: [
            FutureBuilder(
              future: obtener(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Muestra un indicador de carga mientras esperas que la lista se cargue
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  // Muestra el ListView una vez que la lista está disponible
                  return ListView(
                    physics: const ClampingScrollPhysics(),
                    children: [
                      const SizedBox(height: 10),
                      Text(carpetaActual, style: const TextStyle(fontSize: 20)),
                      SizedBox(
                        height: screenHeight,
                        child: CarpetaWidget(
                            carpetas: list!,
                            onCarpetaClick: onCarpetaClick,
                            idCarpetaActual: idCarpetaActual,
                            listaDeIds: listaDeIds!,
                            listdeArchivos: listdeArchivos!,
                            listaDeIdsArchivos: listaDeIdsArchivos!,
                            idCarpetaPadre: idCarpetaPadre),
                      ),
                    ],
                  );
                }
              },
            ),
            Positioned(
              bottom: 16.0, // Ajusta según tus necesidades
              right: 16.0, // Ajusta según tus necesidades
              height: 60.0, // Ajusta según tus necesidades
              child: DialogoConTexto(
                recargarWidget: recargarWidget,
                idCarpetaActual: idCarpetaActual,
              ),
            ),
            Positioned(
              bottom: 16.0, // Ajusta según tus necesidades
              right: 16.0, // Ajusta según tus necesidades
              height: 200.0, // Ajusta según tus necesidades
              child: BotonArchivo(
                recargarWidget: recargarWidget,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BotonArchivo extends StatefulWidget {
  final VoidCallback recargarWidget;
  BotonArchivo({Key? key, required this.recargarWidget}) : super(key: key);

  @override
  State<BotonArchivo> createState() => _BotonArchivoState();
}

class _BotonArchivoState extends State<BotonArchivo> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        print("Subir archivo nya");
      },
      child: const Icon(Icons.add),
      backgroundColor: Colors.blue,
    );
  }
}

//--------------------------------------------------------------------------------------------------------------------------------
class DialogoConTexto extends StatefulWidget {
  final VoidCallback recargarWidget;
  int? idCarpetaActual;

  DialogoConTexto(
      {Key? key, required this.recargarWidget, required this.idCarpetaActual})
      : super(key: key);

  @override
  _DialogoConTextoState createState() => _DialogoConTextoState();
}

class _DialogoConTextoState extends State<DialogoConTexto> {
  final TextEditingController _nombreCarpetaController =
      TextEditingController();

  @override
  Widget build(
    BuildContext context,
  ) {
    return FloatingActionButton.extended(
        backgroundColor: Colors.orange,
        icon: const Icon(Icons.add),
        onPressed: () {
          // Aquí puedes poner lo que quieres que haga el botón cuando se presiona
          //print('Has presionado el ${buttonNames[index]}');
          const Text("Agregar carpeta", style: TextStyle(fontSize: 20));
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: TextField(
                  controller: _nombreCarpetaController,
                  decoration:
                      const InputDecoration(hintText: "Nombre de Carpeta"),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Cancelar'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      super.widget.recargarWidget();
                    },
                  ),
                  TextButton(
                    child: const Text('Aceptar'),
                    onPressed: () async {
                      // Aquí puedes manejar lo que quieres hacer con el texto ingresado
                      String nombreCarpeta = _nombreCarpetaController.text;
                      //print(nombreCarpeta);
                      //Agregar Carpeta xd

                      await CarpetaProvider.crearCarpeta(
                          nombreCarpeta, super.widget.idCarpetaActual);
                      super.widget.recargarWidget();

                      _nombreCarpetaController.clear();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
        label: const Text("Agregar carpeta", style: TextStyle(fontSize: 20)));
  }
}
