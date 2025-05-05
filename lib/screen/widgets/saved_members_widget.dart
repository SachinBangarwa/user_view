import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_view/provider/user_provider.dart';

import '../../core/app_strings.dart';

class SavedMembersWidget extends StatefulWidget {
  const SavedMembersWidget({super.key});

  @override
  State<SavedMembersWidget> createState() => _SavedMembersWidgetState();
}

class _SavedMembersWidgetState extends State<SavedMembersWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<UserProvider>(
        builder: (context, provider, child) {
          if (provider.saveUserList.isEmpty) {
            return const Center(
              child: Text(
                AppStrings.noSavedUsers,
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }
          return ListView.builder(
            itemCount: provider.saveUserList.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> data = provider.saveUserList[index];
              return Card(
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      width: 65,
                      height: 70,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Image.network(
                        data['image'],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: Text(
                    '${data['firstName']} ${data['lastName']}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(data['email']),
                  trailing: IconButton(
                    onPressed: () async {
                      await _buildRemoveTab(provider, index);
                    },
                    icon: const Icon(Icons.cancel_outlined),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _buildRemoveTab(UserProvider provider, int index) async {
     provider.selectedUsers
        .remove(provider.saveUserList[index]['email']);
    provider.saveUserList.removeAt(index);
    await provider.saveUser();
    await provider.getUser();
  }
}
