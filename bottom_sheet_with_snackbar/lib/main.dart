/*
- An approach how Flutter BottomSheet should works with SnackBars on Flutter.
- Armstrong Lohãns - 2021
- https://github.com/lohhans
*/

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:bottom_sheet_with_snackbar/bottom_sheet_with_snackbar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter BottomSheet With SnackBar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BottomSheetWithSnackBar(),
    );
  }
}
