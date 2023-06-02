import 'package:flutter/material.dart';

class DefaultText extends StatelessWidget {
  const DefaultText({Key? key, required this.text, required this.icon});

  final String text;
  final IconData icon;
  // it will be put as an argument every time i use this widget so i'll be able to put different inputs and the widget is reusable now

  @override
  Widget build(BuildContext context) {
    return Container(
      //this container is responsible for the outer blue part of the text
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.blue,
            blurRadius: 1,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Row(
        //continuing with two items side by side using row which is a text says if the deice is connected and an icon representing it
        children: [
          Padding(
            padding: const EdgeInsets.all(6),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            width: 4,
          ),
          Icon(
            icon,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
