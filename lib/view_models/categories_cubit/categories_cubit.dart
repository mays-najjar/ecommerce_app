import 'package:ecommerce_app/models/category_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(CategoriesInitial());

  void getCategoryData() async {
    emit(CategoriesLoading());
    try {
      final categories = dummyCategories;
      await Future.delayed(const Duration(seconds: 2));
      emit(CategoriesLoaded(categories));
    } catch (e) {
      emit(CategoriesError(e.toString()));
    }
  }
}
