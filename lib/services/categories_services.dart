import 'package:ecommerce_app/models/category_model.dart';
import 'package:ecommerce_app/services/firebase_services.dart';
import 'package:ecommerce_app/utils/api_paths.dart';

abstract class CategoryServices {
  Future<List<CategoryModel>> getCategories();
}

class CategoryServicesImpl implements CategoryServices {
  final firestoreService = FirestoreService.instance;

  @override
  Future<List<CategoryModel>> getCategories() async =>
      await firestoreService.getCollection<CategoryModel>(
        path: ApiPaths.categories(),
        builder: (data, documentId) =>
            CategoryModel.fromMap(data, documentId),
      );
}
