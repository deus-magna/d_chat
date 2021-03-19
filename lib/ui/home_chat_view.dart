import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import 'friends_chat_view.dart';

class HomeChatView extends StatefulWidget {
  @override
  _HomeChatViewState createState() => _HomeChatViewState();
}

class _HomeChatViewState extends State<HomeChatView> {
  final _usernameController = TextEditingController();
  String _usernameError;
  bool _loading = false;

  Future<void> _onGoPressed() async {
    final username = _usernameController.text;

    if (username.isEmpty) {
      setState(() {
        _usernameError = 'Username is not valid';
      });
    } else {
      setState(() {
        _loading = true;
      });
      final client = StreamChat.of(context).client;
      await client.connectUser(User(id: username), client.devToken(username));
      setState(() {
        _loading = false;
      });

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => FriendsChatView()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: Center(
        child: _loading
            ? CircularProgressIndicator()
            : Card(
                elevation: 11,
                margin: EdgeInsets.all(16.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Welcome'),
                      TextField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          hintText: 'Username',
                          errorText: _usernameError,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: _onGoPressed,
                        child: Text('Go'),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
