import 'package:flutter/material.dart';

class CustomRefresh extends StatelessWidget {
  final String message;
  final Function() onClick;

  const CustomRefresh({
    super.key,
    required this.message,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: onClick,
            child: const Text('Refresh'),
          ),
        ],
      ),
    );
  }
}
