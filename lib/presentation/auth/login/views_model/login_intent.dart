sealed class LoginIntent {}

class InitializeLoginFormIntent extends LoginIntent {}

class ToggleObscurePasswordIntent extends LoginIntent {}

final class CheckFieldsValidationIntent extends LoginIntent {}

class LoginWithEmailAndPasswordIntent extends LoginIntent {}

final class EnableValidationIntent extends LoginIntent {}
