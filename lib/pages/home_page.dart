import 'package:flutter/material.dart';
import 'package:sendotpfromfirebase/helper/octal_helper.dart';

class HomePage extends StatelessWidget {
  final String userId;
  final String userPhoneNumber;
  const HomePage({super.key,required this.userId,required this.userPhoneNumber});

  @override
  Widget build(BuildContext context) {

    final helper = OctalHelper(secretKey: "aspProthesShreyasi");
    final octal8 = helper.generateOctalCode(uid: userId, length: 6); // Length 6 / 8 etc

    return Scaffold(
      appBar: AppBar(title: Text("Home"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("User ID : $userId"),
            Text("Convert Octal User ID : $octal8"),
            Text("User Phone : $userPhoneNumber"),
          ],
        ),
      ),
    );
  }
}
