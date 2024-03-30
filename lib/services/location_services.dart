import 'package:ecommerce_app/models/address_model.dart';
import 'package:ecommerce_app/services/firebase_services.dart';
import 'package:ecommerce_app/utils/api_paths.dart';

abstract class LocationServices {
  Future<List<AddressModel>> getLocations(String uid);
  

}
class LocationServicesImpl implements LocationServices {
  final firestoreService = FirestoreService.instance;

  @override
  Future<List<AddressModel>> getLocations(String uid) async =>
      await firestoreService.getCollection<AddressModel>(
        path: ApiPaths.addresses(uid),
        builder: (data, documentId) => AddressModel.fromMap(data),
      );

  
}
