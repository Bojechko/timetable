import 'package:flutter/material.dart';

class CommonWidget extends StatelessWidget {
  const CommonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      color: Colors.red,
      child: const Text('common widget dx'),
    );
  }
}
