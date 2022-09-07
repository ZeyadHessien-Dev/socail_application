class PostModel {
  String? name;
  String? text;
  String? imagePost;
  String? image;
  String? dateTime;
  String? uid;

  PostModel({
    this.text,
    this.image,
    this.name,
    this.uid,
    this.dateTime,
    this.imagePost,
});
  PostModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    text = json['text'];
    image = json['image'];
    dateTime = json['dateTime'];
    uid = json['uid'];
    imagePost = json['imagePost'];
  }

  Map<String,dynamic> toMap() {
    return {
      'name' : name,
      'text' : text,
      'image' : image,
      'dateTime' : dateTime,
      'uid' : uid,
      'imagePost' : imagePost,
    };
  }
}