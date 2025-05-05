import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:user_view/core/app_strings.dart';
import 'package:user_view/screen/widgets/all_members_widget.dart';
import 'package:user_view/screen/widgets/saved_members_widget.dart';
import '../provider/user_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((callBack) {
      fetchUsers();
    });
  }

  Future fetchUsers() async {
    final provider = Provider.of<UserProvider>(context, listen: false);
    await provider.fetchUsers();
    await provider.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 5,
            bottom: const TabBar(
              labelColor: Colors.deepPurple,
              unselectedLabelColor: Colors.grey,
              labelStyle: TextStyle(fontWeight: FontWeight.w600),
              indicatorColor: Colors.deepPurple,
              tabs: [
                Tab(text: AppStrings.allMembers),
                Tab(text: AppStrings.savedMembers),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              AllMembersWidget(),
              SavedMembersWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
