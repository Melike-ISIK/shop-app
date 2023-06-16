import 'package:alisveris/Constants/RouteNames.dart';
import 'package:alisveris/Helpers/FirebaseHelper.dart';
import 'package:alisveris/Models/Address.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserAddressScreen extends StatefulWidget {
  const UserAddressScreen({Key? key}) : super(key: key);

  @override
  State<UserAddressScreen> createState() => _UserAddressScreenState();
}

class _UserAddressScreenState extends State<UserAddressScreen> {
  @override
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseHelper _firebaseHelper = FirebaseHelper();
  late SharedPreferences prefs;
  bool isLogged = false;
  String userName = "";

  Future getPrefs() async {
    prefs = await SharedPreferences.getInstance();

    setState(() {
      isLogged = prefs.getBool('isLogged')!;
      userName = prefs.getString('name')!;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPrefs();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CreateAppBar(),
      body: Column(
          children: [
            Expanded(
                child: StreamBuilder(
                  stream: _firebaseHelper.StreamAddress(),
                  builder: (BuildContext context , AsyncSnapshot <List<Address>> snapshot){
                    if (!snapshot.hasData) return CircularProgressIndicator();

                    List<Address>? addressList = snapshot.data;

                    if(addressList!.isEmpty) return Center (
                        child: Text(
                          'Kayıtlı bir adres bulunmamaktadır. ',
                        ));

                    return ListView.separated(
                      itemCount: addressList.length,
                      separatorBuilder: (context , index) => Divider(),
                      itemBuilder: (context, index){
                        Address address = addressList[index];

                        return Card(
                          child: ListTile(
                            leading: Icon(Icons.home_outlined),
                            title: Row(
                              children: [
                                Text(address.name),
                                SizedBox(width : 5),
                                Text(address.surname),
                              ],
                            ),
                            subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(address.address),
                                  Text(address.city),
                                  Text(address.country),
                                ]),
                            trailing: IconButton(
                                icon : Icon(Icons.cancel),
                                onPressed :() {
                                  _firebaseHelper.DeleteAddress(address);
                                }),
                          ),
                        );
                      },
                    );
                  },
                )),
            Padding(
                padding: EdgeInsets.all(11.0),
                child: ElevatedButton(
                  style:ElevatedButton.styleFrom( primary: Colors.deepOrange),
                  onPressed: () {
                    Navigator.pushNamed(context, addAddressRoute);
                  },
                  child: Text('Ekle'),

                ))]),
    );
  }

  AppBar CreateAppBar(){
    return AppBar(
      iconTheme: IconThemeData(color: Colors.black),
      title: Text(
        'Kayıtlı Adreslerim',
        style: TextStyle(
            color: Colors.black
        ),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
    );
  }
}