typedef ErrorCallback<R> = R Function(Object? error, StackTrace stackTrace);

// TODO: Implement other error handling
ErrorCallback<R> apiErrorHandler<R>({
  required R Function() orElse,
}) {
  return (error, stackTrace) {
    return orElse();
  };
}
