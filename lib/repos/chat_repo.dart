
import 'dart:developer';
import 'package:aichatbot/models/chat_message_model.dart';
import 'package:aichatbot/utils/constants.dart';
import 'package:dio/dio.dart';

class ChatRepo{
  static Future<String> chatTextGenerationRepo(
    List<ChatMessageModel> previousMessage) async{
  try {
    Dio dio= Dio();

      final responce= await dio.post("https://generativelanguage.googleapis.com/v1beta/models/gemini-1.0-pro:generateContent?key=${apiKey}",
      data:{
        "contents": previousMessage.map((e) => e.toMap()).toList(),
    "generationConfig": {
    "temperature": 0.9,
    "topK": 1,
    "topP": 1,
    "maxOutputTokens": 2048,
    "stopSequences": []
    },
    "safetySettings": [
    {
      "category": "HARM_CATEGORY_HARASSMENT",
      "threshold": "BLOCK_MEDIUM_AND_ABOVE"
    },
    {
      "category": "HARM_CATEGORY_HATE_SPEECH",
      "threshold": "BLOCK_MEDIUM_AND_ABOVE"
    },
    {
      "category": "HARM_CATEGORY_SEXUALLY_EXPLICIT",
      "threshold": "BLOCK_MEDIUM_AND_ABOVE"
    },
    {
      "category": "HARM_CATEGORY_DANGEROUS_CONTENT",
      "threshold": "BLOCK_MEDIUM_AND_ABOVE"
    }
  ]
} 
      );

    if (responce.statusCode!>=200 && responce.statusCode!<300){
      return responce.data['candidates'].first['content']['parts'].first['text'];
    }  
    return ''; 
  } catch (e) {
    log(e.toString());
    return '';
    } 
  }
}