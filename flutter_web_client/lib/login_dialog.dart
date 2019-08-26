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
      content: Text("Action Dialog!"),
    );
  }

  // void _sendMessage() {
  //   print(">>> sending ${_controller.text}");
  //   if (_controller.text.isNotEmpty) {
  //     widget.channel.sink.add(_controller.text);
  //   }
  // }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}