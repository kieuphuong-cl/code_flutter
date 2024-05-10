class FavoriteModel {
  final String id;
  final String imgUrl;
  final String name;
  final String price;

  bool isFavourite;

  FavoriteModel(
      {required this.id,
      required this.imgUrl,
      required this.name,
      required this.price,
      this.isFavourite = true});
}
