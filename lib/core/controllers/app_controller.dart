import 'package:flutter/widgets.dart';

import '../init/routes/routes.dart';

class AppController extends ChangeNotifier {
  int pageIndex = RouteEnums.home.routeIndex;
  void changePageIndex(int index) {
    pageIndex = index;
    notifyListeners();
  }


}
