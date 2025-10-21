import 'package:fitness_app/api/models/user/user_model.dart';
import 'package:fitness_app/domain/entities/user_data_entity/user_data_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("test toUserEntity", () {
    test(
      "when call toUserEntity with null values it should return UserEntity with null values",
      () {
        // Arrange
        final UserModel userModel = UserModel(
          height: null,
          weight: null,
          activityLevel: null,
          goal: null,
          Id: null,
          age: null,
          createdAt: null,
          firstName: null,
          lastName: null,
          email: null,
          gender: null,
          photo: null,
        );

        // Act
        final UserDataEntity actualResult = userModel.toUserDataEntity();

        // Assert
        expect(actualResult.id, equals(userModel.Id));
        expect(actualResult.firstName, equals(userModel.firstName));
        expect(actualResult.lastName, equals(userModel.lastName));
        expect(actualResult.email, equals(userModel.email));
        expect(actualResult.gender, equals(userModel.gender));
        expect(actualResult.createdAt, equals(userModel.createdAt));
        expect(actualResult.photo, equals(userModel.photo));
        expect(actualResult.age, equals(userModel.age));
        expect(actualResult.goal, equals(userModel.goal));
        expect(actualResult.height, equals(userModel.height));
        expect(actualResult.weight, equals(userModel.weight));
        expect(actualResult.activityLevel, equals(userModel.activityLevel));
      },
    );

    test(
      "when call toUserEntity with non-nullable values it should return UserEntity with correct values",
      () {
        // Arrange
        final UserModel userModel = UserModel(
          gender: "male",
          Id: "123",
          firstName: "moaaz",
          lastName: "hassan",
          email: 'moaazhassan10@gmail.com',
          photo: "photo_url",
          createdAt: "2023-10-01",
          age: 25,
          weight: 70,
          height: 175,
          activityLevel: "active",
          goal: "build muscle",
        );

        // Act
        final UserDataEntity actualResult = userModel.toUserDataEntity();

        // Assert
        expect(actualResult.id, equals(userModel.Id));
        expect(actualResult.firstName, equals(userModel.firstName));
        expect(actualResult.lastName, equals(userModel.lastName));
        expect(actualResult.email, equals(userModel.email));
        expect(actualResult.gender, equals(userModel.gender));
        expect(actualResult.createdAt, equals(userModel.createdAt));
        expect(actualResult.photo, equals(userModel.photo));
        expect(actualResult.age, equals(userModel.age));
        expect(actualResult.goal, equals(userModel.goal));
        expect(actualResult.height, equals(userModel.height));
        expect(actualResult.weight, equals(userModel.weight));
        expect(actualResult.activityLevel, equals(userModel.activityLevel));
      },
    );
  });

  group("test JSON serialization", () {
    test("toJson and fromJson should work correctly", () {
      // Arrange
      final UserModel userModel = UserModel(
        gender: "male",
        Id: "123",
        firstName: "moaaz",
        lastName: "hassan",
        email: 'moaazhassan10@gmail.com',
        photo: "photo_url",
        createdAt: "2023-10-01",
        age: 25,
        weight: 70,
        height: 175,
        activityLevel: "active",
        goal: "build muscle",
      );

      // Act
      final json = userModel.toJson();
      final fromJson = UserModel.fromJson(json);

      // Assert
      expect(fromJson.Id, equals(userModel.Id));
      expect(fromJson.firstName, equals(userModel.firstName));
      expect(fromJson.lastName, equals(userModel.lastName));
      expect(fromJson.email, equals(userModel.email));
      expect(fromJson.gender, equals(userModel.gender));
      expect(fromJson.createdAt, equals(userModel.createdAt));
      expect(fromJson.photo, equals(userModel.photo));
      expect(fromJson.age, equals(userModel.age));
      expect(fromJson.goal, equals(userModel.goal));
      expect(fromJson.height, equals(userModel.height));
      expect(fromJson.weight, equals(userModel.weight));
      expect(fromJson.activityLevel, equals(userModel.activityLevel));
    });
  });
}
