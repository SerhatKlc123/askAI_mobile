class MessageModel {
  String? id;
  String? user;
  String? system;
  String? created;

  MessageModel({this.id, this.user, this.system, this.created});

  MessageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    system = json['system'];
    created = json['created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user'] = user;
    data['system'] = system;
    data['created'] = created;
    return data;
  }
}
