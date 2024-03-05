import 'dart:async';

import 'package:aichatbot/models/chat_message_model.dart';
import 'package:aichatbot/repos/chat_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatSuccessState(messages: [])) {
    on<ChatGenerateNewTextMessageEvent>(chatGenerateNewTextMessageEvent);
    on<ChatResetEvent>(chatResetEvent);
  }

  List<ChatMessageModel> messages = [];
  bool generating = false;

  void resetChat() {
    messages.clear();
    add(ChatResetEvent());
  }

  FutureOr<void> chatGenerateNewTextMessageEvent(
    ChatGenerateNewTextMessageEvent event, Emitter<ChatState> emit) async{
    messages.add(ChatMessageModel(role: "user", parts: [
        ChatPartModel(text: event.inputMessage)
      ]));
    emit(ChatSuccessState(messages: messages));
    generating = true;
    String generatedText = await ChatRepo.chatTextGenerationRepo(messages);
    if(generatedText.length>0){
      messages.add(ChatMessageModel(role: 'model', parts: [
        ChatPartModel(text: generatedText)
      ]));
      emit(ChatSuccessState(messages: messages));
    }
    generating = false;
  }

  FutureOr<void> chatResetEvent(
    ChatResetEvent event, Emitter<ChatState> emit) async{
    emit(ChatSuccessState(messages: messages));
  }
}
