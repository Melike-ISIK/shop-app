import 'package:alisveris/Constants/RouteNames.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CreateAppBar(),
      body: Column(
        children: [
          Flexible(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.deepOrangeAccent,
                    child: FutureBuilder(
                      future: SharedPreferences.getInstance(),
                      builder: (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot){
                        if(!snapshot.hasData) return CircularProgressIndicator();

                        String? username = snapshot.data!.getString('name');

                        return Image(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              'https://api.multiavatar.com/${username}.png'),
                          errorBuilder: (context, object, stackTrace){
                            return Icon(Icons.person, size:75);
                          },
                          loadingBuilder: (context, child, loadingProgress){
                            if(loadingProgress == null) return child;
                            return CircularProgressIndicator();
                          },
                        );
                      },
                    ),
                    radius: 65,
                  ),
                  SizedBox(height: 15,),
                  FutureBuilder(
                    future: SharedPreferences.getInstance(),
                    builder: (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot){
                      if(!snapshot.hasData) return CircularProgressIndicator();

                      String? username = snapshot.data!.getString('name');

                      return Text(username ?? '', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),);
                    },
                  ),
                ],
              ),
            ),
          ),
          Divider(),
          Flexible(
            child: Column(
              children: [
                Card(
                  child: ListTile(
                    leading: Icon(Icons.favorite),
                    trailing: Icon(Icons.chevron_right),
                    title: Text('Favorilerim'),
                    onTap: (){
                      Navigator.pushNamed(context, favoritesRoute);
                    },
                  ),
                ),
                Card(
                    child: ListTile(
                      leading: Icon(Icons.location_on_sharp),
                      trailing: Icon(Icons.chevron_right),
                      title: Text('Kayıtlı Adreslerim'),
                      onTap: (){
                        Navigator.pushNamed(context, userAddressRoute);
                      },

                    )
                ),
                Card(
                  child: ListTile(
                    leading: Icon(Icons.info),
                    title: Text('Uygulama Hakkında'),
                    onTap: (){
                      showAboutDialog(
                        context: context,
                        applicationIcon: FlutterLogo(),
                        applicationName: 'Alışveriş App',
                        applicationVersion: '1.0.0',
                        applicationLegalese: '©2023 Melike Işık',
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(top: 15),
                              child: Text('Melike Işık tarafından geliştirilmiştir.')
                          )
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  AppBar CreateAppBar(){
    return AppBar(
      title: Text(
        'Profil',
        style: TextStyle(
            color: Colors.black
        ),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
    );
  }
}
