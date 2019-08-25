import 'package:flutter_web/material.dart';
import 'package:flutter_web/foundation.dart';
import 'package:web_socket_channel/html.dart';

class ChatTextField extends StatefulWidget {
  final HtmlWebSocketChannel channel;

  ChatTextField({Key key, @required this.channel}) : super(key: key);

  @override
  ChatTextFieldState createState() => ChatTextFieldState();
}

class ChatTextFieldState extends State<ChatTextField> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      onKey: (event) {
        // todo: We ought to be able to use _sendMessage as the TextField's
        // onSubmitted callback, but this isn't working for web right now.
        // https://github.com/flutter/flutter/issues/19027
        bool isRawKeyEvent = event.runtimeType == RawKeyDownEvent;
        bool isEnter = event?.logicalKey?.keyId == 54;
        if (isRawKeyEvent && isEnter) {
          _sendMessage();
        }
      },
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(labelText: 'type a message and hit enter'),
      ),
    );
  }

  void _sendMessage() {
    print(">>> sending ${_controller.text}");
    if (_controller.text.isNotEmpty) {
      widget.channel.sink.add(_controller.text);
    }
  }
}