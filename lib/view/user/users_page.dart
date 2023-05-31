import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_lang_test/view/user/test.adduser.dart';
import 'package:quran_lang_test/view/user/user_screen_page.dart';

import '../../controller/firbase_user_controller.dart';
import '../../model/user_model.dart';

class UsersList extends StatefulWidget {
  UsersList({super.key});

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  late List<User> _filteredMeetings;

  final userController = Get.put<UserController>(UserController());
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () => Get.to(() => const AddUserScreen()),
              child: const Text("add user")),
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search users',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (query) {
                setState(() {
                  _filteredMeetings = userController.user.where((meeting) {
                    return meeting.name
                        .toLowerCase()
                        .contains(query.toLowerCase());
                  }).toList();
                });
              },
            ),
          ),
          Obx(() {
            _filteredMeetings = userController.user;

            return ListView.separated(
              shrinkWrap: true,
              itemCount: _filteredMeetings.length,
              itemBuilder: (BuildContext context, int index) {
                var user = _filteredMeetings[index];
                return GestureDetector(
                  onTap: () => Get.to(() => UserProfileScreen(
                        user: user,
                      )),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage: NetworkImage(user.image),
                          radius: 30,
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                user.name,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(
                                    Icons.circle,
                                    color: user.status == 'Online'
                                        ? Colors.green
                                        : Colors.grey,
                                    size: 12,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    user.status,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.language,
                                    color: Colors.grey,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    user.language,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.calendar_today,
                                    color: Colors.grey,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    user.availability.toString(),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.more_horiz),
                          onPressed: () {
                            // Show options for the user
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Container(
                  height: 20,
                );
              },
            );
          }),
        ],
      ),
    );
  }
}
