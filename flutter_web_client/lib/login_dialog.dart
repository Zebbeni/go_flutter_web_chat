import 'package:flutter_web/material.dart';
import 'package:flutter_web/foundation.dart';
import 'package:web_socket_channel/html.dart';

class LoginDialog extends StatefulWidget {
  final HtmlWebSocketChannel channel;

  LoginDialog({Key key, @required this.channel}) : super(key: key);

    @override
  _LoginDialogState createState() => _LoginDialogState();
}

class _LoginDialogState extends State<LoginDialog> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: 80,
        child: Column(
          children: <Widget>[
            Text(
              'Enter a Name',
              style: TextStyle(
                fontFamily: 'Hammersmith',
              ),
            ),
            RawKeyboardListener(
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
                textAlign: TextAlign.center,
                controller: _controller,
                decoration: InputDecoration(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _sendMessage() {
    print(">>> set name request: ${_controller.text}");
    if (_controller.text.isNotEmpty) {
      widget.channel.sink.add(_controller.text);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}