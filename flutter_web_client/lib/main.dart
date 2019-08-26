import 'package:flutter_web/material.dart';
import 'package:flutter_web/foundation.dart';
import 'package:web_socket_channel/html.dart';

import 'lobby.dart';
import 'login_dialog.dart';

void main() => runApp(
  MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'WebSocket Demo',
    theme: ThemeData(
      fontFamily: 'Hammersmith One',
    ),
    home: MyHomePage(
      channel: HtmlWebSocketChannel.connect('ws://localhost:8080/ws'),
    ),
  )
);

class MyHomePage extends StatefulWidget {
  final HtmlWebSocketChannel channel;

  MyHomePage({Key key, @required this.channel})
    : super(key: key) {
      this.channel.stream.listen((msg) {
        print("Server: $msg"); // print channel messages from server
      });
    }

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: <Widget>[
            Lobby(
              channel: widget.channel,
            ),
            LoginDialog(
              channel: widget.channel
            ),
          ],
        ),
    );
  }

  @override
  void dispose() {
    widget.channel.sink.close();
    super.dispose();
  }
}