import 'package:flutter/material.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({Key? key}) : super(key: key);

  static const routeName = 'message';

  @override
  Widget build(BuildContext context) {
    final argMessage = ModalRoute.of(context)?.settings.arguments ?? 'No Data';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Message'),
      ),
      body: Center(
        child: Text(
          '$argMessage',
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}
