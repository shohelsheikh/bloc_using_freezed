import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ErrorMessageWidget extends StatelessWidget {
  final String error;
  const ErrorMessageWidget(this.error);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 48,
          ),
          SizedBox(width: 12),
          Flexible(
            child: Text(
              error,
              softWrap: true,
            ),
          )
        ],
      ),
    );
  }
}
