import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

class FlashcardScreen extends StatefulWidget {
  const FlashcardScreen({super.key});

  @override
  _FlashcardScreenState createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen> {
  bool _isSidebarExpanded = false;
  bool _isMobileSidebarOpen = false;
  String _selectedMenu = "flashcard";

  static const Color primaryColor = Color(0xFFFF7F00);
  static const Color selectedColor = Color(0xFF2C3F6D);
  static const Color unselectedColor = Color(0xFF363636);

  List<Map<String, String>> flashcards = [
    {'word': 'Hello', 'meaning': '👋 (Hello in sign language)'},
    {'word': 'Thank You', 'meaning': '🙏 (Thank you in sign language)'},
    {'word': 'Love', 'meaning': '❤️ (Love in sign language)'},
  ];

  int currentIndex = 0;

  void nextCard() {
    setState(() {
      currentIndex = (currentIndex + 1) % flashcards.length;
    });
  }

  void previousCard() {
    setState(() {
      currentIndex = (currentIndex - 1 + flashcards.length) % flashcards.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      appBar: AppBar(title: Text("Flashcards")),
      body: Stack(
        children: [
          Row(
            children: [
              if (!isMobile) _buildSidebar(),
              Expanded(
                child: GestureDetector(
                  onHorizontalDragEnd: (details) {
                    if (details.primaryVelocity! < 0) {
                      nextCard();
                    } else if (details.primaryVelocity! > 0) {
                      previousCard();
                    }
                  },
                  child: Center(
                    child: FlipCard(
                      direction: FlipDirection.HORIZONTAL,
                      front: _buildCard(flashcards[currentIndex]['word']!),
                      back: _buildCard(flashcards[currentIndex]['meaning']!),
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (isMobile && _isMobileSidebarOpen) _buildMobileSidebarOverlay(),
          if (isMobile)
            Positioned(
              top: 20,
              left: 10,
              child: IconButton(
                icon: const Icon(Icons.menu, color: primaryColor),
                onPressed: () => setState(() => _isMobileSidebarOpen = true),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSidebar() {
    return MouseRegion(
      onEnter: (_) => setState(() => _isSidebarExpanded = true),
      onExit: (_) => setState(() => _isSidebarExpanded = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: _isSidebarExpanded ? 205 : 85,
        color: primaryColor,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Center(
              child: Image.asset(
                'assets/images/LOGO.png',
                width: _isSidebarExpanded ? 150 : 50,
              ),
            ),
            const SizedBox(height: 20),
            _buildSidebarItem("home", Icons.home, "Home"),
            _buildSidebarItem("flashcard", Icons.menu_book, "Flashcard"),
            _buildSidebarItem("practice", Icons.sports_esports, "Practice"),
            _buildSidebarItem("profile", Icons.person, "Profile"),
            Spacer(),
            _buildLogoutButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileSidebarOverlay() {
    return GestureDetector(
      onTap: () => setState(() => _isMobileSidebarOpen = false),
      child: Container(
        color: Colors.black45,
        child: Align(
          alignment: Alignment.centerLeft,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 200,
            color: primaryColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => setState(() => _isMobileSidebarOpen = false),
                ),
                _buildSidebarItem("home", Icons.home, "Home", isMobile: true),
                _buildSidebarItem(
                  "flashcard",
                  Icons.menu_book,
                  "Flashcard",
                  isMobile: true,
                ),
                _buildSidebarItem(
                  "practice",
                  Icons.sports_esports,
                  "Practice",
                  isMobile: true,
                ),
                _buildSidebarItem(
                  "profile",
                  Icons.person,
                  "Profile",
                  isMobile: true,
                ),
                _buildLogoutButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSidebarItem(
    String menu,
    IconData icon,
    String label, {
    bool isMobile = false,
  }) {
    bool isSelected = _selectedMenu == menu;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
      child: GestureDetector(
        onTap: () {
          setState(() => _selectedMenu = menu);
          // Navigate based on menu selection
          if (menu == 'home') {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (menu == 'flashcard') {
            Navigator.pushReplacementNamed(context, '/flashcard');
          }
        },
        child: Container(
          decoration:
              isSelected
                  ? BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                      right: BorderSide(color: Colors.white, width: 5),
                    ),
                  )
                  : null,
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Icon(
                icon,
                color: isSelected ? selectedColor : unselectedColor,
                size: 40,
              ),
              if (_isSidebarExpanded || isMobile)
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    label,
                    style: TextStyle(
                      color: isSelected ? selectedColor : unselectedColor,
                      fontSize: 16,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Column(
          children: [
            Icon(Icons.logout, color: unselectedColor, size: 30),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                "Logout",
                style: TextStyle(color: unselectedColor, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(String text) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: 300,
        height: 200,
        alignment: Alignment.center,
        padding: EdgeInsets.all(20),
        child: Text(
          text,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
