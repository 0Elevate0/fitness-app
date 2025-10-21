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

final class ChangeSelectedYearsIntent extends RegisterIntent {
  final int newSelectedYears;
  const ChangeSelectedYearsIntent({required this.newSelectedYears});
}

final class ChangeSelectedWeightIntent extends RegisterIntent {
  final int newSelectedWeight;
  const ChangeSelectedWeightIntent({required this.newSelectedWeight});
}

final class ChangeSelectedHeightIntent extends RegisterIntent {
  final int newSelectedHeight;
  const ChangeSelectedHeightIntent({required this.newSelectedHeight});
}
