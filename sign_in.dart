import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:login/otp_verify.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();

  String _errorMessage = '';
  String token = 'Y2xpZW50X3Jlc3Q6d2VsY29tZTE=';
  // final Dio _dio = Dio();
  // final String _options =
  // "Options("
  //     "headers: {"
  //     "'Content-Type': 'application/json',"
  //     "'Authorization': 'Bearer Y2xpZW50X3Jlc3Q6d2VsY29tZTE='"
  //     "})"
  //     ;

  Future<void> _login(String phoneNumber) async {
    const String apiUrl =
        'https://puvnltest.uppclonline.com/Ext/Mob/Services/App/login';
    const String countryCode = '91';
    const String imeiCode = '123456789101112';

    final Map<String, dynamic> requestData = {
      'mobileNo': phoneNumber,
      'countryCode': countryCode,
      'imeicode': imeiCode,
    };
    Dio dio = Dio();
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers["Authorization"] = "Bearer $token";
    try {
      final Response response = await dio.post(
        apiUrl,
        data: json.encode(requestData),
      );
      //ignore_for_file: avoid_print
      print(response);

      final Map<String, dynamic> responseData = response.data;

      if (response.statusCode == 200 && responseData['errorCode'] == '0') {
        final String otp = responseData['otp'].toString();
        print(otp);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OtpVerify(
              otp: otp, // Pass the OTP received from login
              phoneNumber: _usernameController.text
                  .trim(), // Pass the phone number entered by the user
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Incorrect Phone Number'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login Page',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            // bottomLeft: Radius.circular(20),
            // bottomRight: Radius.circular(20),
          ),
        ),
        backgroundColor: const Color.fromRGBO(33, 150, 243, 1),
      ),
      
      body:
      Container(
        height: 200,
        decoration:const BoxDecoration(

          //  BoxShape shape = BoxShape.rectangle,
                  color:  Color.fromRGBO(33, 150, 243, 1),
          borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular( 80),
          bottomRight: Radius.circular(80),
      
        ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: TextField(
                    controller: _usernameController,
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    decoration: const InputDecoration(
                      counterText: '',
                      border: OutlineInputBorder(),
                      labelText: 'Enter Phone Number',
                      fillColor: Color.fromRGBO(33, 150, 243, 1),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _login(_usernameController.text.trim());
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(
                        fontSize: 16, color: Color.fromRGBO(33, 150, 243, 1)),
                  ),
                ),
                if (_errorMessage.isNotEmpty)
                  Text(
                    _errorMessage,
                    style: const TextStyle(color: Colors.red),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }
}




/*import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:login/otp_verify.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();

  String _errorMessage = '';
  String token = 'Y2xpZW50X3Jlc3Q6d2VsY29tZTE=';
  // final Dio _dio = Dio();
  // final String _options =
  // "Options("
  //     "headers: {"
  //     "'Content-Type': 'application/json',"
  //     "'Authorization': 'Bearer Y2xpZW50X3Jlc3Q6d2VsY29tZTE='"
  //     "})"
  //     ;

  Future<void> _login(String phoneNumber) async {
    const String apiUrl =
        'https://puvnltest.uppclonline.com/Ext/Mob/Services/App/login';
    const String countryCode = '91';
    const String imeiCode = '123456789101112';

    final Map<String, dynamic> requestData = {
      'mobileNo': phoneNumber,
      'countryCode': countryCode,
      'imeicode': imeiCode,
    };
    Dio dio = Dio();
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers["Authorization"] = "Bearer $token";
    try {
      final Response response = await dio.post(
        apiUrl,
        data: json.encode(requestData),
      );
      //ignore_for_file: avoid_print
      print(response);

      final Map<String, dynamic> responseData = response.data;

      if (response.statusCode == 200 && responseData['errorCode'] == '0') {
        final String otp = responseData['otp'].toString();
        print(otp);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OtpVerify(
              otp: otp, // Pass the OTP received from login
              phoneNumber: _usernameController.text
                  .trim(), // Pass the phone number entered by the user
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Incorrect Phone Number'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login Page',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            // bottomLeft: Radius.circular(20),
            // bottomRight: Radius.circular(20),
          ),
        ),
        backgroundColor: const Color.fromRGBO(33, 150, 243, 1),
      ),
      
      body:
      Container(
        height: 200,
        decoration:const BoxDecoration(

          //  BoxShape shape = BoxShape.rectangle,
                  color:  Color.fromRGBO(33, 150, 243, 1),
          borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular( 80),
          bottomRight: Radius.circular(80),
      
        )),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: TextField(
                    controller: _usernameController,
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    decoration: const InputDecoration(
                      counterText: '',
                      border: OutlineInputBorder(),
                      labelText: 'Enter Phone Number',
                      fillColor: Color.fromRGBO(33, 150, 243, 1),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _login(_usernameController.text.trim());
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(
                        fontSize: 16, color: Color.fromRGBO(33, 150, 243, 1)),
                  ),
                ),
                if (_errorMessage.isNotEmpty)
                  Text(
                    _errorMessage,
                    style: const TextStyle(color: Colors.red),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }
}*/
