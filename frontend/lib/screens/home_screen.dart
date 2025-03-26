import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isDashboardExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Senya'),
        backgroundColor: Colors.orange,
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              // Navigate to profile screen
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.orange),
              child: const Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.school),
              title: const Text('Flashcards'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.gamepad),
              title: const Text('Practice'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: Row(
        children: [
          // Sidebar with hover effect
          MouseRegion(
            onEnter: (_) => setState(() => _isDashboardExpanded = true),
            onExit: (_) => setState(() => _isDashboardExpanded = false),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: _isDashboardExpanded ? 200 : 80, // Adjust sidebar width
              color: Colors.orange,
              child: Column(
                children: [
                  IconButton(
                    icon: const Icon(Icons.home, color: Colors.white),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.menu_book, color: Colors.white),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.videogame_asset,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.person, color: Colors.white),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),

          // Main Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _unitSection('UNIT 1', 'The Basics', [
                      _lessonCard(
                        'Lesson 1',
                        'Greetings',
                        0.6,
                        Colors.blue,
                        Icons.play_arrow,
                      ),
                      _lessonCard(
                        'Lesson 2',
                        'Alphabet',
                        0.0,
                        Colors.green,
                        Icons.lock,
                      ),
                      _lessonCard(
                        'Lesson 3',
                        'Numbers',
                        0.0,
                        Colors.red,
                        Icons.play_arrow,
                      ),
                    ]),
                    _unitSection('UNIT 2', 'Daily Conversations', [
                      _lessonCard(
                        'Lesson 1',
                        'Common Phrases',
                        0.0,
                        Colors.purple,
                        Icons.play_arrow,
                      ),
                      _lessonCard(
                        'Lesson 2',
                        'Introductions',
                        0.0,
                        Colors.teal,
                        Icons.lock,
                      ),
                    ]),
                    _unitSection('UNIT 3', 'Everyday Activities', [
                      _lessonCard(
                        'Lesson 1',
                        'Food & Drinks',
                        0.0,
                        Colors.orange,
                        Icons.play_arrow,
                      ),
                      _lessonCard(
                        'Lesson 2',
                        'Shopping',
                        0.0,
                        Colors.brown,
                        Icons.lock,
                      ),
                    ]),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _unitSection(String title, String subtitle, List<Widget> lessons) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.orange,
          ),
        ),
        Text(subtitle, style: const TextStyle(fontSize: 18)),
        Column(children: lessons),
      ],
    );
  }

  Widget _lessonCard(
    String title,
    String subtitle,
    double progress,
    Color color,
    IconData icon,
  ) {
    return Card(
      color: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(
          '$title\n$subtitle',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Icon(icon, color: Colors.white, size: 32),
        subtitle: LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.white.withOpacity(0.5),
          valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
        ),
      ),
    );
  }
}
