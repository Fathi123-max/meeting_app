import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:quran_lang_test/model/meeting_model.dart';
import 'package:quran_lang_test/view/meeting/create_meeting_page.dart';
import 'package:quran_lang_test/view/meeting/update_meeting_page.dart';

import '../../controller/firbase_meeting_controller.dart';

class MeetingsScreen extends StatefulWidget {
  const MeetingsScreen({
    Key? key,
  }) : super(key: key);

  @override
  _MeetingsScreenState createState() => _MeetingsScreenState();
}

class _MeetingsScreenState extends State<MeetingsScreen> {
  late List<Meeting> _filteredMeetings;
  final TextEditingController _searchController = TextEditingController();
  final MeetingController meetingService =
      Get.put<MeetingController>(MeetingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meetings'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Get.to(() => const CreateMeetingScreen());
              // logic to navigate to screen for adding a new meeting
            },
          ),
        ],
      ),
      body: Obx(() {
        _filteredMeetings = meetingService.meetings;
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'Search meetings',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                onChanged: (query) {
                  setState(() {
                    _filteredMeetings =
                        meetingService.meetings.where((meeting) {
                      return meeting.title
                          .toLowerCase()
                          .contains(query.toLowerCase());
                    }).toList();
                  });
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredMeetings.length,
                itemBuilder: (context, index) {
                  final meeting = _filteredMeetings[index];
                  return ListTile(
                    title: Text(
                      meeting.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            const Icon(Icons.calendar_today_outlined, size: 18),
                            const SizedBox(width: 5),
                            Text(
                              DateFormat.yMMMMd().format(meeting.dateTime),
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            const Icon(Icons.access_time_outlined, size: 18),
                            const SizedBox(width: 5),
                            Text(
                              '${meeting.duration} minutes',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            const Icon(Icons.people_outline, size: 18),
                            const SizedBox(width: 5),
                            Text(
                              meeting.attendees.sublist(0, 2).join(', '),
                              style: const TextStyle(fontSize: 16),
                            ),
                            if (meeting.attendees.length > 2) ...[
                              const SizedBox(width: 5),
                              InkWell(
                                onTap: () {
                                  // TODO: Add logic to show all attendees
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey[300],
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.add, size: 14),
                                      Text(
                                        '${meeting.attendees.length - 2}',
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      Get.to(() => UpdateMeetingScreen(meeting: meeting));
                      // TODO: Add logic to navigate to the meeting details screen
                    },
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
