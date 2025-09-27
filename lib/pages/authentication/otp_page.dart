import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sendotpfromfirebase/pages/home_page.dart';

class OtpPage extends StatefulWidget {
  final String verificationId;
  const OtpPage({super.key,required this.verificationId});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final _formKey = GlobalKey<FormState>();
  final otpController = TextEditingController();


  void navigateHome(){
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage()), (Route<dynamic> route) => false,);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("OTP Page"),),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: EdgeInsets.all(50.0),
          child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "OTP",
                      hintStyle: TextStyle(color: Colors.blue),
                      labelText: "OTP",
                      labelStyle: TextStyle(color: Colors.grey),
                      floatingLabelStyle: TextStyle(color: Colors.blue),
                      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                    ),
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    cursorColor: Colors.blue,
                    controller: otpController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value){
                      if(value == null || value.trim().isEmpty){
                        return "Field is Empty";
                      }
                      if (value.length != 6) {
                        return "Valid 6 Digit OTP";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20,),
                  ElevatedButton(
                      onPressed: () async{
                        FocusScope.of(context).unfocus();
                        if(_formKey.currentState!.validate()){
                          String otp = otpController.text.trim();

                          try{

                            /// >>> Get Otp From Firebase And Collect User Field OTP and match here then Navigate Target Page
                            PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: widget.verificationId, smsCode: otp);
                            await FirebaseAuth.instance.signInWithCredential(credential).then((value)=>{navigateHome()});

                          }catch(err){
                            debugPrint("Firebase Error $err");
                          }


                        }
                      },
                      child: Text("Verify OTP")
                  )
                ],
              )
          ),
        ),
      ),
    );
  }
}
