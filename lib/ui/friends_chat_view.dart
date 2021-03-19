import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class FriendsChatView extends StatefulWidget {
  @override
  _FriendsChatViewState createState() => _FriendsChatViewState();
}

class _FriendsChatViewState extends State<FriendsChatView> {
  final _keyChannels = GlobalKey<ChannelsBlocState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Public chat'),
      ),
      body: ChannelsBloc(
        key: _keyChannels,
        child: ChannelListView(
          channelWidget: ChannelView(),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: _onCreateChannel, label: Text('Create Channel')),
    );
  }

  void _onCreateChannel() async {
    final result = await showDialog(
      context: context,
      builder: (context) {
        final _channelController = TextEditingController();
        return AlertDialog(
          title: Text('Create Channel'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Welcome'),
              TextField(
                controller: _channelController,
                decoration: InputDecoration(
                  hintText: 'Channel Name',
                ),
              ),
              ElevatedButton(
                onPressed: () =>
                    Navigator.of(context).pop(_channelController.text),
                child: Text('Save'),
              ),
            ],
          ),
        );
      },
    );

    if (result != null) {
      final client = StreamChat.of(context).client;
      final channel = client.channel('messaging', id: result);
      await channel.create();
      _keyChannels.currentState.queryChannels();
    }
  }
}

class ChannelView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChannelHeader(),
      body: Column(
        children: [
          Expanded(
            child: MessageListView(),
          ),
          MessageInput(),
        ],
      ),
    );
  }
}
