import 'package:flutter/widgets.dart';

// Set if it is busy or not
// DK
class BaseModel extends ChangeNotifier {
  bool _busy = false;
  bool get busy => _busy;

  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }
}
