import 'dart:typed_data';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_app/core/services/utils.dart';
import 'package:todo_app/features/settings/manager/localization_cubit/localization_cubit.dart';
import 'package:todo_app/features/settings/manager/theme_cubit/theme_cubit.dart';
import 'package:easy_localization/easy_localization.dart';

class SettingsView extends StatefulWidget {
  SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final List<String> items = [
    'English',
    'Arabic',
    'Russian',
    'French',
  ];
  bool isDark = false;
  String? selectedValue;
  Uint8List? _image;
  @override
  Widget build(BuildContext context) {
    var themeProvider = BlocProvider.of<ThemeCubit>(context);
    var localizationProvider = BlocProvider.of<LocalizationCubit>(context);
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.primaryColor,
        title: Text(
          'settings'.tr(),
          style: theme.textTheme.bodyLarge,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 50),
          Stack(
            children: [
              _image != null
                  ? CircleAvatar(
                      radius: 64, backgroundImage: MemoryImage(_image!))
                  : const CircleAvatar(
                      radius: 64,
                      backgroundImage: NetworkImage(
                          'https://www.strasys.uk/wp-content/uploads/2022/02/Depositphotos_484354208_S.jpg'),
                    ),
              Positioned(
                bottom: -10,
                left: 85,
                child: IconButton(
                  onPressed: selectImage,
                  icon: const Icon(Icons.add_a_photo),
                ),
              )
            ],
          ),
          Text(
            'Mohamed Ahmed',
            style: theme.textTheme.bodyLarge!.copyWith(
              color: Colors.black,
            ),
          ),
          const Divider(
            indent: 40,
            endIndent: 40,
            thickness: 0.4,
            color: Colors.black,
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FittedBox(
                      child: Text(
                        'choose_theme'.tr(),
                        style: theme.textTheme.bodyMedium!.copyWith(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Transform.scale(
                      scale: 1.5,
                      child: Switch(
                        inactiveThumbImage:
                            Image.asset('assets/images/sun.png').image,
                        inactiveThumbColor: Colors.transparent,
                        inactiveTrackColor: Colors.orangeAccent,
                        activeThumbImage:
                            Image.asset('assets/images/moon.png').image,
                        hoverColor: const Color.fromARGB(255, 87, 83, 82)
                            .withOpacity(0.4),
                        value: isDark,
                        onChanged: (value) {
                          setState(() {
                            isDark = value;
                          });

                          themeProvider.changeTheme(isDark: isDark);
                        },
                        activeTrackColor: const Color(0xFF848B9B),
                        activeColor: const Color.fromARGB(255, 223, 222, 221),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(
            indent: 40,
            endIndent: 40,
            thickness: 0.4,
            color: Colors.black,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FittedBox(
                child: Text(
                  'select_language'.tr(),
                  style: theme.textTheme.bodyMedium!.copyWith(
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      hint: Text('select_language'.tr()),
                      items: items
                          .map((String item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ))
                          .toList(),
                      value: selectedValue,
                      onChanged: (value) {
                        setState(() {
                          selectedValue = value;
                          localizationProvider.changeLanguage(
                              languageCode: selectedValue, context: context);
                        });
                      },
                      buttonStyleData: ButtonStyleData(
                        height: 50,
                        width: 180,
                        padding: const EdgeInsets.only(left: 14, right: 14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: Colors.black26,
                          ),
                          color: theme.primaryColor,
                        ),
                        elevation: 2,
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        height: 40,
                        padding: EdgeInsets.only(left: 14, right: 14),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Divider(
            indent: 40,
            endIndent: 40,
            thickness: 0.4,
            color: Colors.black,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                backgroundColor: theme.primaryColor,
                overlayColor: const Color.fromARGB(255, 151, 194, 250),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                )),
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Logout".tr(),
                  style: theme.textTheme.bodyLarge,
                ),
                const Icon(
                  Icons.double_arrow_rounded,
                  size: 30,
                  color: Colors.white,
                )
              ],
            ),
          ),
          SizedBox(height: 120),
        ],
      ),
    );
  }

  void selectImage() async {
    Uint8List img = await pickImages(source: ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }
}
