import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isSidebarExpanded = false;
  bool _isMobileSidebarOpen = false;
  String _selectedMenu = "home";
  int streakCount = 5;
  int lives = 3;
  int rubies = 120;
  bool isStreakActive = true; // This should be updated based on login time

  static const Color primaryColor = Color(0xFFFF7F00);
  static const Color selectedColor = Color(0xFF2C3F6D);
  static const Color unselectedColor = Color(0xFF363636);
  static const List<Color> lessonColors = [
    Color(0xFF2C3F6D),
    Color(0xFF83B100),
    Color(0xFFE82C36),
    Color(0xFF4C1199),
  ];
  // Simulated Lesson Data (Replace this with data from Supabase)
  // TODO: Replace `units` list with Supabase data retrieval.
  // Fetch units and lessons dynamically and map them accordingly.
  final List<Map<String, dynamic>> units = [
    {
      "title": "Unit 1: Basics",
      "lessons": [
        {
          "title": "Lesson 1",
          "image": "assets/icons/lesson1.png",
          "progress": 0.5,
          "unlocked": true,
        },
        {
          "title": "Lesson 2",
          "image": "assets/icons/lesson2.png",
          "progress": 0.2,
          "unlocked": true,
        },
        {
          "title": "Lesson 3",
          "image": "assets/icons/lesson3.png",
          "progress": 0.0,
          "unlocked": false,
        },
      ],
    },
    {
      "title": "Unit 2: Intermediate",
      "lessons": [
        {
          "title": "Lesson 1",
          "image": "assets/icons/lesson4.png",
          "progress": 0.0,
          "unlocked": false,
        },
        {
          "title": "Lesson 2",
          "image": "assets/icons/lesson5.png",
          "progress": 0.0,
          "unlocked": false,
        },
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      body: Stack(
        children: [
          Row(
            children: [
              // Sidebar
              MouseRegion(
                onEnter: (_) => setState(() => _isSidebarExpanded = true),
                onExit: (_) => setState(() => _isSidebarExpanded = false),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: isMobile ? 0 : (_isSidebarExpanded ? 205 : 85),
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
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            _buildSidebarItem("home", Icons.home, "Home"),
                            _buildSidebarItem(
                              "flashcard",
                              Icons.menu_book,
                              "Flashcard",
                            ),
                            _buildSidebarItem(
                              "practice",
                              Icons.sports_esports,
                              "Practice",
                            ),
                            _buildSidebarItem(
                              "profile",
                              Icons.person,
                              "Profile",
                            ),
                          ],
                        ),
                      ),
                      // Logout Button at Bottom
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            children: [
                              Icon(
                                Icons.logout,
                                color: unselectedColor,
                                size: 30,
                              ),
                              if (_isSidebarExpanded)
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Text(
                                    "Logout",
                                    style: TextStyle(
                                      color: unselectedColor,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Main Content
              Expanded(
                child: Column(
                  children: [
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          _buildAppBarIcon(
                            Icons.local_fire_department,
                            streakCount,
                            isStreakActive ? Colors.orange : Colors.grey,
                          ),
                          const SizedBox(width: 16),
                          _buildAppBarIcon(Icons.favorite, lives, Colors.red),
                          const SizedBox(width: 16),
                          _buildAppBarIcon(Icons.diamond, rubies, Colors.blue),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ListView(
                          children:
                              units
                                  .map((unit) => _buildUnitSection(unit))
                                  .toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Mobile Sidebar with Overlay
          if (isMobile && _isMobileSidebarOpen)
            GestureDetector(
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
                          onPressed:
                              () =>
                                  setState(() => _isMobileSidebarOpen = false),
                        ),
                        _buildSidebarItem(
                          "home",
                          Icons.home,
                          "Home",
                          isMobile: true,
                        ),
                        _buildSidebarItem(
                          "lessons",
                          Icons.menu_book,
                          "Lessons",
                          isMobile: true,
                        ),
                        _buildSidebarItem(
                          "games",
                          Icons.sports_esports,
                          "Games",
                          isMobile: true,
                        ),
                        _buildSidebarItem(
                          "profile",
                          Icons.person,
                          "Profile",
                          isMobile: true,
                        ),
                        // Logout Button
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Column(
                            children: [
                              Icon(
                                Icons.logout,
                                color: unselectedColor,
                                size: 30,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Text(
                                  "Logout",
                                  style: TextStyle(
                                    color: unselectedColor,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          // Mobile Sidebar Toggle Button
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

  Widget _buildUnitSection(Map<String, dynamic> unit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          unit["title"],
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Column(
          children:
              unit["lessons"].map<Widget>((lesson) {
                final index = unit["lessons"].indexOf(lesson);
                final color =
                    lesson["unlocked"]
                        ? lessonColors[index % lessonColors.length]
                        : Colors.grey;
                return _buildLessonCard(lesson, color);
              }).toList(),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildLessonCard(Map<String, dynamic> lesson, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: () {
          // TODO: Implement navigation to LessonScreen
        },
        child: Container(
          height: 100, // Adjustable height
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      lesson["title"],
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Completed ${(lesson["progress"] * 100).toInt()}%",
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 4),
                    LinearProgressIndicator(
                      value: lesson["progress"],
                      backgroundColor: Colors.white54,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              Image.asset(
                lesson["image"],
                width: 70,
                height: 70,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBarIcon(IconData icon, int count, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 30),
        const SizedBox(width: 5),
        Text(
          '$count',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
