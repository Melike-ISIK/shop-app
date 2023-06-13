import 'package:alisveris/Constants/RouteNames.dart';
import 'package:alisveris/Helpers/ToastHelper.dart';
import 'package:alisveris/Services/AuthService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthService _authService = AuthService();

  TextEditingController email = TextEditingController(text: "melike@gmail.com");
  TextEditingController password = TextEditingController(text: "123456");

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
    _authService.signIn(email.text, password.text).then((value) async{
      if(value != null){
        Stream<QuerySnapshot> snap = FirebaseFirestore.instance.collection('User').where('email', isEqualTo: email.text).snapshots();
        if(!await snap.isEmpty){
          snap.first.then((value) async{
            preferences.setString('name', value.docs.first['name']);
            preferences.setString('email', value.docs.first['email']);
            preferences.setBool('isLogged', true);
          });
        }

        Navigator.of(context).pop();
        Navigator.pushNamed(context, bottomBarRoute);
      }else{
        ToastHelper().makeToastMessage('Kullanıcı adı veya parola yanlış.');
      }
    });
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
                      controller: email,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'E-Mail'
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
                    SizedBox(height: 30),
                    TextButton(
                      child: Text('Hesabın yok mu? Kayıt ol.',
                        style: TextStyle(
                            decoration: TextDecoration.underline
                        ),
                      ),
                      onPressed: (){
                        Navigator.pushNamed(context, registerRoute);
                      },
                    )
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
