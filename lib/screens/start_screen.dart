import 'dart:math';
import 'package:flutter/material.dart';
import 'coding_screen.dart';
import 'general_knowledge_screen.dart';
import 'geography_screen.dart';
import 'math_questions_screen.dart';
import 'quiz_screen.dart';
import 'sport_screen.dart';
import 'technology_screen.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  double _decorationTop = -100.0;

  @override
  void initState() {
    super.initState();
    // Start the falling animation when the widget is created
    startFallingAnimation();
  }

  void startFallingAnimation() async {
    while (true) {
      await Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          _decorationTop = 100.0; // Adjust this value for the desired final position
        });
      });
      await Future.delayed(const Duration(seconds: 2)); // Wait for the animation to complete

      setState(() {
        _decorationTop = -100.0; // Reset to the initial position for the next animation
      });
    }
  }

  Widget _buildQuizButton(BuildContext context, String category, Widget quizScreen, IconData iconData, Color buttonColor) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => quizScreen,
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 3,
      ),
      child: Container(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              size: 40,
              color: Colors.black,
            ),
            const SizedBox(height: 10),
            Text(
              category,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.visible,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          margin: const EdgeInsets.all(10),
          child: const Icon(
            Icons.star,
            size: 30,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        title: const Text('・Q͜͡uizzes・'),
        titleSpacing: 0.0,
        actions: [
          Container(
            margin: const EdgeInsets.all(10),
            child: const Icon(
              Icons.star,
              size: 30,
              color: Colors.white,
            ),
          ),
        ],
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.indigo],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Stack(
            children: List.generate(2, (index) {
              final random = Random();
              final left = random.nextDouble() * 600;
              final top = _decorationTop + random.nextDouble() * 50;
              return AnimatedPositioned(
                duration: const Duration(seconds: 3),
                top: top,
                left: left,
                // top: _decorationTop,
                // left: index * 92.0, // Adjust the spacing between stars
                child: const Icon(
                  Icons.star,
                  color: Colors.yellow,
                ),
              );
            }),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 16,
          children: [
            _buildQuizButton(context, 'Maths Quiz', const mathQuestionsScreen(category: 'Maths'), Icons.calculate, Colors.blue),
            _buildQuizButton(context, 'Geography Quiz', const geoQuestionsScreen(category: 'Geography'), Icons.public, Colors.green),
            _buildQuizButton(context, 'GK Quiz', const gkQuestionsScreen(category: 'GK'), Icons.lightbulb_outline, Colors.yellow),
            _buildQuizButton(context, 'Sports Quiz', const sportQuestionsScreen(category: 'Sport'), Icons.sports, Colors.orange),
            _buildQuizButton(context, 'Coding Quiz', const codingQuestionsScreen(category: 'Coding'), Icons.code, Colors.purple),
            _buildQuizButton(context, 'Technology Quiz', const techQuestionsScreen(category: 'Technology'), Icons.devices, Colors.teal),
            _buildQuizButton(context, 'Random Quiz', const QuizScreen(category: 'Random'), Icons.shuffle, Colors.red),
          ],
        ),
      ),
    );
  }
}
