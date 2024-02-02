import 'package:taverns/domain/model/db_models.dart';

import 'compendium_initial_params.dart';

class CompendiumState {
  final List<Compendium> compendiums;
  final List<Category> categories;
  final List<SubCategory> subCategories;
  final bool isloading;

  const CompendiumState({
    required this.categories,
    required this.compendiums,
    required this.isloading,
    required this.subCategories,
  });

  factory CompendiumState.initial(
          {required CompendiumInitialParams initialParams}) =>
      CompendiumState(
        categories: [],
        compendiums: [],
        isloading: true,
        subCategories: [],
      );

  CompendiumState copyWith({
    List<Compendium>? compendiums,
    List<Category>? categories,
    List<SubCategory>? subCategories,
    bool? isloading,
  }) =>
      CompendiumState(
        compendiums: compendiums ?? this.compendiums,
        categories: categories ?? this.categories,
        isloading: isloading ?? this.isloading,
        subCategories: subCategories ?? this.subCategories,
      );
}
