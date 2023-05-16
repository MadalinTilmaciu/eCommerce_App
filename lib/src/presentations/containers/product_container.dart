part of 'index.dart';

class ProductContainer extends StatelessWidget {
  const ProductContainer({
    super.key,
    required this.builder,
  });

  final ViewModelBuilder<List<Product>> builder;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, List<Product>>(
      converter: (Store<AppState> store) => store.state.products.products,
      builder: builder,
    );
  }
}
