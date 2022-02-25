import 'package:flutter/material.dart';

class BtnAzul extends StatelessWidget {
  //const BtnAzul({Key? key}) : super(key: key);
final String text;
final VoidCallback onPressed;

  const BtnAzul({
    Key? key,
    required this.text,
    required this.onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  RaisedButton(
      elevation: 2,
      highlightElevation: 5,
      color: Colors.blue,
      shape: StadiumBorder(),
      onPressed: this.onPressed,
      child: Container(
        width: double.infinity,
        height: 55,
        child: Center(
          child: Text(this.text, style: TextStyle(color: Colors.white, fontSize: 17)),
        ),
      ),
    );
  }
}
