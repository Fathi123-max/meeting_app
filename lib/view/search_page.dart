import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

import '../model/meeting_model.dart';

class CreateMeetingScreen extends StatefulWidget {
  const CreateMeetingScreen({Key? key}) : super(key: key);

  @override
  _CreateMeetingScreenState createState() => _CreateMeetingScreenState();
}

class _CreateMeetingScreenState extends State<CreateMeetingScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _attendeesController = TextEditingController();
  final TextEditingController _agendaController = TextEditingController();
  DateTime _dateTime = DateTime.now();
  int _duration = 30;
  List<String> _attendees = [];

  void _showDateTimePicker() {
    DatePicker.showDateTimePicker(
      context,
      showTitleActions: true,
      minTime: DateTime.now(),
      onChanged: (dateTime) {
        setState(() {
          _dateTime = dateTime;
        });
      },
      onConfirm: (dateTime) {
        setState(() {
          _dateTime = dateTime;
        });
      },
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _attendeesController.dispose();
    _agendaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Stack(
        children: [
          Positioned(
            bottom: 70.0,
            right: 20.0,
            child: FloatingActionButton(
              onPressed: () {
                final meeting = Meeting(
                  title: _titleController.text,
                  dateTime: _dateTime,
                  duration: _duration,
                  attendees: _attendees,
                  agenda: _agendaController.text,
                );
                // TODO: Save the meeting to the database or send it to the server.
                // Navigator.pop(context, meeting);
              },
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
      appBar: AppBar(
        title: const Text('Create Meeting'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: _showDateTimePicker,
              child: Row(
                children: [
                  const Icon(Icons.calendar_today),
                  const SizedBox(width: 10),
                  Text(_dateTime.toString()),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Icon(Icons.access_time),
                const SizedBox(width: 10),
                const Text('Duration'),
                const SizedBox(width: 20),
                DropdownButton<int>(
                  value: _duration,
                  onChanged: (value) {
                    setState(() {
                      _duration = value!;
                    });
                  },
                  items: List.generate(
                    12,
                    (index) => DropdownMenuItem(
                      value: (index + 1) * 30,
                      child: Text('${(index + 1) * 30} minutes'),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _attendeesController,
              decoration: const InputDecoration(
                labelText: 'Attendees (separated by commas)',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _attendees = value.split(',').map((e) => e.trim()).toList();
                });
              },
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _agendaController,
              decoration: const InputDecoration(
                labelText: 'Agenda',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
          ],
        ),
      ),
    );
  }
}
