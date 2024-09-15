import 'package:flutter/material.dart';
import '../repositories/news_repository/news.dart';
import '../repositories/models/news_model.dart'; 
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

  class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News App'),
      ),
      body: Center(
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          NewsRepository().getNews();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}