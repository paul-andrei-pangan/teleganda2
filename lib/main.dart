import 'package:flutter/cupertino.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      theme: CupertinoThemeData(brightness: Brightness.dark),
      home: MyHomePage(),
    );
  }
}

class Member {
  final String imagePath;
  final String name;
  final String info;

  Member({required this.imagePath, required this.name, required this.info});
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isMembersVisible = false;
  Member? selectedMember;

  final List<Member> members = [
    Member(imagePath: 'images/cris.png', name: 'De Quiroz Cris Anne', info: 'San Nicolas'),
    Member(imagePath: 'images/aira.png', name: 'Parungao Aira Mae', info: 'Arayat'),
    Member(imagePath: 'images/paul.png', name: 'Pangan Paul Andrei', info: 'San Roque'),
    Member(imagePath: 'images/james.png', name: 'Dizon James Draizen', info: 'San Roque'),
    Member(imagePath: 'images/rein.png', name: 'Palabasan Rein Heart', info: 'Sta Ana'),
  ];

  // Toggle the visibility of the members list and clear selected member info
  void _toggleMembersVisibility() {
    setState(() {
      isMembersVisible = !isMembersVisible;
      if (!isMembersVisible) {
        selectedMember = null; // Clear selected member when the menu is closed
      }
    });
  }

  // Select a member and display their info
  void _selectMember(Member member) {
    setState(() {
      selectedMember = member;
    });
  }

  // Text controller for message input
  final TextEditingController _messageController = TextEditingController();

  // Function to simulate sending a message
  void _sendMessage() {
    if (_messageController.text.isNotEmpty && selectedMember != null) {
      String message = _messageController.text;
      // Simulate sending message to selected member
      print('Message sent to ${selectedMember!.name}: $message');
      // Clear the message input after sending
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Teleganda'),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: _toggleMembersVisibility,
          child: const Icon(CupertinoIcons.bars),
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Row(
            children: [
              // First Column: Member list with images and names
              Expanded(
                child: Column(
                  children: [
                    if (isMembersVisible)
                      Column(
                        children: members.map((member) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: CupertinoButton(
                              onPressed: () => _selectMember(member), // Select a member when clicked
                              padding: EdgeInsets.zero,
                              child: Row(
                                children: [
                                  ClipOval(
                                    child: Image.asset(
                                      member.imagePath,
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    member.name,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 20), // Add spacing between columns
              // Second Column: Display selected member's info and chat
              if (selectedMember != null)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipOval(
                        child: Image.asset(
                          selectedMember!.imagePath,
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        selectedMember!.name,
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        selectedMember!.info, // Show additional information
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 20),
                      // Chat message input and send button
                      CupertinoTextField(
                        controller: _messageController,
                        placeholder: 'Type a message...',
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        style: const TextStyle(fontSize: 16),
                      ),
                      CupertinoButton(
                        onPressed: _sendMessage,
                        child: const Text('Send', style: TextStyle(fontSize: 18)),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
