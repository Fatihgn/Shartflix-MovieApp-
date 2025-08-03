/// Utility functions for parsing JSON data into model objects.
List<T> parseList<T>(dynamic data, T Function(Map<String, dynamic>) fromJson) {
  return (data as List<dynamic>)
      .map((item) => fromJson(item as Map<String, dynamic>))
      .toList();
}

/// Parses a single item from JSON data.
T parseSingle<T>(dynamic data, T Function(Map<String, dynamic>) fromJson) {
  return fromJson(data as Map<String, dynamic>);
}
