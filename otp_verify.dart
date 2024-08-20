import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:login/home_screen.dart';

class CustomCircularProgress extends StatelessWidget {
  final double strokeWidth;
  final Color color;
  final Duration duration;

  const CustomCircularProgress({
    Key? key,
    this.strokeWidth = 4.0,
    this.color = Colors.blue,
    required this.duration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 40,
        height: 40,
        child: CircularProgressIndicator(
          strokeWidth: strokeWidth,
          valueColor: AlwaysStoppedAnimation<Color>(color),
        ),
      ),
    );
  }
}

class OtpVerify extends StatefulWidget {
  final String otp;
  final String phoneNumber;

  const OtpVerify({Key? key, required this.otp, required this.phoneNumber})
      : super(key: key);

  @override
  State<OtpVerify> createState() => _OtpVerifyState();
}

class _OtpVerifyState extends State<OtpVerify> {
  final _otpController = TextEditingController();
  bool _isLoading = false;

  Future<void> _verifyOTP(String enteredOTP) async {
    setState(() {
      _isLoading = true;
    });

    try {
      Response response = await Dio().post(
        'https://puvnltest.uppclonline.com/Ext/Mob/Services/App/login/verifyOTP',
        data: {
          'mobileNo': widget.phoneNumber,
          'countryCode': '91',
          'otp': enteredOTP,
        },
      );

      if (response.statusCode == 200 && response.data['errorCode'] == '0') {
        // OTP verification successful
        // You can handle the response data as needed
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('OTP verified successfully.'),
            duration: Duration(seconds: 3),
          ),
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        ); // Close the OTP verification screen
      } else {
        // Handle OTP verification failure
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to verify OTP. Please try again.'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      // Handle Dio errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          duration: const Duration(seconds: 3),
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify OTP',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
            )),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        backgroundColor: const Color.fromRGBO(33, 150, 243, 1),
      ),
      body: _isLoading
          ? const CustomCircularProgress(
              duration: Duration(seconds: 5),
            ) // Using custom circular progress
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextField(
                    controller: _otpController,
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    decoration: const InputDecoration(
                      counterText: '',
                      border: OutlineInputBorder(),
                      labelText: 'Enter OTP',
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    String enteredOTP = _otpController.text.trim();
                    _verifyOTP(enteredOTP);
                  },
                  child: const Text(
                    'Verify OTP',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 1, 1, 15)),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Verification code sent to: ${widget.phoneNumber}',
                  style: const TextStyle(
                      fontSize: 16, color: Color.fromARGB(255, 212, 126, 247)),
                ),
              ],
            ),
    );
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }
}


/*import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class CustomCircularProgress extends StatelessWidget {
  final double strokeWidth;
  final Color color;
  final Duration duration;

  const CustomCircularProgress({
    Key? key,
    this.strokeWidth = 4.0,
    this.color = Colors.blue,
    required this.duration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 40,
        height: 40,
        child: CircularProgressIndicator(
          strokeWidth: strokeWidth,
          valueColor: AlwaysStoppedAnimation<Color>(color),
        ),
      ),
    );
  }
}

class OtpVerify extends StatefulWidget {
  final String otp;
  final String phoneNumber;

  const OtpVerify({Key? key, required this.otp, required this.phoneNumber})
      : super(key: key);

  @override
  State<OtpVerify> createState() => _OtpVerifyState();
}

class _OtpVerifyState extends State<OtpVerify> {
  final _otpController = TextEditingController();
  bool _isLoading = false;

  Future<void> _verifyOTP(String enteredOTP) async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Simulating network delay
      await Future.delayed(const Duration(seconds: 3));

      // Example response handling
      bool isVerificationSuccessful = enteredOTP == widget.otp;

      if (isVerificationSuccessful) {
        // OTP verification successful
        // You can handle the response data as needed
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('OTP verified successfully.'),
            duration: Duration(seconds: 3),
          ),
        );
        Navigator.pop(context); // Close the OTP verification screen
      } else {
        // Handle OTP verification failure
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to verify OTP. Please try again.'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      // Handle Dio errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          duration: const Duration(seconds: 3),
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify OTP'),
      ),
      body: _isLoading
          ? const CustomCircularProgress(
              duration: Duration(seconds: 5), // Increase the timer here
            ) // Using custom circular progress
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextField(
                    controller: _otpController,
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    decoration: const InputDecoration(
                      counterText: '',
                      border: OutlineInputBorder(),
                      labelText: 'Enter OTP',
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    String enteredOTP = _otpController.text.trim();
                    _verifyOTP(enteredOTP);
                  },
                  child: const Text('Verify OTP'),
                ),
                const SizedBox(height: 20),
                Text(
                  'Verification code sent to: ${widget.phoneNumber}',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
    );
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }
}*/



