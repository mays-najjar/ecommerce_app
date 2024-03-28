import 'package:ecommerce_app/models/announcement_model.dart';
import 'package:ecommerce_app/models/product_item_model.dart';
import 'package:ecommerce_app/services/firebase_services.dart';
import 'package:ecommerce_app/utils/api_paths.dart';

abstract class HomeServices {
  Future<List<ProductItemModel>> getProducts();
  Future<List<AnnouncementModel>> getAnnouncements();
  Future<ProductItemModel> getProduct(String id);
  Future<void> addToFavorites(String uid, ProductItemModel favProduct);
  Future<void> removeFromFavorites(String uid, ProductItemModel favProduct);
  Future<bool> checkIfFavoritesDocumentExists(String uid, ProductItemModel favProduct);
}

class HomeServicesImpl implements HomeServices {
  final firestoreService = FirestoreService.instance;

  @override
  Future<List<ProductItemModel>> getProducts() async =>
      await firestoreService.getCollection<ProductItemModel>(
        path: ApiPaths.products(),
        builder: (data, documentId) =>
            ProductItemModel.fromMap(data, documentId),
      );
  @override
  Future<List<AnnouncementModel>> getAnnouncements() async =>
      await firestoreService.getCollection<AnnouncementModel>(
        path: ApiPaths.announcements(),
        builder: (data, documentId) =>
            AnnouncementModel.fromMap(data, documentId),
      );
  @override
  Future<ProductItemModel> getProduct(String id) async =>
      await firestoreService.getDocument<ProductItemModel>(
        path: ApiPaths.product(id),
        builder: (data, documentId) =>
            ProductItemModel.fromMap(data, documentId),
      );

  @override
  Future<void> addToFavorites(String uid, ProductItemModel favProduct) async =>
      await firestoreService.setData(
        path: ApiPaths.favItem(uid, favProduct.id),
        data: favProduct.toMap(),
      );

  @override
  Future<void> removeFromFavorites(
          String uid, ProductItemModel favProduct) async =>
      await firestoreService.deleteData(
        path: ApiPaths.favItem(uid, favProduct.id),
      );
  @override
  Future<bool> checkIfFavoritesDocumentExists(
      String uid, ProductItemModel favProduct) async {
    final check = await firestoreService.checkIfFavoritesDocumentExists(
        path: ApiPaths.favItem(uid, favProduct.id));
    return check;
  }
}
