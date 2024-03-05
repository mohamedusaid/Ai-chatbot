import 'package:aichatbot/bloc/chat_bloc.dart';
import 'package:aichatbot/models/chat_message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ChatBloc chatBloc = ChatBloc();
  TextEditingController textEditingController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  bool _isAboveEnd = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    setState(() {
      _isAboveEnd = _scrollController.offset <
          _scrollController.position.maxScrollExtent;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ChatBloc, ChatState>(
        bloc: chatBloc,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case ChatSuccessState:
              List<ChatMessageModel> messages =
                  (state as ChatSuccessState).messages;
              return Stack(
                children: [
                  Container(
                    width: double.maxFinite,
                    height: double.maxFinite,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/uilogo.png"),
                            fit: BoxFit.cover)),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
                          height: 100,
                          color: Colors.grey.shade700,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Usaid AI ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 24),
                              ),
                              Container(
  
  child: Material(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(14),
    ),
    clipBehavior: Clip.antiAlias,
    color: Color.fromARGB(255, 225, 222, 222),
    child: InkWell(
      onTap: () {
        // Call the method to reset the chat
        chatBloc.resetChat();
      },
      splashColor: Color.fromARGB(255, 133, 133, 133), // Customize the splash color
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          'Clear All',
          style: TextStyle(color: Colors.black),
        ),
      ),
    ),
  ),
)

                            ],
                          ),
                        ),
                        Expanded(
  child: ListView.builder(
    controller: _scrollController,
    itemCount: messages.length,
    itemBuilder: (context, index) {
      String messageText = messages[index].parts.first.text;
      List<TextSpan> textSpans = [];

      // Use a RegExp to split the message by '**'
      RegExp exp = RegExp(r'\*\*([^*]+)\*\*');
      Iterable<RegExpMatch> matches = exp.allMatches(messageText);

      int start = 0;
      for (var match in matches) {
        if (match.start != start) {
          // Add the non-bold text
          textSpans.add(TextSpan(
            text: messageText.substring(start, match.start),
          ));
        }
        // Add the bold text
        textSpans.add(TextSpan(
          text: messageText.substring(match.start + 2, match.end - 2),
          style: TextStyle(fontWeight: FontWeight.bold),
        ));
        start = match.end;
      }
      if (start < messageText.length) {
        // Add the remaining non-bold text
        textSpans.add(TextSpan(
          text: messageText.substring(start, messageText.length),
        ));
      }

      return Container(
        margin: const EdgeInsets.only(top: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey.withOpacity(0.2),
        ),
        child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Row(
  children: [
    messages[index].role == "user" 
      ? Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: Colors.black,
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white,
              width: 1.5,
            ),
          ),
          child: CircleAvatar(
            backgroundColor: Color.fromARGB(255, 29, 28, 28),
            radius: 9,
            child: Transform.translate(
              offset: Offset(0, 1),
            child: Text(
              'U',
              style: TextStyle(
                fontSize: 13,
                color: Colors.white,
              ),
            ),
          ),
        ),
      )
      : Image.asset(
          'assets/sicon.png', // replace 'usaid_bot_image.png' with your bot image file
          width: 24, 
          height: 24
        ),
    SizedBox(width: 8, height: 33,), // adjust for desired spacing
    Text(
      messages[index].role == "user" ? "You" : "Usaid Bot",
      style: TextStyle(
        fontSize: 16,
        color: Colors.grey.shade400,
      ),
    ),
  ],
),


    SelectableText.rich(
      TextSpan(
        style: TextStyle(fontSize: 16, color: Color.fromARGB(217, 255, 255, 255)),
        children: textSpans,
      ),
    ),
  ],
),


      );
    },
  ),
),

                        if (chatBloc.generating)
                          Container(                            
                            height: 68,
                            width: 68,
                            child: Transform.translate(
                              offset: Offset(0, 15),
                              child: Lottie.asset('assets/loader.json'),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 26, horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                height: 60,
                                child: Row(
                                  children: [
                                    Container(
                                      child: Expanded(
                                        child: TextField(         
                                          controller: textEditingController,
                                          style: TextStyle(
                                              fontSize: 16, color: Colors.black),
                                          cursorColor:
                                              Theme.of(context).primaryColor,
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                              ),
                                              fillColor: const Color.fromARGB(
                                                  255, 225, 222, 222),
                                              hintText: "Ask Here!",
                                              hintStyle: TextStyle(
                                                  color: Colors.grey.shade400),
                                              filled: true,
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(100),
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .primaryColor))),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
CircleAvatar(
  radius: 30,
  backgroundColor: Colors.white,
  child: CircleAvatar(
    radius: 28,
    backgroundColor: Colors.grey.shade800,
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(28),
        onTap: () {
          if (textEditingController.text.isNotEmpty) {
            String text = textEditingController.text;
            textEditingController.clear();
            chatBloc.add(ChatGenerateNewTextMessageEvent(inputMessage: text));
          }
        },
        child: Center(
          child: Icon(Icons.send, color: Colors.white),
        ),
        splashColor: Color.fromARGB(255, 33, 33, 34), // Add this line to customize the splash color
      ),
    ),
  ),
),


                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (_isAboveEnd)
  Center(
    child: Padding(
      padding: EdgeInsets.only(right: 22.0, bottom: 120.0),
      child: Align(
        alignment: Alignment.bottomRight,
        child: IconButton(
          icon: Icon(Icons.arrow_downward, color: Colors.white, size: 30,),
          onPressed: () {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: Duration(milliseconds: 300),
              curve: Curves.fastOutSlowIn,
            );
          },
        ),
      ),
    ),
  ),
                        /*if (chatBloc.generating)
                         Center(
                          child: Padding(
                            padding: EdgeInsets.only( right:0,bottom: 110.0),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child:Lottie.asset('assets/loader.json',
                              height: 70,width: 70) ,
                              ),
                            ),
                          ),*/

                ],
              );
            default:
              return SizedBox();
          }
        },
      ),
    );
  }
}
