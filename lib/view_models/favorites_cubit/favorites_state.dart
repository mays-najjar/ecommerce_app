part of 'favorites_cubit.dart';

sealed class FavoritesState {}

final class FavoritesInitial extends FavoritesState {}
final class FavoritesLoading extends FavoritesState {}

final class FavoritesLoaded extends FavoritesState {
  final List<ProductItemModel> favProducts;

  FavoritesLoaded(this.favProducts);
}

final class FavoritesError extends FavoritesState {
  final String message;

  FavoritesError(this.message);
}
final class RemoveFromFavorites extends FavoritesState {

}
