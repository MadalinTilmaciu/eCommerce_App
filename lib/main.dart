import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';

import 'firebase_options.dart';
import 'src/actions/index.dart';
import 'src/data/auth_api.dart';
import 'src/data/products_api.dart';
import 'src/epics/app_epics.dart';
import 'src/epics/auth_epics.dart';
import 'src/epics/products_epics.dart';
import 'src/models/index.dart';
import 'src/presentations/containers/index.dart';
import 'src/presentations/create_user_page.dart';
import 'src/presentations/home_page.dart';
import 'src/presentations/login_page.dart';
import 'src/reducer/reducer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final AuthApi authApi = AuthApi(FirebaseAuth.instance);
  final AuthEpics auth = AuthEpics(authApi);
  final ProductApi productsApi = ProductApi(FirebaseFirestore.instance);
  final ProductsEpics products = ProductsEpics(productsApi);
  final AppEpics epic = AppEpics(auth, products);

  final Store<AppState> store = Store<AppState>(
    reducer,
    initialState: const AppState(),
    middleware: <Middleware<AppState>>[
      EpicMiddleware<AppState>(epic.call).call,
    ],
  );

  store.dispatch(const CheckUser());

  runApp(
    MyApp(
      store: store,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.store,
  });

  final Store<AppState> store;

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'eCommerceApp',
        theme: ThemeData.dark(),
        routes: <String, WidgetBuilder>{
          '/': (BuildContext context) {
            return UserContainer(
              builder: (BuildContext context, AppUser? user) {
                if (user == null) {
                  return const LoginPage();
                } else {
                  return const HomePage();
                }
              },
            );
          },
          '/login': (BuildContext context) => const LoginPage(),
          '/createUser': (BuildContext context) => const CreateUserPage(),
        },
      ),
    );
  }
}
