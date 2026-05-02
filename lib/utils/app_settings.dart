import 'package:flutter/foundation.dart';

class AppSettings {
  static final ValueNotifier<double> fontScale = ValueNotifier<double>(1.0);

  static const double minScale = 0.85;
  static const double maxScale = 1.60;
  static const double step = 0.05;
}
