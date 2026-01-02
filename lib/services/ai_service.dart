import 'dart:convert';
import 'package:dio/dio.dart';

/// Abstract class để định nghĩa các hành động chung của AI
abstract class AIService {
  Future<Map<String, dynamic>> enrichVocabulary(String word);
  Future<Map<String, dynamic>> checkGrammar(String text);
}

/// Factory để tạo AI Service dựa trên cấu hình
class AIServiceFactory {
  static AIService create({
    bool useOllama = false,
    String? apiKey,
    String? baseUrl,
    String? model,
  }) {
    if (useOllama) {
      if (apiKey == null || apiKey.isEmpty) {
        throw Exception(
          'Cần có API Key trong file .env để chạy Groq/Ollama Cloud',
        );
      }
      return OllamaAIService(
        apiKey: apiKey,
        baseUrl: baseUrl ?? 'https://api.groq.com/openai/v1/chat/completions',
        // SỬA: Cập nhật model mới nhất để tránh lỗi "decommissioned"
        model: model ?? 'llama-3.1-8b-instant',
      );
    } else {
      if (apiKey == null || apiKey.isEmpty) {
        throw Exception('API key is required for Claude AI');
      }
      return ClaudeAIService(apiKey: apiKey);
    }
  }
}

/// Implementation sử dụng Groq Cloud (Giao thức OpenAI)
class OllamaAIService implements AIService {
  final Dio _dio;
  final String baseUrl;
  final String model;

  OllamaAIService({
    required String apiKey,
    required this.baseUrl,
    required this.model,
  }) : _dio = Dio(
         BaseOptions(
           connectTimeout: const Duration(seconds: 30),
           receiveTimeout: const Duration(seconds: 60),
           headers: {
             'Content-Type': 'application/json',
             'Authorization': 'Bearer $apiKey',
           },
         ),
       );

  @override
  Future<Map<String, dynamic>> enrichVocabulary(String word) async {
    // Prompt mới: Thêm "for Vietnamese learners" và yêu cầu rõ ràng bằng tiếng Việt
    final systemPrompt =
        '''
You are an expert English Teacher AI for Vietnamese learners.
Task: Analyze the English word "$word".

Output: Return ONLY a raw JSON object (no markdown) with this exact structure. 
IMPORTANT: The "meaning" field MUST be in Vietnamese.

{
  "word": "$word",
  "phonetics": "/IPA transcription/",
  "meaning": "Dịch nghĩa tiếng Việt ngắn gọn, súc tích",
  "kind": "Part of speech (noun/verb/adj...)",
  "cefrLevel": "CEFR Level (A1-C2)",
  "topic": "Relevant topic",
  "example": "A simple example sentence using the word"
}
''';
    return _sendRequestToGroq(systemPrompt);
  }

  @override
  Future<Map<String, dynamic>> checkGrammar(String text) async {
    // SỬA: Prompt mạnh hơn để bắt buộc AI liệt kê lỗi chi tiết
    final systemPrompt =
        '''
Act as a strict English Grammar Teacher. Check this text: "$text"

Tasks:
1. Identify EVERY single grammar, spelling, or punctuation error.
2. For each error, you MUST create an entry in the "errors" list.
3. Provide a "betterVersion" that is natural and native-like.
4. Give a "score" from 0 to 100 (where 100 is perfect).

Return ONLY raw JSON (no markdown) with this structure:
{
  "score": 60,
  "errors": [
    {
      "type": "grammar", 
      "message": "Explain the error clearly in Vietnamese", 
      "original": "the wrong part", 
      "suggestion": "the correct part"
    }
  ],
  "betterVersion": "The corrected full sentence here."
}
''';
    return _sendRequestToGroq(systemPrompt);
  }

  /// Hàm chung để gửi request lên Groq
  Future<Map<String, dynamic>> _sendRequestToGroq(String content) async {
    try {
      final response = await _dio.post(
        baseUrl,
        data: {
          "model": model,
          "messages": [
            {"role": "user", "content": content},
          ],
          "temperature": 0.2, // Giảm nhiệt độ để kết quả chính xác hơn
          "response_format": {"type": "json_object"},
        },
      );

      final data = response.data;
      if (data['choices'] != null && data['choices'].isNotEmpty) {
        final contentString = data['choices'][0]['message']['content'];
        return _parseJSON(contentString);
      } else {
        throw Exception('Groq trả về dữ liệu rỗng');
      }
    } on DioException catch (e) {
      final errorMsg = e.response?.data?['error']?['message'] ?? e.message;
      throw Exception('Lỗi kết nối AI (Groq): $errorMsg');
    } catch (e) {
      throw Exception('Lỗi hệ thống: $e');
    }
  }

  Map<String, dynamic> _parseJSON(String text) {
    try {
      final cleanText = text
          .replaceAll(RegExp(r'```json\s*'), '')
          .replaceAll(RegExp(r'```\s*'), '')
          .trim();
      return json.decode(cleanText);
    } catch (e) {
      // Fallback: Thử tìm pattern JSON trong chuỗi
      final jsonMatch = RegExp(r'\{[\s\S]*\}').firstMatch(text);
      if (jsonMatch != null) {
        return json.decode(jsonMatch.group(0)!);
      }
      throw Exception('Không thể đọc dữ liệu JSON từ AI: $text');
    }
  }
}

/// Implementation sử dụng Claude API (Giữ nguyên logic cũ)
class ClaudeAIService implements AIService {
  final Dio _dio;
  // ignore: unused_field
  final String _apiKey;

  ClaudeAIService({required String apiKey}) : _apiKey = apiKey, _dio = Dio();

  @override
  Future<Map<String, dynamic>> enrichVocabulary(String word) async {
    throw UnimplementedError("Hiện tại đang dùng Groq, chưa cấu hình Claude");
  }

  @override
  Future<Map<String, dynamic>> checkGrammar(String text) async {
    throw UnimplementedError("Hiện tại đang dùng Groq, chưa cấu hình Claude");
  }
}
