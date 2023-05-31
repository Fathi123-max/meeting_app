import '../model/meeting_model.dart';

class Users {
  static final List<Map<String, dynamic>> users = [
    {
      'name': 'John Doe',
      'image': 'https://i.pravatar.cc/150?img=1',
      'status': 'Online',
      'language': 'English',
      'about': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      'interests': ['Coding', 'Reading', 'Hiking'],
      'availability': {
        'mondayToFriday': '9:00 AM - 5:00 PM',
        'saturdayToSunday': 'Not available',
      },
      'email': 'johndoe@example.com',
      'phone': '+1 (555) 555-1234',
    },
    {
      'name': 'Jane Smith',
      'image': 'https://i.pravatar.cc/150?img=2',
      'status': 'Offline',
      'language': 'Spanish',
      'about': 'Nulla ac turpis eget massa aliquet egestas.',
      'interests': ['Cooking', 'Traveling', 'Photography'],
      'availability': {
        'mondayToFriday': '8:00 AM - 4:00 PM',
        'saturdayToSunday': '12:00 PM - 6:00 PM',
      },
      'email': 'janesmith@example.com',
      'phone': '+1 (555) 555-5678',
    },
    {
      'name': 'Michael Brown',
      'image': 'https://i.pravatar.cc/150?img=3',
      'status': 'Online',
      'language': 'French',
      'about': 'Proin vel enim vel felis commodo commodo.',
      'interests': ['Music', 'Gaming', 'Swimming'],
      'availability': {
        'mondayToFriday': '10:00 AM - 6:00 PM',
        'saturdayToSunday': '10:00 AM - 4:00 PM',
      },
      'email': 'michaelbrown@example.com',
      'phone': '+1 (555) 555-9012',
    },
  ];

  static final List<Map<String, dynamic>> meetings = [
    {
      'title': 'Project status meeting',
      'dateTime': DateTime(2022, 6, 1, 10, 0),
      'duration': 60,
      'attendees': ['John Doe', 'Jane Smith', 'Bob Johnson'],
      'agenda': 'Review progress and plan next steps',
    },
    {
      'title': 'Sales team meeting',
      'dateTime': DateTime(2022, 6, 3, 14, 30),
      'duration': 30,
      'attendees': ['Alice Brown', 'Charlie Davis', 'Eve Green'],
      'agenda': 'Discuss new leads and sales targets',
    },
    {
      'title': 'Design review meeting',
      'dateTime': DateTime(2022, 6, 7, 16, 0),
      'duration': 90,
      'attendees': ['Mike Lee', 'Sara Kim', 'Tom Chen'],
      'agenda': 'Evaluate design proposals and provide feedback',
    },
  ];

  static final List<Meeting> meetingsList = [
    Meeting(
      title: 'Project status meeting',
      dateTime: DateTime(2022, 6, 1, 10, 0),
      duration: 60,
      attendees: ['John Doe', 'Jane Smith', 'Bob Johnson'],
      agenda: 'Review progress and plan next steps',
      id: '',
    ),
    Meeting(
      title: 'Sales team meeting',
      dateTime: DateTime(2022, 6, 3, 14, 30),
      duration: 30,
      attendees: ['Alice Brown', 'Charlie Davis', 'Eve Green'],
      agenda: 'Discuss new leads and sales targets',
      id: '',
    ),
    Meeting(
      title: 'Design review meeting',
      dateTime: DateTime(2022, 6, 7, 16, 0),
      duration: 90,
      attendees: ['Mike Lee', 'Sara Kim', 'Tom Chen'],
      agenda: 'Evaluate design proposals and provide feedback',
      id: '',
    ),
  ];
}
