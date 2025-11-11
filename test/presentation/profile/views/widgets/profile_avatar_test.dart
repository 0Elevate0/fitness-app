import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/presentation/profile/views/widgets/profile_avatar.dart';
import 'package:fitness_app/presentation/profile/views_model/profile_cubit.dart';
import 'package:fitness_app/presentation/profile/views_model/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_avatar_test.mocks.dart';

@GenerateMocks([ProfileCubit])
void main() {
  // Arrange
  late MockProfileCubit mockProfileCubit;
  setUp(() {
    mockProfileCubit = MockProfileCubit();
    getIt.registerFactory<ProfileCubit>(() => mockProfileCubit);
    provideDummy<ProfileState>(const ProfileState());
    when(mockProfileCubit.state).thenReturn(const ProfileState());
    when(
      mockProfileCubit.stream,
    ).thenAnswer((_) => Stream.fromIterable([const ProfileState()]));
  });
  Widget prepareWidget() {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          home: BlocProvider<ProfileCubit>.value(
            value: mockProfileCubit,
            child: const ProfileAvatar(),
          ),
        );
      },
    );
  }

  testWidgets("Verifying ProfileAvatar Widgets", (tester) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(find.byType(Column), findsOneWidget);
    expect(find.byType(Container), findsWidgets);
    expect(find.byType(CircleAvatar), findsOneWidget);
    expect(find.byType(RSizedBox), findsWidgets);
    expect(find.byType(Text), findsOneWidget);
  });

  tearDown(() {
    getIt.reset();
  });
}
