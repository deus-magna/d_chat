import 'package:d_chat/ui/home_chat_view.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    StreamChatClient _client =
        StreamChatClient('k8j8e85cnw4j', logLevel: Level.INFO);

    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return StreamChat(client: _client, child: child);
      },
      home: HomeChatView(),
    );
  }
}
