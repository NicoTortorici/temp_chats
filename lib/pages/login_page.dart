import 'package:flutter/material.dart';
import 'package:temp_chats/widgets/curve_painter.dart';
import 'package:temp_chats/widgets/main_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CurveWidget(
        children: [
          TextField(
            decoration: InputDecoration(
              filled: true,
              hintText: 'Name...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
          SizedBox(height: 25),
          MainButton(
            text: 'Join Now',
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
