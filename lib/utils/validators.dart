String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return '이메일을 입력하세요.';
  }
  final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
  if (!emailRegex.hasMatch(value)) {
    return '유효한 이메일 주소를 입력하세요.';
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return '비밀번호를 입력하세요.';
  }
  if (value.length < 6) {
    return '비밀번호는 최소 6자 이상이어야 합니다.';
  }
  return null;
}

String? validateNotEmpty(String? value, String fieldName) {
  if (value == null || value.isEmpty) {
    return '$fieldName을(를) 입력하세요.';
  }
  return null;
}
