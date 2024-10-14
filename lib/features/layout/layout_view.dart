import 'package:flutter/material.dart';
import 'package:todo_app/features/settings/settings_view.dart';
import 'package:todo_app/features/tasks/task_view.dart';
import 'package:todo_app/features/tasks/widget/add_task_bottom_sheet_widget.dart';
import 'package:easy_localization/easy_localization.dart';

class LayoutView extends StatefulWidget {
  const LayoutView({super.key});

  @override
  State<LayoutView> createState() => _LayoutViewState();
}

class _LayoutViewState extends State<LayoutView> {
  int currentIndex = 0;
  List<Widget> screenList = [
    const TaskView(),
    SettingsView(),
  ];

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        elevation: 2,
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) => AddTaskBottomSheetWidget());
        },
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        child: CircleAvatar(
          radius: 24,
          backgroundColor: theme.primaryColor,
          child: const Icon(
            Icons.add,
            size: 32,
            color: Colors.white,
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        height: 89,
        notchMargin: 12,
        padding: EdgeInsets.zero,
        shape: const CircularNotchedRectangle(),
        child: BottomNavigationBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          currentIndex: currentIndex,
          onTap: (value) {
            setState(() {
              currentIndex = value;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: const ImageIcon(
                AssetImage('assets/icons/task_icn.png'),
              ),
              label: "tasks".tr(),
            ),
            BottomNavigationBarItem(
              icon: const ImageIcon(
                AssetImage('assets/icons/settings_icn.png'),
              ),
              label: 'settings'.tr(),
            ),
          ],
        ),
      ),
      body: screenList[currentIndex],
    );
  }
}
