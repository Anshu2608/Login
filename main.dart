

import 'package:flutter/material.dart';
import 'package:login/sign_in.dart';


void main() {
  runApp(MaterialApp( title: 'Login Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
      debugShowCheckedModeBanner: false,));
}
