import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sendotpfromfirebase/pages/authentication/otp_page.dart';

class PhoneNumber extends StatefulWidget {
  const PhoneNumber({super.key});

  @override
  State<PhoneNumber> createState() => _PhoneNumberState();
}

class _PhoneNumberState extends State<PhoneNumber> {
  final _formKey = GlobalKey<FormState>();
  final phnNumberController = TextEditingController();

  bool isLoading = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Phn Number Page"),),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        behavior: HitTestBehavior.opaque,
        child: Stack(
          children: [

            Padding(
              padding: EdgeInsets.all(50.0),
              child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "Phone Number",
                          hintStyle: TextStyle(color: Colors.blue),
                          labelText: "Phone Number",
                          labelStyle: TextStyle(color: Colors.grey),
                          floatingLabelStyle: TextStyle(color: Colors.blue),
                          border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                        ),
                        keyboardType: TextInputType.number,
                        maxLength: 11,
                        cursorColor: Colors.blue,
                        controller: phnNumberController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value){
                          if(value == null || value.trim().isEmpty){
                            return "Field is Empty";
                          }

                          if (!RegExp(r'^[0-9]+$').hasMatch(value)){
                            return "Invalid Number";
                          }

                          value = value.trim().replaceAll('+', '');

                          // Now check if the number is exactly 11 digits
                          if (value.length != 11) {
                            return "11 Digit Phone Number";
                          }

                          final pattern = RegExp(r'^(01[3-9])[0-9]{8}$');
                          if (!pattern.hasMatch(value)) {
                            return "Invalid Number";
                          }

                          return null;
                        },
                      ),
                      SizedBox(height: 20,),
                      ElevatedButton(
                          onPressed: isLoading? null :() async{
                            FocusScope.of(context).unfocus();
                            if(_formKey.currentState!.validate()){
                              String phnNumber = phnNumberController.text.trim();

                              try{

                                setState(() {isLoading = true;});
                                /// >>>  Collect Your Phone Number And Get OTP From Fire Base......
                                await FirebaseAuth.instance.verifyPhoneNumber(
                                    verificationCompleted: (credential){},
                                    verificationFailed: (error){},
                                    codeSent: (String verificationId, int? resendToken){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => OtpPage(verificationId: verificationId),));
                                      setState(() {isLoading = false;});
                                    },
                                    codeAutoRetrievalTimeout: (otp){},
                                    phoneNumber: "+880$phnNumber"
                                );



                              }catch(err){
                                debugPrint("Firebase Error $err");
                              }


                            }
                          },
                          child: isLoading?Text("Wait.."):Text("Get OTP")
                      )
                    ],
                  )
              ),
            ),

            if (isLoading)
              Positioned.fill(
                child: Container(
                  color: Colors.black.withValues(alpha: 0.3),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        CircularProgressIndicator(),
                        SizedBox(height: 15),
                        Text("Loading...", style: TextStyle(color: Colors.white, fontSize: 16,fontWeight: FontWeight.bold),)
                      ],
                    ),
                  ),
                ),
              ),
          ],
        )
      ),
    );
  }
}
