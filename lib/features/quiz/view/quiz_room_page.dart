import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class QuizRoomPage extends StatefulWidget {
  const QuizRoomPage({super.key});

  @override
  State<QuizRoomPage> createState() => _QuizRoomPageState();
}

class _QuizRoomPageState extends State<QuizRoomPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Room'),
      ),
      body: const Center(
        child: Text('Quiz Room Page'),
      ),
    );
  }
}
