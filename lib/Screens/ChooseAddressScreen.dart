import 'package:alisveris/Constants/RouteNames.dart';
import 'package:alisveris/Helpers/FirebaseHelper.dart';
import 'package:alisveris/Models/Address.dart';
import 'package:flutter/material.dart';

class ChooseAddressScreen extends StatefulWidget {
  const ChooseAddressScreen({Key? key}) : super(key: key);

  @override
  State<ChooseAddressScreen> createState() => _ChooseAddressScreenState();
}
FirebaseHelper _firebaseHelper = FirebaseHelper();

class _ChooseAddressScreenState extends State<ChooseAddressScreen> {
  @override
  Object? choosevalue= 0;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CreateAppBar(),
      body :  Column(
        children: [
          Text(
            'Lütfen bir adres seçin',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),),
          Expanded(
              child: StreamBuilder(
                stream: _firebaseHelper.StreamAddress(),
                builder: (BuildContext context , AsyncSnapshot <List<Address>> snapshot){
                  if (!snapshot.hasData) return CircularProgressIndicator();

                  List<Address>? addressList = snapshot.data;

                  if(addressList!.isEmpty) return Center (
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Lütfen adres eklemesi yapınız. ',
                          ),
                          ElevatedButton(
                            child: Text('Adres Ekle'),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepOrange
                            ),
                            onPressed: (){
                              Navigator.pushNamed(context, addAddressRoute);
                            },
                          )
                        ],
                      ));

                  return Column(
                    children: [
                      ListView.separated(
                        shrinkWrap: true,
                        itemCount: addressList.length,
                        separatorBuilder: (context , index) => Divider(),
                        itemBuilder: (context, index){
                          Address address = addressList[index!];

                          return RadioListTile(
                              activeColor: Colors.deepOrange,
                              title : ListTile(
                                title: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(address.name),
                                      SizedBox(width : 5),
                                      Text(address.surname),
                                    ]
                                ),
                              ),
                              subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(address.address),
                                    Text(address.city),
                                    Text(address.country),
                                  ]),
                              value: address.docId, groupValue: choosevalue,
                              onChanged: (index){setState(() {
                                choosevalue= index;
                              });});
                        },
                      ),
                      Spacer(),
                      Container(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepOrangeAccent,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                )),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                'Siparişi Oluştur',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            onPressed: (){

                            },
                          ))
                    ],
                  );
                },
              )),
        ],
      ),
    );
  }
}

AppBar CreateAppBar(){
  return AppBar(
    iconTheme: IconThemeData(color: Colors.black),
    title: Text(
      'Siparişi Tamamla',
      style: TextStyle(
          color: Colors.black
      ),
    ),
    backgroundColor: Colors.transparent,
    elevation: 0,
  );
}