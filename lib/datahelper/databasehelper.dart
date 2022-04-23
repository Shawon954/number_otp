import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:number_otp/homepage.dart';

class NumberAuth {
  TextEditingController _otpcontroller = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;


  phoneAuth(number, context) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: number,
      verificationCompleted: (PhoneAuthCredential credential) async {
        UserCredential _userCredential =
            await auth.signInWithCredential(credential);
        User? _user = _userCredential.user;
        if (_user!.uid.isNotEmpty) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        } else {
          print('Failed');
        }
      },

      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
        }
      },

      codeSent: (String verificationId, int? resendToken) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Enter Your OTP"),
                content: Column(
                  children: [
                    TextField(
                      controller: _otpcontroller,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        PhoneAuthCredential credential =
                            PhoneAuthProvider.credential(
                                verificationId: verificationId,
                                smsCode: _otpcontroller.text);

                        UserCredential _userCredential = await auth.signInWithCredential(credential);
                        User? _user = _userCredential.user;
                        if(_user!.uid.isNotEmpty){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
                        }
                        else{
                          print('Failed');
                        }
                      },
                      child: Text('Conform'),
                    ),
                  ],
                ),
              );
            });
      },


      timeout: Duration(seconds: 45),
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
}
