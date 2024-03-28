part of 'home_cubit.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  final List<ProductItemModel> products;
  final List<AnnouncementModel> announcements;

  HomeLoaded(this.products, this.announcements);
}

final class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}
final class AddingOrRemovingFromFavorites extends HomeState {}
final class RemovedFromFavorites extends HomeState {
  final String productId;
 final bool isFavorite;

  RemovedFromFavorites({ required this.isFavorite, required this.productId});
}

final class AddedToFavorites extends HomeState {
 final bool isFavorite;
  final String productId;

  AddedToFavorites({required this.productId, required this.isFavorite});


}

final class AddToFavoritesError extends HomeState {
  final String message;
final String productId;
  AddToFavoritesError(this.message, this.productId);
}