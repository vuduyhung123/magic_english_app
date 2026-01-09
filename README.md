# Magic English App 🪄

Ứng dụng học từ vựng tiếng Anh thông minh được xây dựng bằng Flutter. Ứng dụng giúp người dùng quản lý từ vựng cá nhân, tích hợp AI (Groq/Ollama) để tự động điền thông tin chi tiết (phiên âm, dịch nghĩa, ngữ cảnh) và đồng bộ dữ liệu qua Firebase.

---

## 📋 Mục lục
- [Tính năng chính](#-tính-năng-chính)
- [Công nghệ sử dụng](#-công-nghệ-sử-dụng)
- [Yêu cầu cài đặt](#-yêu-cầu-cài-đặt)
- [Hướng dẫn cài đặt & Chạy](#-hướng-dẫn-cài-đặt--chạy)
- [Cấu hình biến môi trường (.env)](#-cấu-hình-biến-môi-trường-env)
- [Cấu trúc dự án](#-cấu-trúc-dự-án)

---

## ✨ Tính năng chính

* **Quản lý từ vựng (CRUD):** Thêm, sửa, xóa từ vựng. Lưu trữ chi tiết bao gồm: Từ gốc, Phiên âm (IPA), Nghĩa tiếng Việt, Loại từ, Ví dụ.
* **Tích hợp AI (AI Service):**
    * Hỗ trợ **Groq API** (Cloud - Tốc độ cao) và **Ollama** (Local - Offline).
    * Tự động gợi ý: Phiên âm, Dịch nghĩa, Ngữ cảnh (AI Context), Cấp độ CEFR, Topic liên quan.
* **Bộ lọc thông minh:** Lọc danh sách từ theo Chủ đề (Topic), Loại từ (Noun/Verb/Adj...), và Cấp độ (A1-C2).
* **Hệ thống xác thực:** Đăng nhập/Đăng ký bảo mật qua Google (Firebase Auth).
* **Đồng bộ đám mây:** Dữ liệu được lưu trữ và đồng bộ thời gian thực trên Firebase Firestore.
* **Giao diện thẻ (Card UI):** Hiển thị từ vựng dạng thẻ trực quan với các tags màu sắc phân loại rõ ràng.

---

## 🛠 Công nghệ sử dụng

* **Framework:** Flutter (Dart)
* **State Management:** Provider (MVVM Architecture)
* **Backend:** Firebase Authentication, Cloud Firestore
* **AI Integration:** REST API (kết nối tới Groq hoặc Ollama Server)
* **HTTP Client:** Dio / HTTP
* **Storage:** Shared Preferences (cho cài đặt cục bộ)

---

## ⚙️ Yêu cầu cài đặt

1.  **Flutter SDK:** Phiên bản ổn định mới nhất (3.x trở lên).
2.  **Java JDK:** Phiên bản 11 hoặc 17 (để build Android).
3.  **Tài khoản Firebase:** Đã kích hoạt Auth và Firestore.
4.  **API Key:** Groq API Key (nếu dùng Cloud AI).

---

## 🚀 Hướng dẫn cài đặt & Chạy

### 1. Sao chép mã nguồn
```bash
git clone [https://github.com/vuduyhung123/magic_english_app.git](https://github.com/vuduyhung123/magic_english_app.git)
cd magic_english_app
2. Cài đặt thư viện
Bash

flutter pub get
3. Cấu hình Firebase
Để ứng dụng chạy được, bạn cần file cấu hình từ Firebase Console:

Android: Tải file google-services.json và đặt vào thư mục android/app/.

iOS: Tải file GoogleService-Info.plist và đặt vào thư mục ios/Runner/.

Lưu ý: Đảm bảo đã thêm mã SHA-1 của máy tính bạn vào Firebase Console (phần Android App).

4. Thiết lập biến môi trường
Tạo file .env tại thư mục gốc của dự án. Xem hướng dẫn chi tiết ở mục bên dưới.

5. Chạy ứng dụng
Bash

flutter run
🔑 Cấu hình biến môi trường (.env)
Dự án sử dụng file .env để quản lý các cấu hình nhạy cảm.

Tạo file tên là .env ở thư mục gốc (ngang hàng với pubspec.yaml).

Sao chép nội dung dưới đây và điền key của bạn vào:

Đoạn mã

# --- Cấu hình AI Service ---

# Đặt 'true' nếu muốn chạy AI Offline (Ollama), 'false' nếu dùng Groq Cloud (Khuyên dùng)
USE_OLLAMA=false

# 1. Cấu hình cho Groq API (Cloud - Nhanh, nhẹ)
OLLAMA_BASE_URL=[https://api.groq.com/openai/v1/chat/completions](https://api.groq.com/openai/v1/chat/completions)
OLLAMA_API_KEY=gsk_YOUR_REAL_GROQ_API_KEY_HERE
OLLAMA_MODEL=llama-3.1-8b-instant

# 2. Cấu hình cho Ollama (Local - Offline)
# Nếu chạy trên Android Emulator, dùng IP 10.0.2.2 thay cho localhost
# OLLAMA_BASE_URL=[http://10.0.2.2:11434/api/generate](http://10.0.2.2:11434/api/generate)
# OLLAMA_MODEL=llama3
📂 Cấu trúc dự án (Sơ lược)
Plaintext

lib/
├── models/          # Các lớp dữ liệu (VocabWord, AppUser...)
├── services/        # Xử lý Logic API, Firebase, Auth
│   ├── ai_service.dart
│   ├── auth_service.dart
│   └── firebase_service.dart
├── view_models/     # Quản lý trạng thái (Provider)
│   ├── vocab_view_model.dart
│   └── add_vocab_view_model.dart
├── views/           # Giao diện người dùng (UI)
│   ├── vocab_screen.dart (Màn hình chính)
│   ├── vocab_topic_screen.dart (Chi tiết Topic)
│   └── add_vocab_screen.dart (Thêm từ mới)
└── main.dart        # Điểm khởi chạy ứng dụng
🤝 Đóng góp
Dự án đang trong giai đoạn phát triển (nhánh dev). Mọi đóng góp đều được hoan nghênh thông qua Pull Request.

📝 License
Dự án thuộc sở hữu cá nhân. Vui lòng liên hệ tác giả trước khi sử dụng cho mục đích thương mại.