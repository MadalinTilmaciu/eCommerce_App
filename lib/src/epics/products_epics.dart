// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/transformers.dart';

import '../actions/index.dart';
import '../data/products_api.dart';
import '../models/index.dart';

class ProductsEpics implements EpicClass<AppState> {
  ProductsEpics(this._api);

  final ProductApi _api;

  @override
  Stream<dynamic> call(Stream<dynamic> actions, EpicStore<AppState> store) {
    return combineEpics(
      <Epic<AppState>>[
        TypedEpic<AppState, ListCategoryStart>(_listCategoryStart).call,
        TypedEpic<AppState, ListProductsStart>(_listProductStart).call,
        TypedEpic<AppState, ListVendorsStart>(_listVendorStart).call,
      ],
    )(actions, store);
  }

  Stream<dynamic> _listCategoryStart(Stream<ListCategoryStart> actions, EpicStore<AppState> store) {
    return actions.flatMap(
      (ListCategoryStart action) {
        return Stream<void>.value(null)
            .asyncMap((_) => _api.listCategory()) //
            .expand(
          (List<Category> categories) {
            final List<Category> list = categories..sort();

            return <dynamic>[
              ListCategory.successful(list),
              ListProducts.start(list.first.id),
            ];
          },
        ).onErrorReturnWith(
          (Object error, StackTrace stackTrace) {
            ListCategory.error(error, stackTrace);
          },
        );
      },
    );
  }

  Stream<dynamic> _listProductStart(Stream<ListProductsStart> actions, EpicStore<AppState> store) {
    return actions.flatMap(
      (ListProductsStart action) {
        return Stream<void>.value(null)
            .asyncMap((_) => _api.listProduct(action.categoryId))
            .expand((List<Product> products) {
          final List<String> vendorIds = products
              .map((Product product) => product.vendorId)
              .toSet()
              .where((String vendorId) => store.state.products.vendors.none((Vendor vendor) => vendor.id == vendorId))
              .toList();

          return <dynamic>[
            ListVendors.start(vendorIds),
            ListProducts.successful(products),
          ];
        }).onErrorReturnWith((Object error, StackTrace stackTrace) => ListProducts.error(error, stackTrace));
      },
    );
  }

  Stream<dynamic> _listVendorStart(Stream<ListVendorsStart> actions, EpicStore<AppState> store) {
    return actions.flatMap(
      (ListVendorsStart action) {
        return Stream<void>.value(null)
            .asyncMap((_) => _api.listVendors(action.vendorIds)) //
            .map((List<Vendor> vendors) => ListVendors.successful(vendors))
            .onErrorReturnWith((Object error, StackTrace stackTrace) => ListVendors.error(error, stackTrace));
      },
    );
  }
}
