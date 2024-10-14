import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/core/firebase_utils.dart';
import 'package:todo_app/features/auth/manager/auth_cubit/auth_cubit.dart';
import 'package:todo_app/models/task_model.dart';

class AddTaskBottomSheetWidget extends StatefulWidget {
  const AddTaskBottomSheetWidget({super.key});

  @override
  State<AddTaskBottomSheetWidget> createState() =>
      _AddTaskBottomSheetWidgetState();
}

class _AddTaskBottomSheetWidgetState extends State<AddTaskBottomSheetWidget> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var provider = BlocProvider.of<AuthCubit>(context);
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Form(
        key: formkey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                "add_new_task".tr(), // Localized text
                style: theme.textTheme.bodyLarge!.copyWith(color: Colors.black),
              ),
            ),
            const SizedBox(height: 40),
            TextFormField(
              controller: _titleController,
              style: theme.textTheme.bodyMedium!.copyWith(color: Colors.black),
              decoration: InputDecoration(
                hintText: 'enter_your_task'.tr(), // Localized text
                hintStyle:
                    theme.textTheme.bodySmall!.copyWith(color: Colors.black),
                labelText: 'task_name'.tr(), // Localized text
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'required_field'.tr(); // Localized text
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _descriptionController,
              maxLines: 3,
              style: theme.textTheme.bodyMedium!.copyWith(color: Colors.black),
              decoration: InputDecoration(
                hintText: 'enter_task_description'.tr(),
                hintStyle:
                    theme.textTheme.bodySmall!.copyWith(color: Colors.black),
                labelText: 'task_description'.tr(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'required_field'.tr();
                }
                return null;
              },
            ),
            const SizedBox(height: 40),
            Text(
              'select_time'.tr(), // Localized text
              style: theme.textTheme.bodyLarge!.copyWith(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: InkWell(
                onTap: () {
                  getSelectedDate();
                },
                child: Text(
                  DateFormat("dd/MM/yyyy").format(selectedDate),
                  style: theme.textTheme.bodyLarge!.copyWith(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const Spacer(),
            FilledButton(
              onPressed: () {
                if (formkey.currentState!.validate()) {
                  var taskModel = TaskModel(
                      id: null,
                      title: _titleController.text,
                      description: _descriptionController.text,
                      selectedDate: selectedDate);
                  EasyLoading.show();
                  FirebaseUtils()
                      .addTaskToFirestore(
                          taskModel: taskModel,
                          collectionName: provider.getUserUid!)
                      .then((value) {
                    Navigator.pop(context);
                    EasyLoading.dismiss();
                  });
                }
              },
              style: FilledButton.styleFrom(
                backgroundColor: theme.primaryColor,
              ),
              child: Text(
                'save'.tr(), // Localized text
                style: theme.textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }

  getSelectedDate() async {
    var currentDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 365),
      ),
    );
    if (currentDate != null) {
      setState(() {
        selectedDate = currentDate;
      });
    }
  }
}
