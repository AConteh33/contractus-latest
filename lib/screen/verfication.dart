import 'package:contractus/controller/authcontroller.dart';
import 'package:flutter/material.dart';

class EmailVerificationScreen extends StatefulWidget {
  @override
  _EmailVerificationScreenState createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  int _resendTimer = 0;

  void initState() {
    super.initState();
    Auth_Controller().sendVerificationMail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Email Verification'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Email Verification Required',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              Text(
                'A verification email has been sent to the address you provided during registration.',
              ),
              SizedBox(height: 20),
              Text(
                'Instructions:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                '1. Open the email inbox associated with your registration email address.',
              ),
              Text(
                '2. Locate the registration confirmation email.',
              ),
              Text(
                '3. Click on the verification link provided in the email.',
              ),
              SizedBox(height: 20),
              _resendTimer > 0
                  ? Text(
                      'Resend verification email in $_resendTimer seconds.',
                    )
                  : ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _resendTimer = 60;
                          Auth_Controller().sendVerificationMail();
                        });
                      },
                      child: Text('Resend Verification Email'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
