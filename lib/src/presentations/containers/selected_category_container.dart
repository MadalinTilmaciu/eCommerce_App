part of 'index.dart';

class SelectedCategoryContainer extends StatelessWidget {
  const SelectedCategoryContainer({
    super.key,
    required this.builder,
  });

  final ViewModelBuilder<Category> builder;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<ProductState, Category>(
      converter: (Store<ProductState> store) => store.state.categories.firstWhere(
        (Category category) => category.id == store.state.selectedCategoryId,
      ),
      builder: builder,
    );
  }
}
