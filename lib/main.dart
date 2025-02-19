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
  final String address;
  final String number;
  final int age;

  Member({required this.imagePath, required this.name, required this.address, required this.number, required this.age});
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isMembersVisible = false;
  bool isInfoVisible = false;
  Member? selectedMember;
  TextEditingController searchController = TextEditingController();

  final List<Member> members = [
    Member(imagePath: 'images/cris.png', name: 'De Quiroz Cris Anne', address: 'San Nicolas', number: '09123456789', age: 25),
    Member(imagePath: 'images/aira.png', name: 'Parungao Aira Mae', address: 'Arayat', number: '09234567890', age: 22),
    Member(imagePath: 'images/paul.png', name: 'Pangan Paul Andrei', address: 'San Roque', number: '09345678901', age: 27),
    Member(imagePath: 'images/james.png', name: 'Dizon James Draizen', address: 'San Roque', number: '09456789012', age: 23),
    Member(imagePath: 'images/rein.png', name: 'Palabasan Rein Heart', address: 'Sta Ana', number: '09567890123', age: 26),
  ];

  List<Member> filteredMembers = [];

  @override
  void initState() {
    super.initState();
    filteredMembers = members;
  }

  void _toggleMembersVisibility() {
    setState(() {
      isMembersVisible = !isMembersVisible;
      if (!isMembersVisible) {
        selectedMember = null;
      }
    });
  }

  void _toggleInfoVisibility() {
    setState(() {
      isInfoVisible = !isInfoVisible;
    });
  }

  void _selectMember(Member member) {
    setState(() {
      selectedMember = member;
    });
  }

  void _filterMembers(String query) {
    setState(() {
      filteredMembers = members.where((member) =>
          member.name.toLowerCase().contains(query.toLowerCase())
      ).toList();
    });
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
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: _toggleInfoVisibility,
          child: const Icon(CupertinoIcons.info),
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    if (isMembersVisible) ...[
                      CupertinoTextField(
                        controller: searchController,
                        placeholder: 'Search Members...',
                        padding: const EdgeInsets.all(10),
                        onChanged: _filterMembers,
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: ListView(
                          children: filteredMembers.map((member) {
                            return CupertinoButton(
                              onPressed: () => _selectMember(member),
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
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 20),
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
                        'Address: ${selectedMember!.address}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Number: ${selectedMember!.number}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Age: ${selectedMember!.age}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              if (isInfoVisible)
                Container(
                  width: 200,
                  padding: const EdgeInsets.all(10),
                  color: CupertinoColors.systemGrey5,
                  child: Column(
                    children: members.map((member) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          children: [
                            ClipOval(
                              child: Image.asset(
                                member.imagePath,
                                width: 40,
                                height: 40,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(member.name, style: const TextStyle(fontSize: 14)),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}