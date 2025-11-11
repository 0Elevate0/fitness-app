import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GeminiService {
  Future<String> sendMessage(String userMessage) async {
    final geminiKey = dotenv.get('gemini_key', fallback: "");
    final model = GenerativeModel(model: 'gemini-2.5-flash', apiKey: geminiKey);
    try {
      final content = [Content.text(userMessage)];
      final response = await model.generateContent(content);
      return response.text ?? "No response from Gemini.";
    } catch (error) {
      return "Error: $error";
    }
  }
}
