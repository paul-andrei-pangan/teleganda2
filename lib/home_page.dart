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
  // 📌 Developer Item
  Widget _developerItem(Map<String, String> dev, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedDeveloper = selectedDeveloper == dev ? null : dev; // Toggle developer info visibility
          });
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center image and name vertically
          children: [
            Row(
              children: [
                CircleAvatar(radius: 40, backgroundImage: AssetImage(dev['image']!)),
                SizedBox(width: 10),
                selectedDeveloper == dev
                    ? Text(dev['name']!, style: TextStyle(fontSize: 18))
                    : SizedBox.shrink(),
              ],
            ),
            SizedBox(height: 10),
            // Display information below image
            selectedDeveloper == dev
                ? Column(
              children: [
                Text('Role: ${dev['role']}'),
                Text('Address: ${dev['address']}'),
                Text('Age: ${dev['age']}'),
                Text('Contact: ${dev['contact']}'),
                Text('Email: ${dev['email']}'),
              ],
            )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
// 📌 Stories Section
// 📌 Stories Section
class StoriesSection extends StatelessWidget {
  final List<String> stories = [
    'assets/s1.jpg',
    'assets/s2.jpg',
    'assets/s3.jpg',
    'assets/s4.jpg',
    'assets/s5.jpg',
    'assets/s6.jpg',
    'assets/s7.jpg',
    'assets/s8.jpg',
    'assets/s9.jpg',
    'assets/s10.jpg',
    'assets/s11.jpg',
    'assets/s12.jpg',
    'assets/s13.jpg',
    'assets/s14.jpg',
    'assets/s15.jpg',
    'assets/s16.jpg',
    'assets/s17.jpg',
    'assets/s20.jpg',
    'assets/s20.jpg',
    'assets/s20.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    return ListView(
        scrollDirection: Axis.horizontal,
        children: [
    Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: Column(
    children: [
    ClipOval(
    child: Container(
    width: 60,
    height: 60,
    color: Colors.grey[300],
    child: Icon(Icons.add, size: 30, color: Colors.black),
    ),
    ),
    SizedBox(height: 5),
    Text("Your Story", style: TextStyle(fontSize: 12)),
    ],
    ),
    ),
    ...stories.map((story) => GestureDetector(
    onTap: () => Navigator.push(
    context,
    CupertinoPageRoute(
    builder: (context) => StoryViewerPage(imagePath: story),
    ),
    ),
    child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 6.0),
    child: Column(
    children: [
    ClipOval(
    child: Container(
    width: 60,
    height: 60,
    decoration: BoxDecoration(
    shape: BoxShape.circle,
    border: Border.all(color: Colors.blue, width: 2), // Border outline
    ),
      child: ClipOval(
        child: Image.asset(
          story,
          width: 60,
          height: 60,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Icon(Icons.error, size: 50, color: Colors.red);
          },
        ),
      ),
    ),
    ),
      SizedBox(height: 5),
      Text("Friend", style: TextStyle(fontSize: 12)),
    ],
    ),
    ),
    )),
        ],
    );
  }
}
class StoryViewerPage extends StatelessWidget {
  final String imagePath;

  const StoryViewerPage({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Story Viewer'),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Icon(CupertinoIcons.back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      child: Center(
        child: Image.asset(imagePath),
      ),
    );
  }
}

// 📌 Chat List
class ChatList extends StatelessWidget {
  final String searchQuery;
  const ChatList({super.key, required this.searchQuery});

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> chats = [
      {
        'name': 'James Draizen Dizon',
        'message': 'Canceled Call',
        'image': 'images/dev3.jpg',
        'address': 'San Roque, Sta Ana, Pampanga',
        'age': '18',
        'contact': '09453212342',
        'email': 'james.dizon@egmail.com',
      },
      {
        'name': 'Paul Andrei Pangan',
        'message': '<Missed Call>',
        'image': 'images/dev2.jpg',
        'address': 'San Roque, Sta Ana, Pampanga',
        'age': '15',
        'contact': '0943543212',
        'email': 'paulandrei@gmail.com',
      },
      {
        'name': 'Aira Mae Paraungao',
        'message': 'Tara',
        'image': 'images/dev1.jpg',
        'address': 'Matamo, Arayat',
        'age': '30',
        'contact': '0954565423',
        'email': 'paulandrei@gmail.com',
      },
      {
        'name': 'Chris Anne De Quiroz',
        'message': 'lub tana',
        'image': 'images/dev5.jpg',
        'address': 'San Nicolas, Sta Ana, Pampanga',
        'age': '15',
        'contact': '09546575654',
        'email': 'paulandrei@gmail.com',
      },
      {
        'name': 'Rein Heart Palabasan',
        'message': 'tara lulu',
        'image': 'images/dev4.jpg',
        'address': 'San Joaquin, Sta Ana, Pampanga',
        'age': '15',
        'contact': '094324234326',
        'email': 'paulandrei@gmail.com',
      },
    ];

    // Filter chats based on the search query
    List<Map<String, String>> filteredChats = chats.where((chat) {
      return chat['name']!.toLowerCase().contains(searchQuery);
    }).toList();

    return CupertinoScrollbar(
      child: ListView(
        children: filteredChats.map((chat) => _chatItem(context, chat)).toList(),
      ),
    );
  }
  Widget _chatItem(BuildContext context, Map<String, String> chat) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Row(
        children: [
          // ✅ Ripple Effect + Border Outline sa Profile Image
          Material(
            shape: const CircleBorder(),
            clipBehavior: Clip.antiAlias,
            color: Colors.transparent,
            child: InkWell(
              onTap: () => _showProfile(context, chat),
              splashColor: Colors.blue.withOpacity(0.3), // Ripple color
              child: Container(
                padding: EdgeInsets.all(2), // Border padding
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.blue, width: 2), // 🔥 Border Outline
                ),
                child: CircleAvatar(radius: 30, backgroundImage: AssetImage(chat['image']!)),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(chat['name']!, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(chat['message']!, style: const TextStyle(fontSize: 15, color: CupertinoColors.systemGrey)),
            ],
          ),
          const Spacer(),
          const Icon(CupertinoIcons.chevron_forward, color: CupertinoColors.systemGrey),
        ],
      ),
    );
  }

  // 📌 Function to Show Profile
  void _showProfile(BuildContext context, Map<String, String> chat) {
    showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: Text(chat['name']!),
        content: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(3), // Border padding
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.blue, width: 3), // 🔥 Border Outline
              ),
              child: CircleAvatar(radius: 50, backgroundImage: AssetImage(chat['image']!)),
            ),
            const SizedBox(height: 10),
            Text("Address: ${chat['address']}"),
            Text("Age: ${chat['age']}"),
            Text("Contact: ${chat['contact']}"),
            Text("Email: ${chat['email']}"),
          ],
        ),
        actions: [
          CupertinoDialogAction(
            child: const Text(
              "Close",
              style: TextStyle(color: CupertinoColors.destructiveRed), // Red color for close
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}


