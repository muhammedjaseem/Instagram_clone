import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:riafi_machine_test/model/Comment_model.dart';
import 'package:riafi_machine_test/model/model_class.dart';
import 'package:http/http.dart'as http;
import 'Commment.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:readmore/readmore.dart';

import 'Stories.dart';

class HomePage extends StatefulWidget {
  // const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<Instamodel>> getdata() async {
    //print("comes");
    var productURl= Uri.parse("https://hiit.ria.rocks/videos_api/cdn/com.rstream.crafts?versionCode=40&lurl=Canvas%20painting%20ideas");

    final response = await http.get(productURl,headers:{"Content-Type":
    "application/json"});
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((job) => new Instamodel.fromJson(job)).toList();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: new Color(0xfff8faf8),
        centerTitle: true,
        elevation: 1.0,
        leading: new Icon(Icons.add_box,color: Colors.black87,),
        title: SizedBox(
            height: 35.0, child: Image.asset("Assets/images/instalogo.png")),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Icon(FontAwesomeIcons.facebookMessenger,color: Colors.black87),
          )
        ],
      ),
      body: ListView(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        children: [

          SizedBox(
            child: new InstaStories(),
            height: deviceSize.height * 0.20,
          ),
          FutureBuilder(
            future: getdata(),
              builder: (context,snapshot){
              if(snapshot.hasData)
                {
                  return ListView.builder(
                    physics: ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context,index)
                      {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                                padding: const EdgeInsets.fromLTRB(16.0, 16.0, 8.0, 16.0),
                                child:Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [

                                    Container(
                                      height: 40.0,
                                      width: 40.0,

                                      decoration: new BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: new DecorationImage(
                                            fit: BoxFit.fill,
                                            image: new NetworkImage(snapshot.data[index].lowThumbnail.toString())),
                                      ),
                                    ),
                                    SizedBox(width: 10.0,),
                                    Text(snapshot.data[index].channelname.toString(),  style: TextStyle(fontWeight: FontWeight.bold)),
                                    Expanded(
                                      child: SizedBox(),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Icon(Icons.more_vert),
                                    ),

                                  ],
                                )),
                            Flexible(
                              fit: FlexFit.loose,
                             //child:Image.network(abc[index].lowThumbnail,fit: BoxFit.cover),
                              child:  snapshot.data[index].highThumbnail ==null?Image.asset("Assets/images/demo.jpg" ,fit: BoxFit.cover,)
                                  :Image.network(snapshot.data[index].highThumbnail.toString(), fit: BoxFit.cover,),
                              //child: new Image.network(snapshot.data[index].highThumbnail.toString() == null?snapshot.data[index].highThumbnail.toString():'https://i.ytimg.com/vi/kQ_c74mq-og/maxresdefault.jpg',
                                //fit: BoxFit.cover,
                              ),
                            Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  IconButton(
                                    icon: new Icon(isPressed
                                        ? Icons.favorite
                                        : Icons.favorite_border,size: 30,),
                                    color: isPressed ? Colors.red : Colors.black,
                                    onPressed: () {
                                      setState(() {
                                        isPressed = !isPressed;
                                      });
                                    },
                                  ),
                                  IconButton(
                                    icon: new Icon(FontAwesomeIcons.comment),
                                    onPressed: (){
                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (context)=> CommentPage()));
                                    },
                                  ),
                                  IconButton(
                                    icon: new Icon(FontAwesomeIcons.paperPlane),
                                    onPressed: (){},
                                  ),
                                  Expanded(
                                    child: SizedBox(),
                                  ),
                                  IconButton(
                                    icon: new Icon(FontAwesomeIcons.bookmark),
                                    onPressed: ()async{
                                      setID(int value) async {
                                        SharedPreferences prefs = await SharedPreferences.getInstance();
                                        prefs.setInt('ID', value);
                                      }

                                    },
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(
                                "Liked by jaseem, thahir and 528,331 others",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: ReadMoreText(snapshot.data[index].title.toString(),
                                trimLines: 1,
                                style: TextStyle(color: Colors.black),
                                colorClickableText: Colors.grey[900],
                                trimMode: TrimMode.Line,
                                trimCollapsedText: '... more',
                                trimExpandedText: ' less',
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 0.0, 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  new Container(
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
                                  new SizedBox(
                                    width: 10.0,
                                  ),
                                  Expanded(
                                    child: new TextField(
                                      decoration: new InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Add a comment...",
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child:
                              Text("1 Day Ago", style: TextStyle(color: Colors.grey)),
                            ),
                          ],
                        );
                      });
                }else
                 // print(snapshot.error);
                  return Center(child: CircularProgressIndicator());
          }),
        ],
      ),
        bottomNavigationBar: new Container(
          color: Color(0xfff8faf8),
          height: 55.0,
          alignment: Alignment.center,
          child: new BottomAppBar(
            child: new Row(
              // alignment: MainAxisAlignment.spaceAround,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                new IconButton(
                  icon: Icon(
                    Icons.home,
                  ),
                  onPressed: () {},
                ),
                new IconButton(
                  icon: Icon(
                    Icons.search,
                  ),
                  onPressed: null,
                ),
                new IconButton(
                  icon: Icon(
                    Icons.add_box,
                  ),
                  onPressed: null,
                ),
                new IconButton(
                  icon: Icon(
                    Icons.favorite,
                  ),
                  onPressed: null,
                ),
                new Container(
                  height: 30.0,
                  width: 30.0,
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                            "https://i.ytimg.com/vi/a_WVM5EJnoA/maxresdefault.jpg")),
                  ),
                ),
                  //onPressed: null,
              ],
            ),
          ),
        )
    );
  }
}
