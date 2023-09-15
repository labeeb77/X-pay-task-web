import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:xpay_web/controller/user_provider.dart';


import '../model/user_details.dart';
import '../model/user_model.dart';

Future<List<User>> fetchResults(BuildContext context) async {
  final provider = Provider.of<UserProvider>(context);
  const int limit = 10;
  final int skip = provider.currentPage * limit;
  final baseUrl = "https://dummyjson.com/users?limit=$limit&skip=$skip";

  final response = await http.get(Uri.parse(baseUrl));

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = json.decode(response.body);


    if (responseData.containsKey('users')) {
      final List<dynamic> data = responseData['users'];

    
      List<User> users = data.map((json) => User.fromJson(json)).toList();

      return users;
    } else {
      throw Exception('No "users" property in the response data');
    }
  } else {
    throw Exception('Failed to fetch data');
  }
}


Future<UserDetailsModel?> fetchUserDetails(int userId) async {
  final baseUrl = "https://dummyjson.com/users/$userId"; 

  final response = await http.get(Uri.parse(baseUrl));

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = json.decode(response.body);
   
    return UserDetailsModel.fromJson(responseData);
    
  } else {
    throw Exception('Failed to fetch user details');
  }
}

