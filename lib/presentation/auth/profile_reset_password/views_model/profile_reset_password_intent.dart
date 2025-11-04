sealed class ProfileResetPasswordIntent {}

class InitializeProfileResetPasswordFormIntent
    extends ProfileResetPasswordIntent {}

class OnProfileResetPasswordIntent extends ProfileResetPasswordIntent {}

class ToggleObscurePasswordIntent extends ProfileResetPasswordIntent {}
