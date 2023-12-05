//import 'package:admin_dashboard/services/local_storage.dart';
import 'package:biblioteca/services/local_storage.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DocumentalApi {
  static final Dio _dio = Dio();
// //--------------------------------------------------------------------------
//   static final Dio _dio = Dio(
//     BaseOptions(
//       baseUrl: 'https://si2-documental-project-backend-beta.vercel.app/', // ajusta la URL base según tus necesidades
//       headers: {
//         'Accept': 'application/json',
//         'Content-Type': 'application/json',
//         'x-token': LocalStorage.prefs.getString('token') ?? ''

//       },
//     ),
//   );

  static Dio get dio => _dio;

  static void configureDio() {
    _dio.options.baseUrl =
        'https://si2-documental-project-backend-beta.vercel.app/api';
    //'https://65fd-181-115-172-155.ngrok.io/api';

    Options(headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'auth-token': LocalStorage.prefs.getString('token') ?? ''
    });
  }

//--------------------------------------------------------------------------

  static Future get(String path) async {
    try {
      final resp = await dio.get(dio.options.baseUrl + path);
      return resp.data;
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      print(e.response);
      throw ('Error en el GET');
    }
  }

  static Future post(String path, Map<String, dynamic> data) async {
    try {
      configureDio();
      String _token = LocalStorage.prefs.getString('token') ?? '';
      Map<String, dynamic> headers = {
        'auth-token': _token,
      };
      final resp = await _dio.post(_dio.options.baseUrl + path,
          data: data, options: Options(headers: headers));
      print(resp);
      return resp;
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      print(e);
      throw ('Error en el POST');
    }
  }

  static Future allUsers(String path) async {
    try {
      final resp = await _dio.get(_dio.options.baseUrl + path);
      return resp.data;

      // ignore: deprecated_member_use
    } on DioError catch (e) {
      print(e.response);
      throw ('Error en el GET');
    }
  }

  static Future crearCarpeta(String path, Map<String, dynamic> data) async {
    try {
      configureDio();
      final resp = await _dio.post(_dio.options.baseUrl + path, data: data);
      print(resp);
      return resp;
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      print(e);
      throw ('Error en el POST');
    }
  }

  static Future obtenerCarpetas(String path) async {
    try {
      configureDio();
      String _token = LocalStorage.prefs.getString('token') ?? '';
      Map<String, dynamic> headers = {
        'auth-token': _token,
      };
      print(_token);
      final resp = await _dio.get(_dio.options.baseUrl + path,
          options: Options(headers: headers));

      return resp.data;
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      print(e.response);
      throw ('Error en el GET');
    }
  }

  static Future obtenerArchivos(String path) async {
    try {
      configureDio();
      String _token = LocalStorage.prefs.getString('token') ?? '';
      Map<String, dynamic> headers = {
        'auth-token': _token,
      };

      final resp = await _dio.get(_dio.options.baseUrl + path,
          options: Options(headers: headers));
      print(resp.data);
      return resp.data;
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      print(e.response);
      throw ('Error en el GET');
    }
  }
}
