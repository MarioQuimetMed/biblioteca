/*
import 'package:admin_dashboard/models/http/users_response.dart';
import 'package:admin_dashboard/api/CafeApi.dart';
import 'package:admin_dashboard/models/usuario.dart';
*/


import 'package:biblioteca/api/documental.dart';
import 'package:flutter/material.dart';
import 'package:biblioteca/api/CafeApi.dart';
import 'package:biblioteca/models/usuario.dart';
import 'package:biblioteca/models/http/users_response.dart';

class UsersProvider extends ChangeNotifier {

  List<Usuario> users = [];
  bool isLoading = true;
  bool ascending = true;
  int? sortColumnIndex;
  
  UsersProvider() {
    getPaginatedUsers();
  }


  getPaginatedUsers() async {
    
    //final resp = await CafeApi.httpGet('/usuarios?limite=100&desde=0');
    final resp = await DocumentalApi.allUsers('/user');
    final usersResp = UsersResponse.fromMap(resp);
    users = [ ... usersResp.usuarios ];
    isLoading = false;
    notifyListeners();
  }

  Future<Usuario?> getUserById( String uid ) async {
    
    try {
      final resp = await CafeApi.httpGet('/usuarios/$uid');
      final user = Usuario.fromMap(resp);
      return user;
      
    } catch (e) {
      return null;
    }
  }


  void sort<T>( Comparable<T> Function( Usuario user ) getField  ) {
  //logica para cambiar el orden de la tabla
    users.sort(( a, b ) {

        final aValue = getField( a );
        final bValue = getField( b );

        return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });

    ascending = !ascending;

    notifyListeners();

  }


  void refreshUser( Usuario newUser ) {

    users = users.map(
      (user){
        if ( user.uid == newUser.uid ) {
          user = newUser;
        }

        return user;
      }
    ).toList();


    notifyListeners();
  }

}