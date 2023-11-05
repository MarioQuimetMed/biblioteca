/*
import 'package:admin_dashboard/models/usuario.dart';
import 'package:admin_dashboard/api/CafeApi.dart';
import 'package:admin_dashboard/models/http/auth_response.dart';
import 'package:admin_dashboard/router/router.dart';
import 'package:admin_dashboard/services/local_storage.dart';
import 'package:admin_dashboard/services/navigation_service.dart';
import 'package:admin_dashboard/services/notifications_service.dart';
*/
import 'package:biblioteca/api/documental.dart';
import 'package:flutter/material.dart';

import 'package:biblioteca/models/usuario.dart';
import 'package:biblioteca/api/CafeApi.dart';
import 'package:biblioteca/models/http/auth_response.dart';
import 'package:biblioteca/router/router.dart';
import 'package:biblioteca/services/local_storage.dart';
import 'package:biblioteca/services/navigation_service.dart';
import 'package:biblioteca/services/notifications_service.dart ';





enum AuthStatus {
  checking,
  authenticated,
  notAuthenticated
}

class AuthProvider extends ChangeNotifier {

  // ignore: unused_field
  String? _token;
  AuthStatus authStatus = AuthStatus.checking;
  Usuario? user;

  AuthProvider() {
    isAuthenticated();
  }

  login( String email, String password ) {

    final data = {
      'email': email,
      'password': password
    };

    //CafeApi
    DocumentalApi.post('/auth', data ).then(
      (json) {
        print(json);
        final authResponse = AuthResponse.fromMap(json.data);
        user = authResponse.usuario;
        print(json["auth-token"]);
        authStatus = AuthStatus.authenticated;
        LocalStorage.prefs.setString('token', authResponse.token );
        NavigationService.replaceTo(Flurorouter.dashboardRoute);

        //CafeApi.configureDio();
        DocumentalApi.configureDio();
        notifyListeners();

      }

    ).catchError( (e){
      print('error en: $e');
      NotificationsService.showSnackbarError('Usuario / Password no válidos');
    });
    // this._token = 'askjdhakjsdhkajshdkj';
    // authStatus = AuthStatus.authenticated;
    // NavigationService.replaceTo(Flurorouter.dashboardRoute);
  }


  register( String email, String password, String name ) {
    
    final data = {
      'nombre': name,
      'correo': email,
      'password': password
    };

    CafeApi.post('/usuarios', data ).then(
      (json) {
        print(json);
        final authResponse = AuthResponse.fromMap(json);
        user = authResponse.usuario;

        authStatus = AuthStatus.authenticated;
        LocalStorage.prefs.setString('token', authResponse.token );
        NavigationService.replaceTo(Flurorouter.dashboardRoute);

        CafeApi.configureDio();
        notifyListeners();

      }
      
    ).catchError( (e){
      print('error en: $e');
      NotificationsService.showSnackbarError('Usuario / Password no válidos');
    });
    
    
    

  }

  Future<bool> isAuthenticated() async {

    final token = LocalStorage.prefs.getString('token');

    if( token == null ) {
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      return false;
    }
    
    try {
      final resp = await CafeApi.httpGet('/auth');
      final authReponse = AuthResponse.fromMap(resp);
      LocalStorage.prefs.setString('token', authReponse.token );
      
      user = authReponse.usuario;
      authStatus = AuthStatus.authenticated;
      notifyListeners();
      return true;

    } catch (e) {
      print(e);
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      return false;
    }

  }


  logout() {
    LocalStorage.prefs.remove('token');
    authStatus = AuthStatus.notAuthenticated;
    notifyListeners();
  }

}
