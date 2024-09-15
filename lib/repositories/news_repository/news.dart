import 'package:dio/dio.dart';
import 'package:flutter/material.dart';



class NewsRepository {

  Future<Map<String, dynamic>> getNews() async {
    final response = await Dio().get("https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=e7208dfad8ec4f14958e118b4c670008");
    debugPrint(response.toString());
    final data = response.data as Map<String, dynamic>;
    return data;
  }
}