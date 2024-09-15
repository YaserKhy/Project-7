import 'dart:developer';

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

  ProfileModel.fromJson(Map<String, dynamic> json) {
        log("fromjson");

    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    role = json['role'];
    imageUrl = json['image_url'] ?? "assets/images/profile_holder.png";
    link = Link.fromJson(json['link']);
    projects = List.from(json['projects'])
        .map((e) => ProjectModel.fromJson(e))
        .toList();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    log("fromjson");
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['role'] = role;
    data['image_url'] = imageUrl;
    data['link'] = link?.toJson();
    data['projects'] = projects.map((e) => e.toJson()).toList();
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
