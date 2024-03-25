import 'package:ecommerce_app/models/profile_details.dart';
import 'package:ecommerce_app/services/firebase_services.dart';
import 'package:ecommerce_app/utils/api_paths.dart';

abstract class ProfileServices {
  Future<ProfileDetails> getProfile(String id);
  Future<List<ProfileDetails>> getProfiles();
}

class ProfileServicesImpl implements ProfileServices {
  final firestoreService = FirestoreService.instance;

  @override
  Future<List<ProfileDetails>> getProfiles() async =>
      await firestoreService.getCollection<ProfileDetails>(
        path: ApiPaths.profiles(),
        builder: (data, documentId) => ProfileDetails.fromMap(data, documentId),
      );
  @override
  Future<ProfileDetails> getProfile(String id) async =>
      await firestoreService.getDocument<ProfileDetails>(
        path: ApiPaths.profile(id),
        builder: (data, documentId) => ProfileDetails.fromMap(data, documentId),
      );
}
