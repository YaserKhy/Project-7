import 'package:project7/models/project_model.dart';

class ProfileModel {
  ProfileModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.role,
    required this.imageUrl,
    required this.resumeUrl,
    required this.link,
    required this.projects,
    required this.createdAt,
    required this.updatedAt,
  });
  late final String id;
  late final String firstName;
  late final String lastName;
  late final String email;
  late final String role;
  late final String imageUrl;
  late final String resumeUrl;
  late final Link? link;
  late final List<ProjectModel> projects;
  late final String createdAt;
  late final String updatedAt;
  
  ProfileModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    role = json['role'];
    imageUrl = json['image_url'] ?? "assets/images/profile_holder.png";
    link = Link.fromJson(json['link']);
    projects = List.from(json['projects']).map((e)=>ProjectModel.fromJson(e)).toList();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['first_name'] = firstName;
    _data['last_name'] = lastName;
    _data['email'] = email;
    _data['role'] = role;
    _data['image_url'] = imageUrl;
    _data['link'] = link?.toJson();
    _data['projects'] = projects.map((e)=>e.toJson()).toList();
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}