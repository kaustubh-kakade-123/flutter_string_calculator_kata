class ServerException implements Exception {}

class CacheException implements Exception {}

class ValidationException implements Exception {
  final String message;
  ValidationException(this.message);
}

class CalculationException implements Exception {
  final String message;
  CalculationException(this.message);
}
