import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rock Paper Scissors',
      theme: ThemeData(useMaterial3: true, primarySwatch: Colors.deepPurple),
      home: const RpsGamePage(),
    );
  }
}

class RpsGamePage extends StatefulWidget {
  const RpsGamePage({super.key});

  @override
  State<RpsGamePage> createState() => _RpsGamePageState();
}

class _RpsGamePageState extends State<RpsGamePage>
    with TickerProviderStateMixin {
  final List<String> choices = ["Rock", "Paper", "Scissors"];
  final Random random = Random();

  String userChoice = "-";
  String computerChoice = "-";
  String resultMessage = "Make your move!";

  int playerScore = 0;
  int computerScore = 0;

  String selectedButton = ""; // Track selected button

  late AnimationController _scaleController;
  late AnimationController _rotationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _rotationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  void playGame(String selected) {
    final String comp = choices[random.nextInt(choices.length)];
    final String result = getWinner(selected, comp);

    _scaleController.forward(from: 0.0);
    _rotationController.forward(from: 0.0);

    setState(() {
      selectedButton = selected;
      userChoice = selected;
      computerChoice = comp;
      resultMessage = result;

      if (result == "You Win!") playerScore++;
      if (result == "Computer Wins!") computerScore++;
    });
  }

  String getWinner(String user, String comp) {
    if (user == comp) return "Draw!";

    // User win conditions
    if ((user == "Rock" && comp == "Scissors") ||
        (user == "Paper" && comp == "Rock") ||
        (user == "Scissors" && comp == "Paper")) {
      return "You Win!";
    }

    return "Computer Wins!";
  }

  void resetGame() {
    setState(() {
      userChoice = "-";
      computerChoice = "-";
      resultMessage = "Make your move!";
      playerScore = 0;
      computerScore = 0;
      selectedButton = "";
    });
  }

  Color _getResultColor() {
    if (resultMessage == "You Win!") return Colors.green.shade400;
    if (resultMessage == "Computer Wins!") return Colors.red.shade400;
    if (resultMessage == "Draw!") return Colors.orange.shade400;
    return Colors.grey.shade400;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.deepPurple.shade900,
              Colors.deepPurple.shade700,
              Colors.purple.shade600,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Title
                const Text(
                  "Rock Paper Scissors",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 24),

                // Score panel
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue.shade400, Colors.cyan.shade300],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.5),
                        blurRadius: 12,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          const Text(
                            "Player",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "$playerScore",
                            style: const TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Container(height: 60, width: 2, color: Colors.white30),
                      Column(
                        children: [
                          const Text(
                            "Computer",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "$computerScore",
                            style: const TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Choices display
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.amber.shade600, Colors.orange.shade500],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.orange.withOpacity(0.5),
                        blurRadius: 12,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      ScaleTransition(
                        scale: _scaleAnimation,
                        child: Text(
                          "Your Choice: $userChoice",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      ScaleTransition(
                        scale: _scaleAnimation,
                        child: Text(
                          "Computer: $computerChoice",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      AnimatedBuilder(
                        animation: _rotationController,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: 0.9 + (_rotationController.value * 0.1),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                color: _getResultColor(),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: _getResultColor().withOpacity(0.6),
                                    blurRadius: 8,
                                  ),
                                ],
                              ),
                              child: Text(
                                resultMessage,
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 28),

                // Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildGameButton(
                      "🪨 Rock",
                      "Rock",
                      Colors.grey.shade600,
                      () => playGame("Rock"),
                    ),
                    _buildGameButton(
                      "📄 Paper",
                      "Paper",
                      Colors.cyan.shade600,
                      () => playGame("Paper"),
                    ),
                    _buildGameButton(
                      "✂️ Scissors",
                      "Scissors",
                      Colors.pink.shade600,
                      () => playGame("Scissors"),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Reset button
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.redAccent.withOpacity(0.5),
                        blurRadius: 8,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: resetGame,
                    child: const Text(
                      "🔄 Reset Game",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGameButton(
    String label,
    String choiceName,
    Color color,
    VoidCallback onPressed,
  ) {
    final bool isSelected = selectedButton == choiceName;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: isSelected
                ? Colors.yellow.withOpacity(0.8)
                : color.withOpacity(0.6),
            blurRadius: isSelected ? 16 : 10,
            spreadRadius: isSelected ? 4 : 2,
          ),
        ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? color.withOpacity(0.9) : color,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(
            horizontal: isSelected ? 20 : 16,
            vertical: isSelected ? 14 : 12,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: isSelected
                ? const BorderSide(color: Colors.yellow, width: 3)
                : BorderSide.none,
          ),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: TextStyle(
            fontSize: isSelected ? 16 : 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
