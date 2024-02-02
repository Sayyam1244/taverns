import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taverns/data/db_helper.dart';
import 'package:taverns/domain/model/db_models.dart';
import 'package:taverns/main.dart';
import 'package:taverns/presentation/compendium/compendium_navigator.dart';
import 'compendium_initial_params.dart';
import 'compendium_state.dart';

class CompendiumCubit extends Cubit<CompendiumState> {
  final CompendiumInitialParams initialParams;
  final CompendiumNavigator navigator;

  CompendiumCubit(this.initialParams, this.navigator)
      : super(CompendiumState.initial(initialParams: initialParams));

  getCompendiums({int? catId, int? subCatId}) async {
    emit(state.copyWith(isloading: true));
    List<Compendium> cp = await getIt<DatabaseHelper>()
        .getAllCompendium(catId: catId, subCatId: subCatId)
        .then(
          (value) => value.map((e) {
            return Compendium.fromMap(e);
          }).toList(),
        );

    for (var i = 0; i < cp.length; i++) {
      await getIt<DatabaseHelper>().getCategory(id: cp[i].categoryId).then(
            (value) => cp[i].category = Category.fromMap(value!),
          );
      await getIt<DatabaseHelper>()
          .getSubCategory(id: cp[i].subCategoryId)
          .then(
            (value) => cp[i].subCategory = SubCategory.fromMap(value!),
          );
    }
    List<Category> cat = await getIt<DatabaseHelper>().getAllCategories().then(
          (value) => value.map((e) {
            return Category.fromMap(e);
          }).toList(),
        );
    List<SubCategory> subCat =
        await getIt<DatabaseHelper>().getAllCategories().then(
              (value) => value.map((e) {
                return SubCategory.fromMap(e);
              }).toList(),
            );
    emit(
      state.copyWith(
          compendiums: cp.reversed.toList(),
          categories: cat,
          subCategories: subCat,
          isloading: false),
    );
  }

  // getSystems() async {
  //   await getIt<DatabaseHelper>().getAllSystems().then(
  //         (value) => emit(
  //           state.copyWith(
  //             systems: value.map((e) => System.fromMap(e)).toList(),
  //           ),
  //         ),
  //       );
  // }

  // void navigateToShare(Character character) {
  //   navigator.openChatList(
  //       ChatListInitialParams(toSend: false, character: character));
  // }
}
