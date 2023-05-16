import 'package:redux_epics/redux_epics.dart';

import '../models/index.dart';
import 'auth_epics.dart';
import 'products_epics.dart';

class AppEpics implements EpicClass<AppState> {
  AppEpics(
    this._auth,
    this._product,
  );

  final AuthEpics _auth;
  final ProductsEpics _product;

  @override
  Stream<dynamic> call(Stream<dynamic> actions, EpicStore<AppState> store) {
    return combineEpics(<Epic<AppState>>[
      _auth.call,
      _product.call,
    ])(actions, store);
  }
}
