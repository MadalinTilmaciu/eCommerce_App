import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../actions/index.dart';
import '../models/index.dart';
import 'containers/index.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return UserContainer(
      builder: (BuildContext context, AppUser? user) {
        return CategoryContainer(
          builder: (BuildContext context, List<Category> categories) {
            return Scaffold(
              appBar: AppBar(
                actions: <Widget>[
                  IconButton(
                    onPressed: () {
                      StoreProvider.of<AppState>(context).dispatch(const LogoutUserStart());
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    icon: const Icon(
                      Icons.logout_rounded,
                    ),
                  ),
                ],
                bottom: categories.isEmpty
                    ? null
                    : PreferredSize(
                        preferredSize: const Size.fromHeight(56),
                        child: SizedBox(
                            height: 56,
                            child: SelectedCategoryContainer(
                              builder: (BuildContext context, Category selectedCategory) {
                                return ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: categories.map(
                                    (Category category) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8),
                                        child: ChoiceChip(
                                          label: Text(category.title),
                                          selected: selectedCategory == category,
                                          onSelected: (bool selected) {
                                            if (selected) {
                                              StoreProvider.of<AppState>(context)
                                                ..dispatch(SetCategory(category.id))
                                                ..dispatch(ListProductsStart(category.id));
                                            }
                                          },
                                        ),
                                      );
                                    },
                                  ).toList(),
                                );
                              },
                            )),
                      ),
              ),
              body: PendingContainer(
                builder: (BuildContext context, Set<String> pending) {
                  if (pending.contains(ListProducts.pendingKey)) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return ProductContainer(
                    builder: (BuildContext context, List<Product> products) {
                      return ListView.separated(
                        itemCount: products.length,
                        itemBuilder: (BuildContext context, int index) {
                          final Product product = products[index];

                          return ListTile(
                            leading: Image.network(
                              product.image,
                              fit: BoxFit.cover,
                              width: 56,
                              height: 56,
                            ),
                            title: Text(product.title),
                            subtitle: Text(product.description),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider();
                        },
                      );
                    },
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
