import 'package:flutter/material.dart';

/// Represents a single button that can be re-used.
class MainButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const MainButton({Key? key, required this.text, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(

      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(fontSize: 20),
      ),


      style: ButtonStyle(

        backgroundColor:
            MaterialStateProperty.all<Color>(Theme.of(context).accentColor),
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
    );
  }
}
