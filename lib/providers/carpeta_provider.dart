import 'package:biblioteca/api/documental.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class CarpetaProvider extends ChangeNotifier {
  List<String> carpetas = [];
  List<int> listaDeIds = [];

  CarpetaProvider() {}

  static Future crearCarpeta(String name, int? idCarpeta) async {
    final data = {
      'nombre': name,
    };
    try {
      DocumentalApi.configureDio();
      final json;
      if (idCarpeta == null) {
        json = await DocumentalApi.post('/folders', data);
      } else {
        json = await DocumentalApi.post('/folders/$idCarpeta', data);
      }
      print(json);
    } catch (e) {
      throw 'Error al crear carpeta';
    }
  }

  static Future<List<String>> getCarpetas() async {
    try {
      DocumentalApi.configureDio();
      final json = await DocumentalApi.obtenerCarpetas('/folders');
      final carpetas = getCarpetasMap(json);
      return carpetas;
    } catch (e) {
      throw 'Error al obtener carpetas';
    }
  }

  static Future<List<String>> getArchivos(String id) async {
    try {
      DocumentalApi.configureDio();
      final json = await DocumentalApi.obtenerArchivos('/file/$id');
      print(json);

      final archivos = getArchivosMap(json);
      return archivos;
    } catch (e) {
      throw 'Error al obtener carpetas';
    }
  }

  static Future<List<String>> getSubCarpetas([String? id]) async {
    try {
      DocumentalApi.configureDio();
      final json = await DocumentalApi.obtenerCarpetas('/folders/$id');
      final carpetas = getCarpetasMap(json);
      return carpetas;
    } catch (e) {
      throw 'Error al obtener carpetas';
    }
  }

  static Future<List<int>> getIds([String? id]) async {
    try {
      DocumentalApi.configureDio();
      final json;
      if (id == null) {
        json = await DocumentalApi.obtenerCarpetas('/folders');
      } else {
        json = await DocumentalApi.obtenerCarpetas('/folders/$id');
      }
      final ids = getIdsMap(json);
      return ids;
    } catch (e) {
      throw 'Error al obtener id de carpetas';
    }
  }
}

class Carpeta {
  // Define the Carpeta class here
  Carpeta.fromMap(Map<String, dynamic> json) {
    // Implement the constructor here
  }
}

List<String> getCarpetasMap(Map<String, dynamic> json) {
  // Obtener la lista de carpetas
  List<dynamic> carpetas = json['allCarpetas'];

  // Obtener la lista de nombres de carpetas
  List<String> listaNombres =
      carpetas.map((item) => item['nombre'].toString()).toList();

  print(listaNombres);
  return listaNombres;
}

List<int> getIdsMap(Map<String, dynamic> json) {
  // Obtener la lista de carpetas
  List<dynamic> carpetas = json['allCarpetas'];

  List<String> ides = carpetas.map((item) => item['id'].toString()).toList();

  List<int> listaIds = ides.map((item) => int.parse(item)).toList();

  print(listaIds);
  return listaIds;
}

List<String> getArchivosMap(Map<String, dynamic> json) {
  // Obtener la lista de carpetas
  List<dynamic> archivos = json['files'];
  // Obtener la lista de nombres de archivos

  List<String> listaNombres =
      archivos.map((item) => item['nombre'].toString()).toList();

  print(listaNombres);
  return listaNombres;
}
