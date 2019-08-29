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
    return
      Center(
        child: SizedBox.fromSize(
          size: Size(700.0, 700.0),
          child: Row(
            children: <Widget>[
              SizedBox.fromSize(
                size: Size.fromWidth(200.0),
                child: Column(
                  children: <Widget>[
                    Text("Example Name 1"),
                    Text("Example Name 2"),
                  ],
                ),
              ),
              SizedBox.fromSize(
                size: Size.fromWidth(500.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ChatTextField(channel: widget.channel,)
                  ],
                ),
              ),
            ],
          ),
        ),
    );
  }
}