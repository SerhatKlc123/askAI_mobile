import 'package:dio/dio.dart';

class ApiService {
  // Define backend endpoints for requests
  static const baseUrl = "https://ask-ai-backend.onrender.com";
  static const register = "/v1/auth/register";
  static const login = "/v1/auth/login";
  static const verifyUser = "/v1/auth/verify-user";
  static const sendVerification = "/v1/auth/send-verification";
  static const renewPassword = "/v1/auth/renew-password";
  static const chat = "/v1/chat/my";
  static const createChat = "/v1/chat/create";
  static const askAI = "/v1/chat/ask";
  static const deleteChats = "/v1/chat/delete";
  static const messages = "/v1/chat/messages/";
  static const addFavorite = "/v1/favorite/add";
  static const removeFavorite = "/v1/favorite/remove/";
  static const favorite = "/v1/favorite/my";

  // Create a base service handler
  static final dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: const Duration(seconds: 15),
  ));
}
