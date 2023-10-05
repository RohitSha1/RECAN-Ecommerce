// import 'package:flutter_test/flutter_test.dart';
// void main() {
//   late UserRepository? userRepository;
//   setUp(() {
//     userRepository = UserRepository();
//   });
//   test('user registration', () async {
//     bool expectedResult = true;
//     User user = User(
//       email: 'ram@12345',
//       password: '123',
//       username: 'ram2',
//       role: 'employee',
//     );
//     bool actualResult = await userRepository!.registerUser(user);
//     expect(actualResult, expectedResult);
//   });
//   test('user login', () async {
//     bool expectedResult = true;
//     String username = 'ram123';
//     String password = '123';
//     String role = 'employee';
//     bool actualResult = await userRepository!.login(username, password, role);
//     expect(actualResult, expectedResult);
//   });
//   tearDown(() {
//     userRepository = null;
//   });
// }