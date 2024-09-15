import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../repositories/models/news_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Dio dio = Dio();
  List<Article> articles = [];

  @override
  void initState() {
    _getNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue,
        textTheme: TextTheme(
          bodyLarge: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('News App',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500)),
        ),
        body: ListView.builder(
          itemCount: articles.length,
          itemBuilder: (context, index) {
           return ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  articles[index].urlToImage != null &&
                          articles[index].urlToImage!.isNotEmpty
                      ? Image.network(articles[index].urlToImage!)
                      : Icon(Icons.image_not_supported),
                  Text(articles[index].title ?? '',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
                  Text(articles[index].description ?? '',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                ],
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _getNews();
          },
          child: Icon(
            Icons.refresh,
            color: Colors.white,
          ),
          backgroundColor: Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }

  Future<void> _getNews() async {
    final response = await dio.get(
      'https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=e7208dfad8ec4f14958e118b4c670008',
    );
    final articlesJson = response.data["articles"] as List;
    setState(() {
      List<Article> newsArticle =
          articlesJson.map((a) => Article.fromJson(a)).toList();
      newsArticle = newsArticle.where((a) => a.title != "[Removed]").toList();
      articles = newsArticle;
    });
  }
}
