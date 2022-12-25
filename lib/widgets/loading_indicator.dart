import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  final String text;

    LoadingIndicator({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          const SizedBox(
            height: 12,
          ),
          Text(text),
        ],
      ),
    );
  }
}
