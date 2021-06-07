import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:riafi_machine_test/model/Comment_model.dart';
import 'package:http/http.dart'as http;
class CommentPage extends StatefulWidget {

  //const CommentPage({Key? key}) : super(key: key);

  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  Future ObjFuture;
  Future<List<ComentModel>> Cmnt()async {
    //print("ys");
    var CmntUrl=Uri.parse("http://cookbookrecipes.in/test.php");
    final Cmntresponse = await http.get(CmntUrl,headers:{"Content-Type":
    "application/json"});
    List jsonResponse = json.decode(Cmntresponse.body);
    return jsonResponse.map((job) => new ComentModel.fromJson(job)).toList();

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   ObjFuture= Cmnt();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: new Color(0xfff8faf8),

        elevation: 1.0,
        leading: IconButton(
          color: Colors.black87,
            icon:Icon(Icons.arrow_back_ios),
          onPressed: (){
              Navigator.pop(context);
          },
        ),
        title: Text("Comments",style: TextStyle(color: Colors.black87),),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Icon(FontAwesomeIcons.paperPlane,color: Colors.black87,),
          ),

        ],
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          FutureBuilder(
            future: ObjFuture,
            builder: (context,snapshot){
              if(snapshot.hasData){
                return ListView.builder(
                itemCount: snapshot.data.length,
                shrinkWrap: true,
                itemBuilder: (context,index){
                  return Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 40.0,
                                width: 40.0,
                                decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(
                                          "https://i.ytimg.com/vi/a_WVM5EJnoA/maxresdefault.jpg")),
                                ),
                              ),
                            ),
                            Text(snapshot.data[index].username.toString()   +"  "+ snapshot.data[index].comments.toString()),
                          ],
                        ),
                      ],
                    );

                  }
              );
              }
              else
              {
              return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),

    );
  }
}
