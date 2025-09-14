extension NullExtension<T> on T? {
  R? let<R>(R Function(T) action) {
    final value = this;

    return value != null ? action(value) : null;
  }
}
