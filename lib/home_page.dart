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
