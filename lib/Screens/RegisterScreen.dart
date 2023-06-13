import 'package:alisveris/Helpers/ToastHelper.dart';
import 'package:alisveris/Services/AuthService.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController adiSoyadi = TextEditingController(text: '');

  TextEditingController email = TextEditingController(text: '');

  TextEditingController parola = TextEditingController(text: '');

  AuthService _authService = AuthService();

  bool seePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CreateAppBar(),
      body: Padding(
        padding: EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
                controller: adiSoyadi,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Adı Soyadı'
                )
            ),
            SizedBox(
              height: 30,
            ),
            TextField(
              controller: email,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'E-Mail'
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 30,),
            TextField(
              controller: parola,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Parola',
                  suffixIcon: IconButton(
                    icon: Icon(
                        seePassword == true ?
                        Icons.visibility
                            : Icons.visibility_off
                    ),
                    onPressed: (){
                      setState(() {
                        seePassword = !seePassword;
                      });
                    },
                  )
              ),
              obscureText: seePassword,
            ),
            SizedBox(height: 30,),
            Container(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text('Kayıt Ol'),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrangeAccent
                  ),
                  onPressed: (){
                    if(adiSoyadi.text.isEmpty){
                      ToastHelper().makeToastMessage('Ad Soyad boş olamaz.');
                    } else if(email.text.isEmpty){
                      ToastHelper().makeToastMessage('E-mail boş olamaz.');
                    } else if(parola.text.isEmpty){
                      ToastHelper().makeToastMessage('Parola boş olamaz.');
                    } else {
                      _authService.createUser(adiSoyadi.text, email.text, parola.text).then((value){
                        if(value != null){
                          ToastHelper().makeToastMessage('Kayıt başarılı! Giriş yapın.');
                          Navigator.pop(context);
                        }else{
                          ToastHelper().makeToastMessage('Kayıt olurken bir sorun oluştu.');
                        }
                      });
                    }
                  },
                )
            ),
          ],
        ),
      ),
    );
  }

  AppBar CreateAppBar(){
    return AppBar(
      iconTheme: IconThemeData(color: Colors.black),
      title: Text(
        'Kayıt Ol',
        style: TextStyle(
            color: Colors.black
        ),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
    );
  }
}
