import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_learn/create_reminder.dart';
import 'package:firebase_learn/firebase_options.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, dynamic> result = {};

  final databaseRef = FirebaseDatabase.instance.ref('Post');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset(
              'assets/think.jpg',
            ),
            Padding(
              padding: const EdgeInsets.only(top: 200),
              child: Container(
                height: double.infinity,
                width: double.infinity,
                // color: Colors.red,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(35),
                  ),
                  color: Color.fromARGB(255, 231, 234, 235),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/bell.png',
                          height: 50,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'REMINDERS',
                          style: TextStyle(
                            fontSize: 35,
                            height: 2,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFF2796B),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: FirebaseAnimatedList(
                        query: databaseRef,
                        defaultChild: Center(
                          child: CircularProgressIndicator(
                            color: Color(0xFFF2796B),
                          ),
                        ),
                        itemBuilder: (context, snapshot, animation, index) {
                          return ListTile(
                            title:
                                Text(snapshot.child('title').value.toString()),
                            subtitle: Text(
                              snapshot.child('description').value.toString(),
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: Text(
                                snapshot.child('dateTime').value.toString()),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CreateReminderPage()));
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xFFF2796B),
      ),
    );
  }
}
