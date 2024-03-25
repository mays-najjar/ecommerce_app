import 'package:ecommerce_app/models/category_model.dart';
import 'package:ecommerce_app/services/categories_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(CategoriesInitial());
  final categoryServices = CategoryServicesImpl();

  void getCategoryData() async {
    emit(CategoriesLoading());
    try {
            final categories = await categoryServices.getCategories();

      await Future.delayed(const Duration(seconds: 2));
      emit(CategoriesLoaded(categories));
    } catch (e) {
      emit(CategoriesError(e.toString()));
    }
  }
}
