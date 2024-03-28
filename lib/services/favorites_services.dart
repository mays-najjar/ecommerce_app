import 'package:ecommerce_app/models/product_item_model.dart';
import 'package:ecommerce_app/services/firebase_services.dart';
import 'package:ecommerce_app/utils/api_paths.dart';

abstract class FavoritesServices {
  Future<List<ProductItemModel>> getFavoritesItems(String uid);
  Future<void> removeFromFavorites(String uid, String favProductId);
}

class FavoritesServicesImpl implements FavoritesServices {
  final firestoreService = FirestoreService.instance;

  @override
  Future<List<ProductItemModel>> getFavoritesItems(String uid) async =>
      await firestoreService.getCollection<ProductItemModel>(
        path: ApiPaths.favItems(uid),
        builder: (data, documentId) => ProductItemModel.fromMap(data, documentId),
      );



   @override
  Future<void> removeFromFavorites(
          String uid, String productId) async =>
      await firestoreService.deleteData(
        path: ApiPaths.favItem(uid, productId),
      );
}

