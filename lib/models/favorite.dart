class FavoriteModel {
  String? id;
  String? chatId;
  String? conversationName;
  String? added;

  FavoriteModel({this.id, this.chatId, this.conversationName, this.added});

  FavoriteModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    chatId = json['chat_id'];
    conversationName = json['conversation_name'];
    added = json['added'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['chat_id'] = chatId;
    data['conversation_name'] = conversationName;
    data['added'] = added;
    return data;
  }
}
