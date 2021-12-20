import 'package:flutter/material.dart';
import 'package:temp_chats/widgets/curve_painter.dart';
import 'package:temp_chats/widgets/main_button.dart';

class LoginPage extends StatefulWidget {
  final Function(String) setName;

  const LoginPage({Key? key, required this.setName}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState(setName: this.setName);
}

class _LoginPageState extends State<LoginPage> {
  final Function(String) setName;

  TextEditingController controller = TextEditingController();

  _LoginPageState({required this.setName});

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
            controller: controller,
          ),
          SizedBox(height: 25),
          MainButton(
            text: 'Join Now',
            onPressed: () {
              setName(controller.text);
              Navigator.of(context).pushNamed('/chats');
            },
          )
        ],
      ),
    );
  }
}
