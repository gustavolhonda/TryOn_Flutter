  import 'package:flutter_test/flutter_test.dart';
import 'package:atividade_avaliativa_2/repositories/user_repository.dart';

void main() {
  group('UserRepository', () {
    final userRepository = UserRepository(useTestUrl: true);

    test('login bem-sucedido', () async {
      final result = await userRepository.login('user1@gmail.com', '123');
      expect(result, 'success');
    });

    test('login com usuário errado', () async {
      final result = await userRepository.login('gustavo', '123');
      expect(result, 'wrong_username');
    });

    test('login com senha errada', () async {
      final result = await userRepository.login('user1@gmail.com', '123wrong');
      expect(result, 'wrong_password');
    });
  });
} 