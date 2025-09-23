mixin LoadingMixin {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool loading) {
    _isLoading = loading;
  }

  /// Execute a function with loading state management
  Future<T> withLoading<T>(Future<T> Function() operation) async {
    setLoading(true);
    try {
      final result = await operation();
      return result;
    } finally {
      setLoading(false);
    }
  }
}
