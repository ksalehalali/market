class ProductColorsData{
  final String? color;
  final String? colorId;
  final List<String>? imagesUrls;

  ProductColorsData({this.color, required this.imagesUrls,this.colorId});
}

class ProductImagesData{
  final String? color;
  final List<String>? imagesUrls;
  final String? colorId;


  ProductImagesData( {this.color, required this.imagesUrls, this.colorId});
}