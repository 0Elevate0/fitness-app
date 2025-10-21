sealed class RegisterIntent {
  const RegisterIntent();
}

final class RegisterInitializationIntent extends RegisterIntent {
  const RegisterInitializationIntent();
}

final class ToggleObscurePasswordIntent extends RegisterIntent {
  const ToggleObscurePasswordIntent();
}

final class MoveToRegistrationNextStepIntent extends RegisterIntent {
  const MoveToRegistrationNextStepIntent();
}

final class MoveToRegistrationPreviousStepIntent extends RegisterIntent {
  const MoveToRegistrationPreviousStepIntent();
}

final class ChangeSelectedGenderIntent extends RegisterIntent {
  final String newSelectedGender;
  const ChangeSelectedGenderIntent({required this.newSelectedGender});
}
