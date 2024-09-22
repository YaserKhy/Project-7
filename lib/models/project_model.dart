import 'dart:developer';

class ProjectModel {
  ProjectModel({
    required this.projectId,
    required this.type,
    required this.projectName,
    required this.bootcampName,
    required this.startDate,
    required this.endDate,
    required this.presentationDate,
    required this.projectDescription,
    required this.logoUrl,
    required this.presentationUrl,
    required this.userId,
    required this.adminId,
    required this.timeEndEdit,
    required this.allowEdit,
    required this.allowRating,
    required this.isPublic,
    required this.rating,
    required this.createAt,
    required this.updateAt,
    required this.imagesProject,
    required this.linksProject,
    required this.membersProject,
  });
  late final String projectId;
  late final String type;
  late final String projectName;
  late final String bootcampName;
  late final String? startDate;
  late final String endDate;
  late final String? presentationDate;
  late final String projectDescription;
  late String logoUrl;
  late final String presentationUrl;
  late final String userId;
  late final String adminId;
  late final String timeEndEdit;
  late final bool allowEdit;
  late final bool allowRating;
  late final bool isPublic;
  late final double rating;
  late final String createAt;
  late final String updateAt;
  late final List<ImagesProject> imagesProject;
  late final List<LinksProject> linksProject;
  late final List<MembersProject> membersProject;

  ProjectModel.fromJson(Map<String, dynamic> json) {
    log("ProjectModel.fromJson");
    projectId = json['project_id'];
    type = json['type'];
    projectName = json['project_name'] ?? 'Untitled';
    bootcampName = json['bootcamp_name'] ?? 'Unassigned';
    startDate = json['start_date'];
    endDate = json['end_date'] ?? 'in progress';
    presentationDate = json['presentation_date'];
    projectDescription = json['project_description'] ?? 'No Description Added';
    logoUrl = json['logo_url'] ?? 'assets/images/tuwaiq_logo1.png';
    presentationUrl =
        json['presentation_url'] ?? 'https://www.google.com.sa/?hl=ar';
    userId = json['user_id'];
    adminId = json['admin_id'];
    timeEndEdit = json['time_end_edit'];
    allowEdit = json['allow_edit'];
    allowRating = json['allow_rating'];
    isPublic = json['is_public'];
    rating = json['rating'] / 1.0;
    createAt = json['create_at'];

    updateAt = json['update_at'] ?? "null";

    imagesProject = List.from(json['images_project'])
        .map((e) => ImagesProject.fromJson(e))
        .toList();
    linksProject = List.from(json['links_project'])
        .map((e) => LinksProject.fromJson(e))
        .toList();
    membersProject = List.from(json['members_project'])
        .map((e) => MembersProject.fromJson(e))
        .toList();
    log("ProjectModel.fromJson3");
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['project_id'] = projectId;
    data['type'] = type;
    data['project_name'] = projectName;
    data['bootcamp_name'] = bootcampName;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['presentation_date'] = presentationDate;
    data['project_description'] = projectDescription;
    data['logo_url'] = logoUrl;
    data['presentation_url'] = presentationUrl;
    data['user_id'] = userId;
    data['admin_id'] = adminId;
    data['time_end_edit'] = timeEndEdit;
    data['allow_edit'] = allowEdit;
    data['allow_rating'] = allowRating;
    data['is_public'] = isPublic;
    data['rating'] = rating;
    data['create_at'] = createAt;
    data['update_at'] = updateAt;
    data['images_project'] = imagesProject.map((e) => e.toJson()).toList();
    data['links_project'] = linksProject.map((e) => e.toJson()).toList();
    data['members_project'] = membersProject.map((e) => e.toJson()).toList();
    return data;
  }
}

class ImagesProject {
  late final int id;
  late final String url;
  ImagesProject({
    required this.id,
    required this.url,
  });

  ImagesProject.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['url'] = url;
    return data;
  }
}

class LinksProject {
  late final String url;
  late final String type;
  LinksProject({required this.url, required this.type});

  LinksProject.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['url'] = url;
    data['type'] = type;
    return data;
  }
}

class MembersProject {
  MembersProject({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.position,
    required this.imageUrl,
    this.link,
  });
  late final String id;
  late final String firstName;
  late final String lastName;
  late final String email;
  late final String position;
  late final String imageUrl;
  late final Link? link;

  MembersProject.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    position = json['position'];
    imageUrl = json['imageUrl'] ?? 'assets/images/profile_holder.png';
    link = Link.fromJson(json['link']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['position'] = position;
    data['image_url'] = imageUrl;
    data['link'] = link?.toJson();
    return data;
  }
}

class Link {
  Link({
    this.github,
    this.linkedin,
    this.resume,
    this.bindlink,
  });
  late final String? github;
  late final String? linkedin;
  late final String? resume;
  late final String? bindlink;

  Link.fromJson(Map<String, dynamic> json) {
    github = json['github'];
    linkedin = json['linkedin'];
    resume = json['resume'];
    bindlink = json['bindlink'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['github'] = github;
    data['linkedin'] = linkedin;
    data['resume'] = resume;
    data['bindlink'] = bindlink;
    return data;
  }
}
