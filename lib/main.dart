import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(Pixabay());

class Pixabay extends StatefulWidget {
  @override
  _PixabayState createState() => _PixabayState();
}

class _PixabayState extends State<Pixabay> {
  Map image;
  List imgList;
  Future getPixabay() async {
    http.Response response = await http.get(
        "https://pixabay.com/api/?key=14001068-da63091f2a2cb98e1d7cc1d82&q=yellow+flowers&image_type=photo&pretty=true");
    image = json.decode(response.body);
    setState(() {
      imgList = image['hits'];
    });
  }
  @override
  void initState() {
    super.initState();
    getPixabay();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(centerTitle: true, title: Text("Pixabay")),
        body: ListView.builder(
            itemCount: imgList == null ? 0 : imgList.length,
            itemBuilder: (context, i) {
              return Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                children: <Widget>[
                  Container(
                    child: Row(
                      children: <Widget>[
                        CircleAvatar(
                    radius: 30.0,
                    backgroundImage: NetworkImage(imgList[i]['largeImageURL']),
                  ),
                  Text(imgList[i]['user'],
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                      ],
                    ),
                  ),
                  Card(
                    child: Image.network(imgList[i]['largeImageURL']),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.thumb_up),
                            Text("Likes")
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.favorite),
                            Text("favorite")
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.comment),
                            Text("Commments")
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.share),
                            Text("share")
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              );
            }),
      ),
    );
  }
}
