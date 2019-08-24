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
      print(">>> create home page");
      this.channel.stream.listen((msg) {
        print("Client received: $msg"); // print channel messages from server
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
            Form(
              child: TextFormField(
                controller: _controller,
                decoration: InputDecoration(labelText: 'type a message and hit enter'),
                onFieldSubmitted: (_) => _sendMessage(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendMessage,
        tooltip: 'Send message',
        child: Icon(Icons.send),
      ), // This
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