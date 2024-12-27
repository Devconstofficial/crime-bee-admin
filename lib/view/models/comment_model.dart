class CommentModel {
  String username = "";
  String content = "";
  String image = "";
  int likes = -1;
  bool isLiked = false;

  CommentModel.empty();

  CommentModel.fromJson(Map<String,dynamic> json){
    username = json["username"] ?? "";
    content = json["content"] ?? "";
    image = json["image"] ?? "";
    likes = json["likes"] ?? -1;
    isLiked = json["isLiked"] ?? false;
  }

  Map<String,dynamic> toJson() {
    return {
      "username" : username,
      "isLiked" : isLiked,
      "content" : content,
      "image": image
    };
  }

  @override
  String toString() {
    return 'CommentModel{username: $username, content: $content, likes: $likes, '
        'isLiked: $isLiked, image: $image}';
  }
}

