import 'package:fitness_app/core/constants/const_keys.dart';
import 'package:fitness_app/core/secure_storage/secure_storage.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GeminiService {
  final SecureStorage _secureStorage;

  GeminiService(this._secureStorage);

  Future<String> sendMessage(String userMessage) async {
    final apiKey = await _secureStorage.getData(key: ConstKeys.geminiApiKey);
    if (apiKey == null || apiKey.isEmpty) {
      throw Exception(
        "Missing Gemini API key. Please store it securely first.",
      );
    }
    final model = GenerativeModel(model: 'gemini-2.5-flash', apiKey: apiKey);

    try {
      final content = [Content.text(userMessage)];
      final response = await model.generateContent(content);
      return response.text ?? "No response from Gemini.";
    } catch (e) {
      return "Error: $e";
    }
  }
}
