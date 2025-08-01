sealed class Result<T> {
  const Result();

  factory Result.ok(T value) => Ok(value);
  factory Result.error(String error) => Error(error);
}

final class Ok<T> extends Result<T> {
  final T value;

  const Ok(this.value);
}

final class Error<T> extends Result<T> {
  final String error;

  const Error(this.error);
}
