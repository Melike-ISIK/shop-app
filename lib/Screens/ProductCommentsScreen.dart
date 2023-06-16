import 'package:alisveris/Helpers/FirebaseHelper.dart';
import 'package:alisveris/Helpers/ToastHelper.dart';
import 'package:alisveris/Models/Comment.dart';
import 'package:alisveris/Models/Product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductCommentsScreen extends StatefulWidget {
  Product product;
  ProductCommentsScreen({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductCommentsScreen> createState() => _ProductCommentsScreenState();
}

class _ProductCommentsScreenState extends State<ProductCommentsScreen> {
  TextEditingController _controller = TextEditingController(text: '');
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

  void CreateProductComment() {
    if(_controller.text.isEmpty){
      ToastHelper().makeToastMessage('Yorum yapmadınız.');
      return;
    }

    _firestore
        .collection('Product')
        .doc(widget.product.id.toString())
        .collection('Comments').add({
      'comment': _controller.text,
      'name': userName,
      'date': FieldValue.serverTimestamp()
    });

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: StreamBuilder(
            stream: _firebaseHelper.StreamProductComments(widget.product.id),
            builder: (BuildContext context, AsyncSnapshot<List<Comment>> snapshot){
              if(!snapshot.hasData) return Center(child: CircularProgressIndicator());

              List<Comment>? comments = snapshot.data;

              if(comments!.isEmpty) return Center(child: Text('Ürüne yorum yapılmamış.'));

              return ListView.separated(
                itemCount: comments.length,
                separatorBuilder: (context, index) => Divider(),
                itemBuilder: (context, index){
                  Comment comment = comments[index];

                  Timestamp timestamp = comment.date;

                  var time = DateTime.fromMicrosecondsSinceEpoch(timestamp.microsecondsSinceEpoch);

                  return ListTile(
                    leading: Container(
                      width: 45,
                      child: Image(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            'https://api.multiavatar.com/${comment.name}.png'),
                        errorBuilder: (context, object, stackTrace){
                          return Icon(Icons.person, size:75);
                        },
                        loadingBuilder: (context, child, loadingProgress){
                          if(loadingProgress == null) return child;
                          return CircularProgressIndicator();
                        },
                      ),
                    ),
                    title: Text(comment.name),
                    subtitle: Text(comment.comment),
                    trailing: Text('${time.day}.${time.month}.${time.year}\n${time.hour}:${time.minute}', textAlign: TextAlign.end,),
                  );
                },
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8)
            ),
            child: Padding(
              padding: const EdgeInsets.all(11.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: CircleAvatar(
                        backgroundColor: Colors.deepOrangeAccent,
                        child: Image(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              'https://api.multiavatar.com/${userName}.png'),
                          errorBuilder: (context, object, stackTrace){
                            return Icon(Icons.person, size:75);
                          },
                          loadingBuilder: (context, child, loadingProgress){
                            if(loadingProgress == null) return child;
                            return CircularProgressIndicator();
                          },
                        )
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    flex: 9,
                    child: Column(
                      children: [
                        Container(
                          constraints: BoxConstraints(maxHeight: 100),
                          child: TextField(
                            controller: _controller,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            enabled: isLogged,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.green),
                              ),
                              hintText: 'Ürünü değerlendir...',
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.deepOrangeAccent
                            ),
                            child: Text('Gönder'),
                            onPressed:
                            isLogged ? () => CreateProductComment() : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
