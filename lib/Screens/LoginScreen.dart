import 'package:alisveris/Constants/RouteNames.dart';
import 'package:alisveris/Helpers/ToastHelper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController username = TextEditingController(text: "admin");
  TextEditingController password = TextEditingController(text: "123");

  late SharedPreferences preferences;

  void getPreferences() async{
    preferences = await SharedPreferences.getInstance();
}

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPreferences();
  }

  void loginUser(){
    if(username.text == "admin" && password.text == "123"){
      preferences.setString('username', username.text);

      ToastHelper().makeToastMessage('Giriş başarılı.');
      Navigator.of(context).pop();
      Navigator.pushNamed(context, bottomBarRoute);
    }else{
      ToastHelper().makeToastMessage('Kullanıcı adı veya şifre yanlış.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text(
                  'trendyol',
                  style: TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                    fontSize: 38
                  ),
                ),
              ),
              SizedBox(height: 35,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                child: Column(
                  children: [
                    TextField(
                      controller: username,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Kullanıcı Adı'
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: password,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Şifre',
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepOrangeAccent
                        ),
                        child: Text('Giriş Yap'),
                        onPressed: loginUser,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
