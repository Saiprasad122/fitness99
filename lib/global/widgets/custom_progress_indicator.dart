import 'package:flutter/material.dart';

class CustomProgressIndicator extends StatelessWidget {
  const CustomProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: SizedBox.expand(
        child: Container(
          color: Colors.black45,
          child: Center(
            child: SizedBox(
              height: 60,
              width: 60,
              child: CircularProgressIndicator(
                color: Colors.blue,
                strokeWidth: 5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
