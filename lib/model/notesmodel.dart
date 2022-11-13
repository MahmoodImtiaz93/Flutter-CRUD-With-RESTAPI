class NotesModel {
  List<Notes>? notes;

  NotesModel({this.notes});

  NotesModel.fromJson(Map<String, dynamic> json) {
    if (json['notes'] != null) {
      notes = <Notes>[];
      json['notes'].forEach((v) {
        notes!.add( Notes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    if (this.notes != null) {
      data['notes'] = this.notes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Notes {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? title;
  String? body;

  Notes({this.id, this.createdAt, this.updatedAt, this.title, this.body});

  Notes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    title = json['title'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['title'] = this.title;
    data['body'] = this.body;
    return data;
  }
}
 