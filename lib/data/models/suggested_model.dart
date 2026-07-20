class SuggestedModel {
  bool? success;
  String? message;
  List<Data>? data;
  MetaData? metaData;

  SuggestedModel({
    this.success,
    this.message,
    this.data,
    this.metaData,
  });

  SuggestedModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];

    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }

    metaData = json['meta_data'] != null
        ? MetaData.fromJson(json['meta_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['success'] = success;
    data['message'] = message;

    if (this.data != null) {
      data['data'] = this.data!.map((e) => e.toJson()).toList();
    }

    if (metaData != null) {
      data['meta_data'] = metaData!.toJson();
    }

    return data;
  }
}

class Data {
  String? id;
  String? title;
  String? thumbnailUrl;
  String? category;
  int? chaptersCount;
  String? createdAt;
  int? duration;
  String? level;
  bool? isFavorite;

  // New fields
  String? watchStatus;
  bool? isCompleted;
  int? lastPlayedPosition;
  String? mediaType;

  Data({
    this.id,
    this.title,
    this.thumbnailUrl,
    this.category,
    this.chaptersCount,
    this.createdAt,
    this.duration,
    this.level,
    this.isFavorite,
    this.watchStatus,
    this.isCompleted,
    this.lastPlayedPosition,
    this.mediaType,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    thumbnailUrl = json['thumbnail_url'];
    category = json['category'];
    chaptersCount = json['chapters_count'];
    createdAt = json['created_at'];
    duration = json['duration'];
    level = json['level'];
    isFavorite = json['is_favorite'];

    watchStatus = json['watch_status'];
    isCompleted = json['is_completed'];
    lastPlayedPosition = json['last_played_position'];
    mediaType = json['media_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['id'] = id;
    data['title'] = title;
    data['thumbnail_url'] = thumbnailUrl;
    data['category'] = category;
    data['chapters_count'] = chaptersCount;
    data['created_at'] = createdAt;
    data['duration'] = duration;
    data['level'] = level;
    data['is_favorite'] = isFavorite;

    data['watch_status'] = watchStatus;
    data['is_completed'] = isCompleted;
    data['last_played_position'] = lastPlayedPosition;
    data['media_type'] = mediaType;

    return data;
  }
}

class MetaData {
  int? page;
  int? limit;
  int? total;
  String? search;
  Filter? filter;

  MetaData({
    this.page,
    this.limit,
    this.total,
    this.search,
    this.filter,
  });

  MetaData.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    limit = json['limit'];
    total = json['total'];
    search = json['search'];
    filter =
        json['filter'] != null ? Filter.fromJson(json['filter']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['page'] = page;
    data['limit'] = limit;
    data['total'] = total;
    data['search'] = search;

    if (filter != null) {
      data['filter'] = filter!.toJson();
    }

    return data;
  }
}

class Filter {
  String? categoryId;
  String? startDate;
  String? endDate;

  Filter({
    this.categoryId,
    this.startDate,
    this.endDate,
  });

  Filter.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['category_id'] = categoryId;
    data['start_date'] = startDate;
    data['end_date'] = endDate;

    return data;
  }
}