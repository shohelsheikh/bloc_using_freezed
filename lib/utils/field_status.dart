class FieldStatus {
  final bool isValid;
  final String? errorMessage;

  const FieldStatus(this.isValid, this.errorMessage);

  @override
  String toString() => 'isValid: $isValid, errorMessage: $errorMessage';
}
