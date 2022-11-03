import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shop_app/providers/http_exception.dart';

class Auth with ChangeNotifier {
 String? _token;
  DateTime? _expireyDate;
  String? _userId;


  bool get isAuth{
    return token !=null;
  }

  String? get token{
    if(_expireyDate!=null&&_expireyDate!.isAfter(DateTime.now())&&_token!=null){
      return _token;
    }
    return null;
  }

  Future<void> _authentication(String email, String password, String urlSegment) async{
     final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyBCAXZk3qr6jJOFys7vwAmg4g04cm3uhDM');
    try {
      final response = await http.post(url,
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true,
          }));
          final responseDecoded= json.decode(response.body);
          if(responseDecoded['error']!= null){
            throw HttpException(responseDecoded['error']['message']);
          }
          _token=responseDecoded['idToken'];
          _expireyDate=DateTime.now().add(Duration(seconds: int.parse(responseDecoded['expiresIn'])));
          _userId = responseDecoded['localId'];
          notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }

  }

  Future<void> Signup(String email, String password) async {
   return _authentication(email, password, 'signUp');
  }
  Future<void> Login(String email, String password) async {
   return _authentication(email, password, 'signInWithPassword');
  }
}
