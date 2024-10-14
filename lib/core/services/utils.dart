import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

DateTime extractDate({required DateTime selectedDateTime}) {
  return DateTime(
    selectedDateTime.year,
    selectedDateTime.month,
    selectedDateTime.day,
  );
}

pickImages({required ImageSource source}) async {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _file = await _imagePicker.pickImage(source: source);
  if (_file != null) {
    return _file.readAsBytes();
  }
  print("no image selected");
}
