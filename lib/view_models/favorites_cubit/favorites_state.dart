part of 'favorites_cubit.dart';

sealed class FavoritesState {}

final class FavoritesInitial extends FavoritesState {}
final class FavoritesLoading extends FavoritesState {}

final class FavoritesLoaded extends FavoritesState {
  final List<ProductItemModel> favProducts;

  FavoritesLoaded({required this.favProducts} );
}

final class FavoritesError extends FavoritesState {
  final String message;

  FavoritesError({required this.message});
}
final class RemoveFromFavorites extends FavoritesState {

}
