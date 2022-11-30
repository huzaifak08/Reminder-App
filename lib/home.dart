import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_learn/create_reminder.dart';
import 'package:firebase_learn/edit_reminder.dart';
import 'package:firebase_learn/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final databaseRef = FirebaseDatabase.instance.ref('Post');

  bool _showFab = true;

  @override
  Widget build(BuildContext context) {
    const duration = Duration(milliseconds: 300);
    print('build');
    return Scaffold(
      body: NotificationListener<UserScrollNotification>(
        onNotification: (notification) {
          final ScrollDirection direction = notification.direction;
          setState(() {
            if (direction == ScrollDirection.reverse) {
              _showFab = false;
            } else if (direction == ScrollDirection.forward) {
              _showFab = true;
            }
          });
          return true;
        },
        child: SafeArea(
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
                            String id = snapshot.child('id').value.toString();
                            String title =
                                snapshot.child('title').value.toString();
                            String description =
                                snapshot.child('description').value.toString();
                            return ListTile(
                              title: Text(
                                title,
                              ),
                              subtitle: Text(
                                description,
                                overflow: TextOverflow.ellipsis,
                              ),
                              leading: CircleAvatar(
                                backgroundImage: AssetImage("assets/bell.png"),
                                backgroundColor: Color(0xFFF2796B),
                              ),
                              trailing: PopupMenuButton(
                                icon: Icon(Icons.more_vert),
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                    value: 1,
                                    child: ListTile(
                                      title: Text('Edit'),
                                      leading: Icon(Icons.edit),
                                      onTap: () {
                                        // This will cancel the Dialog Box:
                                        Navigator.pop(context);

                                        // and will move to next page:
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    EditReminderPage(
                                                      id: id,
                                                      oldTitle: title,
                                                      OldDescription:
                                                          description,
                                                    )));
                                      },
                                    ),
                                  ),
                                  PopupMenuItem(
                                    value: 1,
                                    child: ListTile(
                                      title: Text('Delete'),
                                      leading: Icon(Icons.delete),
                                      onTap: () {
                                        Navigator.pop(context);

                                        // Firebase Delete:
                                        databaseRef.child(id).remove();
                                      },
                                    ),
                                  )
                                ],
                              ),
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
      ),
      floatingActionButton: AnimatedSlide(
        duration: duration,
        offset: _showFab ? Offset.zero : Offset(0, 2),
        child: AnimatedOpacity(
          duration: duration,
          opacity: _showFab ? 1 : 0,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CreateReminderPage()));
            },
            child: Icon(Icons.add),
            backgroundColor: Color(0xFFF2796B),
          ),
        ),
      ),
    );
  }
}
