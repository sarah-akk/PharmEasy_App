import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier{
  String?  token;
  DateTime? expireyDate;
  String? userId;
  Timer? authTimer = null ;

  bool get  isAuth{
    return token !=null;
  }
  String? get UserId{
    return userId;
  }
  String? get tokenn{
    if(expireyDate!=null && expireyDate!.isAfter(DateTime.now()) && token!=null){
      return token;
    }
    return null;
  }

  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


  // Future<void> logintoAdmin(String? PhoneNumber,String? passowrd,String? urlSegment )async{
  //   var url = Uri.parse(
  //       'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyAHN6mVcn_YLp_j7dzeGr5SgqRtrdiFAIg');
  //   try {final response =  await http.post(url,body: jsonEncode({
  //     'email':PhoneNumber,
  //     'password':passowrd,
  //     'returnSecureToken' :true,})
  //   );
  //   final responseData = json.decode(response.body);
  //
  //   token = responseData['idToken'];
  //   userId = responseData['localId'];
  //   expireyDate= DateTime.now().add(Duration(
  //     seconds:int.parse( responseData['expiresIn']),),);
  //   autoLogOut();
  //   notify*\\\\\\\\\\\\\\\\\\\\\\\\\\00000000000000000000000000000000000000000000000000000000000000000000000000000000Listeners();
  //   final prefs = await SharedPreferences.getInstance();
  //   final userData = json.encode({'token':token,'userId':userId,'expirydate':expireyDate!.toIso8601String()});
  //   prefs.setString('userData', userData);
  //   }
  //
  //   catch(error){
  //     throw error;
  //
  //   }
  //
  // }

  Future<String> loginUser(String? phone,String? password)async{

    var url = Uri.parse('http://10.0.2.2:8000/api/login');
    try {
      final response = await http.post(url,
        body: jsonEncode({'phone': phone, 'password': password}),
        headers: {'Content-Type': 'application/json'},
      );
      final Map<String, dynamic> data = json.decode(response.body);
      if (response.statusCode == 200 && data['message']=='user log in successfully') {
        token = data['token'];
        userId=data['user']['name'];
        print(token);
        return 'success: ${data['message']}';
      } else {
        // Handle login failure
        return 'error: ${data['message']}';      }

    }
    catch(error){
      throw error;

    }
  }

  Future<String> registerUser(String name ,String? phone,String? password,String?password_confirmation )async{

    var url = Uri.parse('http://10.0.2.2:8000/api/register');
    try {
      final response = await http.post(url,
        body: jsonEncode({
          'name': name,
          'phone': phone,
          'password': password,
          'password_confirmation': password_confirmation,
        }),
        headers: {'Content-Type': 'application/json'},
      );
      final Map<String, dynamic> data = json.decode(response.body);
      print(data);
      if (data['message']=='registered successfully') {
        token = data['token'];
        userId =name;
        return 'success: ${data['message']}';
      } else {
        // Handle login failure
        return 'error: ${data['message']}';      }

    } catch (error) {
      throw error;
    }
  }

  Future<String> signUp(String name, String PhoneNumber ,String passowrd,String password_confirmation)async{
    return registerUser(name,PhoneNumber,passowrd,password_confirmation);
  }

  Future<String> login( String PhoneNumber ,String passowrd)async{
    return loginUser(PhoneNumber,passowrd);

  }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  Future<void> logoutUser() async {
    var url = Uri.parse('http://10.0.2.2:8000/api/logout');

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      final Map<String, dynamic> data = json.decode(response.body);

      if (response.statusCode == 200 && data['message'] == 'user log out successfully') {
        print('success: ${data['message']}');
      } else {
        // Handle logout failure
        print('(error: ${data['message']}');
      }
    } catch (error) {
      throw error;
    }
  }


}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////