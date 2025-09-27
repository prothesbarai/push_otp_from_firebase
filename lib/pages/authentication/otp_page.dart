import 'package:flutter/material.dart';

class OtpPage extends StatefulWidget {
  final String otp;
  const OtpPage({super.key,required this.otp});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final _formKey = GlobalKey<FormState>();
  final otpController = TextEditingController();


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
                    maxLength: 4,
                    cursorColor: Colors.blue,
                    controller: otpController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value){
                      if(value == null || value.trim().isEmpty){
                        return "Field is Empty";
                      }
                      if (value.length != 4) {
                        return "Valid 4 Digit OTP";
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
