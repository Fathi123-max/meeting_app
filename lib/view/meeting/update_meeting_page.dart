import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controller/firbase_meeting_controller.dart';
import '../../model/meeting_model.dart';

class UpdateMeetingScreen extends StatefulWidget {
  final Meeting meeting;

  const UpdateMeetingScreen({Key? key, required this.meeting})
      : super(key: key);

  @override
  _UpdateMeetingScreenState createState() => _UpdateMeetingScreenState();
}

class _UpdateMeetingScreenState extends State<UpdateMeetingScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _agendaController = TextEditingController();
  late DateTime _dateTime;
  late int _duration;
  late List<String> _attendees;
  final MeetingController meetingService =
      Get.put<MeetingController>(MeetingController());

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.meeting.title;
    _agendaController.text = widget.meeting.agenda;
    _dateTime = widget.meeting.dateTime;
    _duration = widget.meeting.duration;
    _attendees = List.from(widget.meeting.attendees);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              // TODO: Add logic to delete the meeting from the database or server.
              await meetingService.deleteMeeting(_dateTime.toString());
              setState(() {});
              Navigator.pop(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              final meeting = Meeting(
                title: _titleController.text,
                dateTime: _dateTime,
                duration: _duration,
                attendees: _attendees,
                agenda: _agendaController.text,
                id: _dateTime.toString(),
              );
              // TODO: Add logic to update the meeting in the database or server.
              Navigator.pop(context, meeting);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Meeting Details',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: _dateTime,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                );
                if (date != null) {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.fromDateTime(_dateTime),
                  );
                  if (time != null) {
                    setState(() {
                      _dateTime = DateTime(
                        date.year,
                        date.month,
                        date.day,
                        time.hour,
                        time.minute,
                      );
                    });
                  }
                }
              },
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Date and Time',
                  border: OutlineInputBorder(),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        DateFormat.yMd().add_jm().format(_dateTime),
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                    const Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<int>(
              value: _duration,
              onChanged: (value) {
                setState(() {
                  _duration = value!;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Duration',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem<int>(
                  value: 15,
                  child: Text('15 minutes'),
                ),
                DropdownMenuItem<int>(
                  value: 30,
                  child: Text('30 minutes'),
                ),
                DropdownMenuItem<int>(
                  value: 60,
                  child: Text('1 hour'),
                ),
                DropdownMenuItem<int>(
                  value: 90,
                  child: Text('1 hour 30 minutes'),
                ),
                DropdownMenuItem<int>(
                  value: 120,
                  child: Text('2 hours'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Attendees',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _attendees.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_attendees[index]),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        _attendees.removeAt(index);
                      });
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newAttendee = await showDialog<String>(
            context: context,
            builder: (context) {
              final TextEditingController controller = TextEditingController();
              return AlertDialog(
                title: const Text('Add Attendee'),
                content: TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      if (controller.text.isNotEmpty) {
                        setState(() {
                          _attendees.add(controller.text);
                        });
                        Navigator.pop(context, controller.text);
                      }
                    },
                    child: const Text('Add'),
                  ),
                ],
              );
            },
          );
          if (newAttendee != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('$newAttendee added.'),
              ),
            );
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
