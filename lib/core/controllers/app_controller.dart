import 'package:flutter/widgets.dart';
import 'package:photo_editing_app/core/constants/enums.dart';

class AppController extends ChangeNotifier {
  int pageIndex = RouteEnums.home.routeIndex;
  void changePageIndex(int index) {
    pageIndex = index;
    notifyListeners();
  }


}
