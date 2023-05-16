part of 'index.dart';

class ProductContainer extends StatelessWidget {
  const ProductContainer({
    super.key,
    required this.builder,
  });

  final ViewModelBuilder<List<Product>> builder;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<ProductState, List<Product>>(
      converter: (Store<ProductState> store) => store.state.products,
      builder: builder,
    );
  }
}
