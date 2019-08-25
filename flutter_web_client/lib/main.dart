import 'package:flutter_web/material.dart';
import 'package:flutter_web/foundation.dart';
import 'package:web_socket_channel/html.dart';

import 'chat_column.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WebSocket Demo',
      home: MyHomePage(
        channel: HtmlWebSocketChannel.connect('ws://localhost:8080/ws'),
      ),
    );
  }
}

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
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            ChatColumn(
              channel: widget.channel,
            ),
            _LoginModal(channel: widget.channel),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    widget.channel.sink.close();
    super.dispose();
  }
}

class _LoginModal extends StatefulWidget {
  final HtmlWebSocketChannel channel;

  _LoginModal({Key key, @required this.channel}) : super(key: key);

    @override
  _LoginModalState createState() => _LoginModalState();
}

class _LoginModalState extends State<_LoginModal> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text("Action Dialog!"),
    );
  }

  // void _sendMessage() {
  //   print(">>> sending ${_controller.text}");
  //   if (_controller.text.isNotEmpty) {
  //     widget.channel.sink.add(_controller.text);
  //   }
  // }
}