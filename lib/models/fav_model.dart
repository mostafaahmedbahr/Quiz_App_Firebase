class FavouriteModel {
  String? id;
  String? userId;
  String videoUrl;
  String title;


  FavouriteModel({
    this.id,
    this.userId,

    required this.title,
    required this.videoUrl,
  });

  FavouriteModel.fromFirestore(Map<String, dynamic> map)
      : this(
    //productId: map['product_id'],
    id: map['id'],
    userId: map['user_id'],
    title: map['title'],
    videoUrl: map['video_url'],
  );

  Map<String, dynamic> toFirestore() {
    return {
      // 'product_id' : productId,
      'id': id,
      'user_id': userId,
      'title': title,
      'video_url': videoUrl,
    };
  }
}
