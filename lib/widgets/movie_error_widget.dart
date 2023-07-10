import 'package:flutter/material.dart';

class MovieErrorWidget extends StatelessWidget {
  final String message;
  final String routeName;
  const MovieErrorWidget(
      {required this.message, required this.routeName, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Chip(
                avatar: const Icon(
                  Icons.error,
                  color: Colors.red,
                ),
                label: Text(message),
                side: BorderSide.none,
              ),
              const SizedBox(
                width: 5,
              ),
              ActionChip(
                label: const Text('Retry'),
                onPressed: () =>
                    Navigator.of(context).pushReplacementNamed(routeName),
                side: BorderSide.none,
                avatar: const Icon(Icons.refresh),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
