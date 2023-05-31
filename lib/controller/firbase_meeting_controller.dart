import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../model/meeting_model.dart';

class MeetingController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addMeeting(Meeting meeting) async {
    final Map<String, dynamic> meetingData = meeting.toMap();
    await firestore.collection('meetings').add(meetingData);
  }

  Future<List<Meeting>> getAllMeetings() async {
    final QuerySnapshot snapshot = await firestore.collection('meetings').get();
    final List<Meeting> meetings = snapshot.docs
        .map((doc) => Meeting.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
    return meetings;
  }

  Future<Meeting?> getMeetingById(String id) async {
    final DocumentSnapshot snapshot =
        await firestore.collection('meetings').doc(id).get();
    if (snapshot.exists) {
      final meetingData = snapshot.data() as Map<String, dynamic>;
      return Meeting.fromMap(meetingData);
    } else {
      return null;
    }
  }

  Future<void> updateMeeting(Meeting meeting) async {
    final Map<String, dynamic> meetingData = meeting.toMap();
    await firestore.collection('meetings').doc(meeting.id).update(meetingData);
  }

  Future<void> deleteMeeting(String id) async {
    await firestore.collection('meetings').doc(id).delete();
  }
}
