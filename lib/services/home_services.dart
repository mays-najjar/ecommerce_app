import 'package:ecommerce_app/models/announcement_model.dart';
import 'package:ecommerce_app/models/product_item_model.dart';
import 'package:ecommerce_app/services/firebase_services.dart';
import 'package:ecommerce_app/utils/api_paths.dart';

abstract class HomeServices {
  Future<List<ProductItemModel>> getProducts();
  Future<List<AnnouncementModel>> getAnnouncements();

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
}
