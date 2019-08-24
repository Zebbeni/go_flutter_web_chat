import 'package:flutter_web/material.dart';
import 'package:flutter_web/foundation.dart';
import 'package:web_socket_channel/html.dart';

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
        print("Server message: $msg"); // print channel messages from server
      });
    }

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            RawKeyboardListener(
              focusNode: FocusNode(),
              onKey: (event) {
                // todo: We should be able to use _sendMessage as the TextField's
                // onSubmitted callback, but this isn't working for web right now. 
                bool isRawKeyEvent = event.runtimeType == RawKeyDownEvent;
                bool isEnter = event?.logicalKey?.keyId == 54;
                if (isRawKeyEvent && isEnter) {
                  _sendMessage();
                }
              },
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(labelText: 'type a message and hit enter'),
                // onSaved: (_) => _sendMessage(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _sendMessage() {
    print(">>> sending ${_controller.text}");
    if (_controller.text.isNotEmpty) {
      widget.channel.sink.add(_controller.text);
    }
  }

  @override
  void dispose() {
    widget.channel.sink.close();
    super.dispose();
  }
}