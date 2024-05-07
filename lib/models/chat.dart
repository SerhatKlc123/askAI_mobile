class ChatModel {
  String? id;
  String? conversationName;
  bool? favorite;
  String? created;

  ChatModel({this.id, this.conversationName, this.created});

  ChatModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    conversationName = json['conversation_name'];
    favorite = json['favorite'];
    created = json['created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['conversation_name'] = conversationName;
    data['favorite'] = favorite;
    data['created'] = created;
    return data;
  }
}
