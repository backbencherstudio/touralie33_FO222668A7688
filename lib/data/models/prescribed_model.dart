class PriscirbedModel {
  bool? success;
  String? message;
  List<Data>? data;
  MetaData? metaData;

  PriscirbedModel({this.success, this.message, this.data, this.metaData});

  PriscirbedModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    metaData = json['meta_data'] != null
        ? new MetaData.fromJson(json['meta_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.metaData != null) {
      data['meta_data'] = this.metaData!.toJson();
    }
    return data;
  }
}

class Data {
  String? id;
  String? title;
  String? thumbnailUrl;
  String? url;
  String? watchStatus;
  String? category;
  int? chaptersCount;
  String? createdAt;
  int? duration;
  String? level;
  bool? isCompleted;
  int? lastWatchPosition;

  Data(
      {this.id,
      this.title,
      this.thumbnailUrl,
      this.url,
      this.watchStatus,
      this.category,
      this.chaptersCount,
      this.createdAt,
      this.duration,
      this.level,
      this.isCompleted,
      this.lastWatchPosition});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    thumbnailUrl = json['thumbnail_url'];
    url = json['video_url']?.toString() ??
        json['url']?.toString() ??
        json['mp4_url']?.toString() ??
        json['mp4']?.toString();
    watchStatus = json['watch_status'];
    category = json['category'];
    chaptersCount = json['chapters_count'];
    createdAt = json['created_at'];
    duration = json['duration'];
    level = json['level'];
    isCompleted = json['is_completed'];
    lastWatchPosition = json['last_watch_position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['thumbnail_url'] = this.thumbnailUrl;
    data['url'] = this.url;
    data['watch_status'] = this.watchStatus;
    data['category'] = this.category;
    data['chapters_count'] = this.chaptersCount;
    data['created_at'] = this.createdAt;
    data['duration'] = this.duration;
    data['level'] = this.level;
    data['is_completed'] = this.isCompleted;
    data['last_watch_position'] = this.lastWatchPosition;
    return data;
  }
}

class MetaData {
  int? page;
  int? limit;
  int? total;
  String? search;

  MetaData({this.page, this.limit, this.total, this.search});

  MetaData.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    limit = json['limit'];
    total = json['total'];
    search = json['search'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['limit'] = this.limit;
    data['total'] = this.total;
    data['search'] = this.search;
    return data;
  }
}
