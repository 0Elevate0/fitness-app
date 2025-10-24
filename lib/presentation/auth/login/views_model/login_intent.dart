sealed class LoginIntent {}

class InitializeLoginFormIntent extends LoginIntent {}

class ToggleObscurePasswordIntent extends LoginIntent {}

class LoginWithEmailAndPasswordIntent extends LoginIntent {}
