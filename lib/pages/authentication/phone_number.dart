import 'package:flutter/material.dart';

class PhoneNumber extends StatefulWidget {
  const PhoneNumber({super.key});

  @override
  State<PhoneNumber> createState() => _PhoneNumberState();
}

class _PhoneNumberState extends State<PhoneNumber> {
  final _formKey = GlobalKey<FormState>();
  final phnNumberController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Phn Number Page"),),
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
                    onPressed: () async{
                      FocusScope.of(context).unfocus();
                      if(_formKey.currentState!.validate()){
                        String phnNumber = phnNumberController.text.trim();

                        try{

                        }catch(err){
                          debugPrint("Firebase Error $err");
                        }


                      }
                    },
                    child: Text("Get OTP")
                )
              ],
            )
          ),
        ),
      ),
    );
  }
}
