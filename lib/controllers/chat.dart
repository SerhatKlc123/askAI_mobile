import 'package:ask_ai/mobile_tablet/widgets/snack.dart';
import 'package:ask_ai/models/chat.dart';
import 'package:ask_ai/models/favorite.dart';
import 'package:ask_ai/models/message.dart';
import 'package:ask_ai/services/api.dart';
import 'package:ask_ai/services/exception_handler.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class ChatController extends GetxController {
  // All chat request will handle with this controller
  final load = false.obs;
  final chatLoad = false.obs;
  final favLoad = false.obs;
  final loadScreen = false.obs;
  final webLoad = false.obs;
  final _box = GetStorage();
  final chats = <ChatModel>[].obs;
  final messages = <MessageModel>[].obs;
  final favoriteChats = <FavoriteModel>[].obs;
  // Create a list for empty chat
  final chatMessages = <String>[].obs;
  String chatID = "";
  final conversationName = "".obs;

  // Favorite section
  final isFavorite = true.obs;

  // Delete user data (Chats, Messages and Favorites)
  Future<void> deleteUserData() async {
    try {
      var response = await ApiService.dio.delete(ApiService.deleteChats,
          options: Options(
              headers: {"Authorization": "Bearer ${_box.read("token")}"}));
      successBar(response.data["message"]);
      isFavorite.value = false;
      chatMessages.clear();
      conversationName.value = "";
      chatID = "";
      messages.clear();
      await getChats();
      await getFavorites();


    } catch (error) {
      if (error is DioException) {
        ExceptionHandler.handler(error.response?.statusCode ?? 0);
      } else {
        ExceptionHandler.defaultHandler();
      }
    }
  }

  Future<void> getFavorites() async {
    setFavLoad();
    try {
      var response = await ApiService.dio.get(ApiService.favorite,
          options: Options(
              headers: {"Authorization": "Bearer ${_box.read("token")}"}));
      var data = response.data["data"];
      if (data is List) {
        favoriteChats.value =
            data.map((e) => FavoriteModel.fromJson(e)).toList();
      }
    } catch (error) {
      if (error is DioException) {
        ExceptionHandler.handler(error.response?.statusCode ?? 0);
      } else {
        ExceptionHandler.defaultHandler();
      }
    }

    setFavLoad();
  }

  Future<void> addFavorite() async {
    setFavorite();
    try {
      var response = await ApiService.dio.put(ApiService.addFavorite,
          options: Options(
              headers: {"Authorization": "Bearer ${_box.read("token")}"}),
          data: {
            "chat_id": chatID,
            "conversation_name": conversationName.value
          });
      successBar(response.data["message"]);
    } catch (error) {
      if (error is DioException) {
        ExceptionHandler.handler(error.response?.statusCode ?? 0);
      } else {
        ExceptionHandler.defaultHandler();
      }
    }

  }

  Future<void> removeFavorite() async {
    setFavorite();
    try {
      var response = await ApiService.dio.delete(
          ApiService.removeFavorite + chatID,
          options: Options(
              headers: {"Authorization": "Bearer ${_box.read("token")}"}));
      successBar(response.data["message"]);
    } catch (error) {
      if (error is DioException) {
        ExceptionHandler.handler(error.response?.statusCode ?? 0);
      } else {
        ExceptionHandler.defaultHandler();
      }

    }
  }

  Future<void> getChats() async {
    setLoad();
    try {
      var response = await ApiService.dio.get(ApiService.chat,
          options: Options(
              headers: {"Authorization": "Bearer ${_box.read("token")}"}));
      var data = response.data["data"];
      if (data is List) {
        chats.value = data.map((e) => ChatModel.fromJson(e)).toList();
      }
    } catch (error) {
      if (error is DioException) {
        ExceptionHandler.handler(error.response?.statusCode ?? 0);
      } else {
        ExceptionHandler.defaultHandler();
      }
    }

    setLoad();
  }

  Future<void> getWebChats() async {
    try {
      var response = await ApiService.dio.get(ApiService.chat,
          options: Options(
              headers: {"Authorization": "Bearer ${_box.read("token")}"}));
      var data = response.data["data"];
      if (data is List) {
        chats.value = data.map((e) => ChatModel.fromJson(e)).toList();
      }
    } catch (error) {
      if (error is DioException) {
        ExceptionHandler.handler(error.response?.statusCode ?? 0);
      } else {
        ExceptionHandler.defaultHandler();
      }
    }
  }

  Future<void> createChat(String conversationName) async {
    setChatLoad();
    try {
      isFavorite.value = false;
      var response = await ApiService.dio.post(ApiService.createChat,
          data: {"conversation_name": conversationName},
          options: Options(headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer ${_box.read("token")}"
          }));
      chatID = response.data["chat_id"];
      this.conversationName.value = conversationName;

      await askToAi(conversationName);
      getChats();
    } catch (error) {
      if (error is DioException) {
        ExceptionHandler.handler(error.response?.statusCode ?? 0);
      } else {
        ExceptionHandler.defaultHandler();
      }
    }
    setChatLoad();
  }

  Future<void> createWebChat(String conversationName) async {
    setWebLoad();
    try {
      isFavorite.value = false;
      var response = await ApiService.dio.post(ApiService.createChat,
          data: {"conversation_name": conversationName},
          options: Options(headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer ${_box.read("token")}"
          }));
      chatID = response.data["chat_id"];
      this.conversationName.value = conversationName;

      await askToAi(conversationName);
      getWebChats();
    } catch (error) {
      if (error is DioException) {
        ExceptionHandler.handler(error.response?.statusCode ?? 0);
      } else {
        ExceptionHandler.defaultHandler();
      }
    }
    setWebLoad();
  }

  Future<void> askToAi(String question) async {
    try {
      var response = await ApiService.dio.post(ApiService.askAI,
          data: {"chat_id": chatID, "user": question},
          options: Options(
              headers: {"Authorization": "Bearer ${_box.read("token")}"}));
      String answer = response.data["data"]["response"] ?? "";
      chatMessages.add(answer);
    } catch (error) {
      if (error is DioException) {
        ExceptionHandler.handler(error.response?.statusCode ?? 0);
      } else {
        ExceptionHandler.defaultHandler();
      }
    }
  }

  Future<void> getMessages(String chatID, String path) async {
    setLoadScreen();
    // Navigate to chat screen and wait for data initialization
    Get.toNamed(path);
    // Empty prev state and set chatID
    chatID = chatID;
    chatMessages.clear();
    try {
      var response = await ApiService.dio.get(ApiService.messages + chatID,
          options: Options(
              headers: {"Authorization": "Bearer ${_box.read("token")}"}));
      var data = response.data["data"];
      if (data is List) {
        messages.value = data.map((e) => MessageModel.fromJson(e)).toList();
        // Set message data for view
        for (int i = 0; i < messages.length; i++) {
          chatMessages.add(messages[i].user ?? "");
          chatMessages.add(messages[i].system ?? "");
        }
      }
    } catch (error) {
      if (error is DioException) {
        ExceptionHandler.handler(error.response?.statusCode ?? 0);
      } else {
        ExceptionHandler.defaultHandler();
      }
    }

    setLoadScreen();
  }

  Future<void> getWebMessages(String chatID) async {
    setLoadScreen();
    // Empty prev state and set chatID
    chatID = chatID;
    chatMessages.clear();
    try {
      var response = await ApiService.dio.get(ApiService.messages + chatID,
          options: Options(
              headers: {"Authorization": "Bearer ${_box.read("token")}"}));
      var data = response.data["data"];
      if (data is List) {
        messages.value = data.map((e) => MessageModel.fromJson(e)).toList();
        // Set message data for view
        for (int i = 0; i < messages.length; i++) {
          chatMessages.add(messages[i].user ?? "");
          chatMessages.add(messages[i].system ?? "");
        }
      }
    } catch (error) {
      if (error is DioException) {
        ExceptionHandler.handler(error.response?.statusCode ?? 0);
      } else {
        ExceptionHandler.defaultHandler();
      }
    }

    setLoadScreen();
  }

  void newWebChat()
  {
    setLoad();
    isFavorite.value = false;
    chatMessages.clear();
    conversationName.value = "";
    chatID = "";
    messages.clear();
    setLoad();
  }

  // Loading functions for ui update
  void setLoad() => load.value = !load.value;
  void setWebLoad() => webLoad.value = !webLoad.value;
  void setChatLoad() => chatLoad.value = !chatLoad.value;
  void setLoadScreen() => loadScreen.value = !loadScreen.value;
  void setFavorite() => isFavorite.value = !isFavorite.value;
  void setFavLoad() => favLoad.value = !favLoad.value;

  String formatDate(String date) {
    String dateString = date;
    DateTime dateTime = DateTime.parse(dateString);
    return DateFormat('d MMMM y h a').format(dateTime);
  }

  @override
  void onInit() {
    getChats();
    super.onInit();
  }
}
