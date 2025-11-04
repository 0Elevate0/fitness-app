sealed class ProfileResetPasswordIntent {}

class InitializeProfileResetPasswordFormIntent
    extends ProfileResetPasswordIntent {}

class OnProfileResetPasswordIntent extends ProfileResetPasswordIntent {}

class CurrentToggleObscurePasswordIntent extends ProfileResetPasswordIntent {}

class ConfirmToggleObscurePasswordIntent extends ProfileResetPasswordIntent {}

class NewToggleObscurePasswordIntent extends ProfileResetPasswordIntent {}
