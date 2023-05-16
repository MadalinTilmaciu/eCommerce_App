import 'package:redux/redux.dart';

import '../actions/index.dart';
import '../models/index.dart';

Reducer<ProductState> productsReducer = combineReducers(
  <Reducer<ProductState>>[
    TypedReducer<ProductState, ListCategorySuccessful>(_listCategorySuccessful).call,
    TypedReducer<ProductState, SetCategory>(_setCategory).call,
    TypedReducer<ProductState, ListProductsSuccessful>(_listProductsSuccessful).call,
  ],
);

ProductState _listCategorySuccessful(ProductState state, ListCategorySuccessful action) {
  return state.copyWith(categories: action.categories, selectedCategoryId: action.categories.first.id);
}

ProductState _setCategory(ProductState state, SetCategory action) {
  return state.copyWith(selectedCategoryId: action.categoryId);
}

ProductState _listProductsSuccessful(ProductState state, ListProductsSuccessful action) {
  return state.copyWith(products: action.products);
}
