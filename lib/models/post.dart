import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

@JsonSerializable()
class Post {
  String id; // no need to provide id ,  will be automatically generated
  final String title;
  final String description;
  final List<String> genre;
  final DateTime date;
  final String imageUrl;
  final int upVotes;
  final int downVotes;
  final String authorName;
  final String authorId;

  Post({
    this.id = "",
    required this.title,
    required this.description,
    required this.genre,
    required this.date,
    required this.imageUrl,
    required this.upVotes,
    required this.downVotes,
    required this.authorName,
    required this.authorId,
  });

  Map<String, dynamic> toJson() => _$PostToJson(this);

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);


  @override
  String toString() {
    return "Post(id : $id ,title : $title ,descr: $description , genre : ${genre
        .toString()} , date : ${date
        .toString()} , image : $imageUrl , upVotes : $upVotes , downVotes : $downVotes , author : $authorName , authorId : $authorId )";
  }


}