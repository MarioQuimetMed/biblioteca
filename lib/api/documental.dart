//import 'package:admin_dashboard/services/local_storage.dart';
import 'package:biblioteca/services/local_storage.dart';
import 'package:dio/dio.dart';


class DocumentalApi {
  static final Dio _dio = Dio();

  static void configureDio() {
    _dio.options.baseUrl = 'https://si2-documental-project-backend-muimui69.vercel.app/api';
    _dio.options.headers = {
      'x-token': LocalStorage.prefs.getString('token') ?? ''
    };
  }

  static Future httpGet(String path) async {
    try {
      final resp = await _dio.get(path);
      return resp.data;

    // ignore: deprecated_member_use
    } on DioError catch (e) {
      print(e.response);
      throw('Error en el GET');
    }
  }




  static Future post(String path, Map<String, dynamic> data) async {
    try {
      configureDio();
      final resp = await _dio.post(_dio.options.baseUrl+path,data: data);
      print(resp);
      return resp;
    // ignore: deprecated_member_use
    } on DioError catch (e) {
      print(e);
      throw('Error en el POST');
    }
  }

  static Future httpDelete(String path) async {
    try {
      final resp = await _dio.delete(path);
      return resp.data;
    // ignore: deprecated_member_use
    } on DioError catch (e) {
      print(e.response);
      throw('Error en el DELETE');
    }
  }
}