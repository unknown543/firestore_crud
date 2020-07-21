import 'package:flutter/foundation.dart';
import '../repo/repo.dart';

class FirebaseProvider with ChangeNotifier {
  String nameMessage;
  String pohoneMessage;
  String name;
  final _repo = Repository();

  void nameValidation({String data}) {
    nameMessage = _repo.nameValidation(data: data);
    notifyListeners();
  }

  void phoneValidation({String data}) {
    pohoneMessage = _repo.phoneValidation(no: data);
    notifyListeners();
  }

  set setName(String names) {
    name = names;
    notifyListeners();
  }

  String get getName => name;
}
