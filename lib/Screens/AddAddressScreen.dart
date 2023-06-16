import 'package:alisveris/Helpers/FirebaseHelper.dart';
import 'package:alisveris/Helpers/ToastHelper.dart';
import 'package:alisveris/Models/Address.dart';
import 'package:flutter/material.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({Key? key}) : super(key: key);

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  TextEditingController cont_name = TextEditingController();
  TextEditingController cont_surname = TextEditingController();
  TextEditingController cont_address = TextEditingController();
  TextEditingController cont_city = TextEditingController();
  TextEditingController cont_country = TextEditingController();

  FirebaseHelper _firebaseHelper = FirebaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CreateAppBar(),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: ListView(
              children: [
                TextField(
                  controller: cont_name,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Adınız'
                  ),
                ),
                SizedBox(height: 25,),
                TextField(
                  controller: cont_surname,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Soyadınız',
                  ),
                ),
                SizedBox(height: 25,),
                TextField(
                  controller: cont_address,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Adresiniz',
                  ),
                ),
                SizedBox(height:25,),
                TextField(
                  controller: cont_city,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Şehir',
                  ),
                ),
                SizedBox(height : 25,),
                TextField(
                  controller: cont_country,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Ülke',
                  ),
                ),
                SizedBox(height: 35,),
                Container(
                  child :ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrangeAccent,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'Adresi Ekle',
                        style: TextStyle(
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    onPressed: (){
                      if(cont_name.text.isEmpty){
                        ToastHelper().makeToastMessage('Lütfen adınızı giriniz. ');
                        return;
                      } else if(cont_surname.text.isEmpty){
                        ToastHelper().makeToastMessage('Lütfen soyadınızı giriniz.');
                        return;
                      } else if(cont_address.text.isEmpty){
                        ToastHelper().makeToastMessage('Lütfen adresinizi giriniz.');
                        return;
                      } else if(cont_city.text.isEmpty){
                        ToastHelper().makeToastMessage('Lütfen şehrinizi giriniz.');
                        return;
                      } else if(cont_country.text.isEmpty){
                        ToastHelper().makeToastMessage('Lütfen ülkenizi yazın .');
                        return;
                      }
                      _firebaseHelper.AddAddress(
                          Address(
                            docId: '',
                            name: cont_name.text,
                            surname: cont_surname.text,
                            address: cont_address.text,
                            city: cont_city.text,
                            country: cont_country.text,
                          )
                      );
                      Navigator.of(context).pop();
                    },

                  ),
                ),

              ],
            )
        )

    );
  }
}

AppBar CreateAppBar(){
  return AppBar(
    iconTheme: IconThemeData(color: Colors.black),
    title: Text(
      'Adres Ekle',
      style: TextStyle(
          color: Colors.black
      ),
    ),
    backgroundColor: Colors.transparent,
    elevation: 0,
  );
}
