import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Controller for the search bar
  TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('TeleGanda'),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Icon(CupertinoIcons.bars), // Hamburger Menu
          onPressed: () => _showSidebar(context),
        ),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Icon(CupertinoIcons.info_circle), // About icon
          onPressed: () {
            // Show about description when clicked
            _showAboutDescription(context);
          },
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 50),
            child: SizedBox(height: 120, child: StoriesSection()),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CupertinoTextField(
              controller: _searchController,
              placeholder: 'Search chats...',
              onChanged: (text) {
                setState(() {
                  _searchQuery = text.toLowerCase();
                });
              },
            ),
          ),
          Expanded(child: ChatList(searchQuery: _searchQuery)),
        ],
      ),
    );
  }
  void _showSidebar(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => Align(
        alignment: Alignment.centerLeft,
        child: Container(
          width: 250,
          height: double.infinity,
          color: Colors.grey[900], // Dark gray sidebar
          padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/profile1.jpg'),
                ),
              ),
              SizedBox(height: 20),
              _sidebarItem(context, CupertinoIcons.settings, 'Settings', _openSettings),
              _sidebarItem(context, CupertinoIcons.person_2, 'Developers', _showDevelopers),
              Spacer(),
              Center(
                child: CupertinoButton(
                  child: Text('Logout', style: TextStyle(color: Colors.red)),
                  onPressed: () => _showLogoutPopup(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  // 📌 Sidebar Item Helper
  Widget _sidebarItem(BuildContext context, IconData icon, String text, Function(BuildContext) onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: GestureDetector(
        onTap: () => onTap(context),
        child: Row(
          children: [
            Icon(icon, size: 24, color: Colors.white),
            SizedBox(width: 10),
            Text(text, style: TextStyle(fontSize: 18, color: Colors.white)),
          ],
        ),
      ),
    );
  }

  // 📌 Open Settings (Functional OK Button)
  void _openSettings(BuildContext context) {
    Navigator.pop(context); // Close Sidebar
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text('Settings'),
        content: Text('Settings page is under development.'),
        actions: [
          CupertinoDialogAction(
            child: Text('OK'),
            onPressed: () {
              Navigator.pop(context); // ✅ Functional OK button
            },
          ),
        ],
      ),
    );
  }
// 📌 Show Developers List
  void _showDevelopers(BuildContext context) {
    Navigator.pop(context); // Close Sidebar
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => DevelopersPage(),
      ),
    );
  }

  // 📌 Logout Confirmation
  void _showLogoutPopup(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: Text('Logout'),
        content: Text('Are you sure you want to logout?'),
        actions: [
          CupertinoDialogAction(
            child: Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          CupertinoDialogAction(
            child: Text('OK', style: TextStyle(color: CupertinoColors.destructiveRed)),
            onPressed: () {
              Navigator.pop(context); // Close the dialog
              Navigator.pushNamedAndRemoveUntil(
                  context, '/login', (route) => false);

            },
          ),
        ],
      ),
    );
  }
// 📌 About Description Popup
  void _showAboutDescription(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: Text('About Teleganda '),
        content: Text('This is clone of the Telegram app built using Flutter.'),
        actions: [
          CupertinoDialogAction(
            child: Text('Close'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}

// Include the DevelopersPage, StoriesSection, and ChatList class code as it is.


class DevelopersPage extends StatefulWidget {
  @override
  _DevelopersPageState createState() => _DevelopersPageState();
}

class _DevelopersPageState extends State<DevelopersPage> {
  List<Map<String, String>> developers = [
    {
      'name': 'James',
      'image': 'assets/dev1.jpg',
      'role': 'Frontend Developer',
      'address': '123 Main St, Cityville',
      'age': '28',
      'contact': '123-456-7890',
      'email': 'james@example.com'
    },
    {
      'name': 'Paul',
      'image': 'assets/dev2.jpg',
      'role': 'Backend Developer',
      'address': '456 Oak St, Townsville',
      'age': '32',
      'contact': '987-654-3210',
      'email': 'paul@example.com'
    },
    {
      'name': 'Aira',
      'image': 'assets/dev3.jpg',
      'role': 'UI/UX Designer',
      'address': '789 Pine St, Villagetown',
      'age': '26',
      'contact': '555-123-4567',
      'email': 'aira@example.com'
    },
    {
      'name': 'Chris',
      'image': 'assets/dev4.jpg',
      'role': 'Project Manager',
      'address': '101 Maple St, Citytown',
      'age': '35',
      'contact': '666-234-5678',
      'email': 'chris@example.com'
    },
    {
      'name': 'Rein',
      'image': 'assets/dev5.jpg',
      'role': 'Full Stack Developer',
      'address': '202 Birch St, Uptown',
      'age': '30',
      'contact': '777-345-6789',
      'email': 'rein@example.com'
    },
  ];
  Map<String, String>? selectedDeveloper;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Developers'),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Icon(CupertinoIcons.back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Telegram-like title with icon above the developers
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    CupertinoIcons.app, // Icon similar to Telegram
                    size: 30,
                    color: CupertinoColors.activeBlue,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'TeleGanda', // Large Title
                    style: TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      color: CupertinoColors.activeBlue,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20), // Space between title and images
              // Top row with 2 developers
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _developerItem(developers[0], context),
                  _developerItem(developers[1], context),
                ],
              ),
              SizedBox(height: 20), // Space between rows
              // Bottom row with 3 developers
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _developerItem(developers[2], context),
                  _developerItem(developers[3], context),
                  _developerItem(developers[4], context),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

