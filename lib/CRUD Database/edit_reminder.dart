import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_learn/CRUD%20Database/home.dart';
import 'package:firebase_learn/Utils%20and%20Widgets/round_button.dart';
import 'package:firebase_learn/Utils%20and%20Widgets/utils.dart';
import 'package:flutter/material.dart';

class EditReminderPage extends StatefulWidget {
  String id;
  String oldTitle;
  String OldDescription;
  EditReminderPage({
    super.key,
    required this.id,
    required this.oldTitle,
    required this.OldDescription,
  });

  @override
  State<EditReminderPage> createState() => _EditReminderPageState();
}

class _EditReminderPageState extends State<EditReminderPage> {
  DateTime dateTime = DateTime(2022, 09, 09, 3, 19);

  bool loading = false;

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  final databaseref = FirebaseDatabase.instance.ref('Post');

  @override
  Widget build(BuildContext context) {
    final hours = dateTime.hour.toString().padLeft(2, '0');
    final minutes = dateTime.minute.toString().padLeft(2, '0');

    // For moving old title and descriptions into Edit Page:
    titleController.text = widget.oldTitle;
    descriptionController.text = widget.OldDescription;

    // loading:
    bool loading = false;

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'EDIT REMINDER +',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFF2796B),
                  ),
                ),
                SizedBox(height: 25),
                Text(
                  "Enter Title:",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 25),
                Text(
                  "Enter Description:",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  maxLength: 200, // Num of Words in TextField
                  textInputAction: TextInputAction.newline,
                  maxLines: 4,
                ),
                SizedBox(height: 25),
                Text(
                  "Select Date and Time:",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          final date = await pickDate();
                          if (date == null) return; // cancel pressed

                          final newDateTime = DateTime(
                            date.year,
                            date.month,
                            date.day,
                            dateTime.hour,
                            dateTime.minute,
                          ); // On changing the date, Time will be preserved

                          setState(() {
                            dateTime = newDateTime; //OK Pressed
                          });
                        },
                        child: Text(
                            '${dateTime.year}/${dateTime.month}/${dateTime.day}'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFF2796B),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          final time = await pickTime();
                          if (time == null) return; // Cancel Pressed

                          final newDateTime = DateTime(
                            dateTime.year,
                            dateTime.month,
                            dateTime.day,
                            time.hour,
                            time.minute,
                          ); // On changing the time , Date will be preserved

                          setState(() {
                            dateTime = newDateTime;
                          });
                        },
                        child: Text('$hours:$minutes'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFF2796B),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 25),
                Row(
                  children: [
                    Expanded(
                      child: RoundButton(
                        title: 'Cancel',
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => HomePage()));

                          Navigator.pop(context);
                        },
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: RoundButton(
                        title: 'Edit Reminder',
                        onTap: () {
                          setState(() {
                            loading = true;
                          });
                          // Firebase Update Coding:
                          databaseref.child(widget.id).update({
                            'title': titleController.text.toString(),
                            'description':
                                descriptionController.text.toString(),
                            'dateTime': dateTime.toString(),
                          }).then((value) {
                            setState(() {
                              loading = false;
                            });

                            Utils()
                                .toastMessage('Reminder Edited Successfully');

                            Navigator.pop(context);
                          }).onError((error, stackTrace) {
                            Utils().toastMessage(error.toString());

                            setState(() {
                              loading = false;
                            });
                          });
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<DateTime?> pickDate() => showDatePicker(
        context: context,
        initialDate: dateTime,
        firstDate: DateTime(2022),
        lastDate: DateTime(2024),
      );

  Future<TimeOfDay?> pickTime() => showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: dateTime.hour, minute: dateTime.minute),
      );
}
