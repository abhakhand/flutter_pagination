import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 24,
        width: 24,
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: const CircularProgressIndicator.adaptive(
          strokeWidth: 2,
        ),
      ),
    );
  }
}
