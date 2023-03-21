import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quantumapp/Auth/fauth.dart';
import 'package:quantumapp/screens/account.dart';
import 'package:quantumapp/services/services.dart';

import '../models/article_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Fauth fauth = Fauth();
  ApiService client = ApiService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.search),
        title: Text("Search in feed"),
        actions: [
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () async {
                fauth.Logout();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Account()));
              })
        ],
      ),
      body: FutureBuilder(
          future: client.getArticle(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
            if (snapshot.hasData) {
              List<Article> articles = snapshot.data;
              return ListView.builder(
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Material(
                        elevation: 20.0,
                        child: Container(
                            height: 120,
                            width: 100,
                            child: Row(
                              children: [
                                Container(
                                  width: 250,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 115,
                                            child: Text(
                                              articles[index].publishedAt,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            width: 115,
                                            child: Text(
                                              articles[index].source.name,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        articles[index].title,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.lightBlue,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        articles[index].description,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 8,
                                          color: Colors.lightBlue,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 70,
                                  height: 70,
                                  child: Image.network(
                                    articles[index].urlToImage,
                                    fit: BoxFit.fill,
                                  ),
                                )
                              ],
                            )),
                      ),
                    );
                  });
            } else {
              return Container();
            }
          }),
    );
  }
}
