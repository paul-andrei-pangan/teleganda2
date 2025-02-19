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


  }

