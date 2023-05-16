part of 'index.dart';

class CategoryContainer extends StatelessWidget {
  const CategoryContainer({
    super.key,
    required this.builder,
  });

  final ViewModelBuilder<List<Category>> builder;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<ProductState, List<Category>>(
      converter: (Store<ProductState> store) => store.state.categories,
      builder: builder,
    );
  }
}
