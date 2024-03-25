class AnnouncementModel {
  final String id;
  final String imgUrl;

  AnnouncementModel({required this.id, required this.imgUrl});
  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'imgUrl': imgUrl});

    return result;
  }

  factory AnnouncementModel.fromMap(
      Map<String, dynamic> map, String documentId) {
    return AnnouncementModel(
      id: map['id'] ?? '',
      imgUrl: map['imgUrl'] ?? '',
    );
  }
}
List<AnnouncementModel> dummyAnnouncements = [
 
  AnnouncementModel(
    id: 'M8oeDHXs5xNatKVOeYod',
    imgUrl:
        'https://edit.org/photos/img/blog/mbp-template-banner-online-store-free.jpg-840.jpg',
  ),
  AnnouncementModel(
    id: 'zAIDSZY7nSuVwhtW4O8E',
    imgUrl:
        'https://casalsonline.es/wp-content/uploads/2018/12/CASALS-ONLINE-18-DICIEMBRE.png',
  ),
  AnnouncementModel(
    id: 'WcrzEqJdo9DHeEm1f07N',
    imgUrl:
        'https://e0.pxfuel.com/wallpapers/606/84/desktop-wallpaper-ecommerce-website-design-company-noida-e-commerce-banner-design-e-commerce.jpg',
  ),
];
