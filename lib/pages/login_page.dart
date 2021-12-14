import 'package:flutter/material.dart';
import 'package:temp_chats/widgets/curve_painter.dart';

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
          ElevatedButton(
            onPressed: () {},
            child: Text(
              'Join Now',
              style: TextStyle(fontSize: 20),
            ),
            style: ButtonStyle(
              elevation: MaterialStateProperty.all(10),
              backgroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).accentColor),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
              ),
              padding: MaterialStateProperty.resolveWith<EdgeInsetsGeometry>(
                (Set<MaterialState> states) {
                  return EdgeInsets.symmetric(vertical: 20, horizontal: 50);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
