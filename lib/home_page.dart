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