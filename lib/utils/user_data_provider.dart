import 'package:flutter/material.dart';

import 'user_data.dart';

class DataUserProvider extends InheritedWidget {
  final DataUser data;
  const DataUserProvider({super.key, required this.data, required Widget child})
      : super(child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }

  static DataUserProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<DataUserProvider>()!;
  }
}
