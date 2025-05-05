import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_view/core/app_colors.dart';
import 'package:user_view/model/user_detail_model.dart';
import 'package:user_view/provider/user_provider.dart';

class AllMembersWidget extends StatelessWidget {
  const AllMembersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<UserProvider>(builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.builder(
            itemCount: provider.userList.length,
            itemBuilder: (context, index) {
              UserDetailModel userData = provider.userList[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
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
                        userData.avatar,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: Text(
                    '${userData.firstName} ${userData.lastName}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(userData.email),
                  trailing: IconButton(
                    onPressed: () async {
                      await _buildSaveUserTab(provider, userData);
                    },
                    icon: Icon(
                      Icons.favorite,
                      color: provider.selectedUsers[userData.email] == true
                          ? AppColors.favoriteRed
                          : AppColors.favoriteUnselected,
                    ),
                  ),
                ),
              );
            },
          );
        }
      }),
    );
  }

  Future<void> _buildSaveUserTab(
      UserProvider provider, UserDetailModel userData) async {
    provider.toggleUserSelection(userData.email);
    bool alreadySaved =
        provider.saveUserList.any((u) => u['email'] == userData.email);

    if (!alreadySaved) {
      Map<String, dynamic> json = {
        'email': userData.email,
        'firstName': userData.firstName,
        'lastName': userData.lastName,
        'image': userData.avatar,
        'done': false,
      };
      provider.saveUserList.add(json);
    } else {
      provider.saveUserList
          .removeWhere((value) => value['email'] == userData.email);
    }
    await provider.saveUser();
    await provider.getUser();
  }
}
