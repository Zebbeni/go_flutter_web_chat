import 'package:flutter_web/material.dart';
import 'package:flutter_web/foundation.dart';
import 'package:web_socket_channel/html.dart';

import 'chat_text_field.dart';

class Lobby extends StatefulWidget {
  final HtmlWebSocketChannel channel;

  Lobby({Key key, @required this.channel}) : super(key: key);

  @override
  LobbyState createState() => LobbyState();
}

class LobbyState extends State<Lobby> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ChatTextField(channel: widget.channel,)
      ],
    );
  }
}