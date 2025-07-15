import 'package:flutter_test/flutter_test.dart';
import 'package:atividade_avaliativa_2/repositories/product_repository.dart';
import 'package:atividade_avaliativa_2/models/product.dart';

void main() {
  group('ProductRepository', () {
    final productRepository = ProductRepository(useTestUrl: true);

    test('getProducts retorna todos os produtos corretamente', () async {
      final products = await productRepository.getProducts();
      expect(products.length, 4);

      // Produto 1
      final p1 = products[0];
      expect(p1.id, 1);
      expect(p1.name, 'Camiseta cinza');
      expect(p1.price, 100.0);
      expect(p1.shopName, 'Renner');
      expect(p1.shopCategory, 'Casual');
      expect(p1.rating, 4.5);
      expect(p1.availableSizes.length, 5);
      expect(p1.availableSizes, containsAll(['XS', 'S', 'M', 'L', 'XL']));
      expect(p1.images.length, 3);
      expect(p1.images[0], startsWith('https://'));

      // Produto 2
      final p2 = products[1];
      expect(p2.id, 2);
      expect(p2.name, 'Calça baggy');
      expect(p2.price, 200.0);
      expect(p2.shopName, 'Skate Street Wear');
      expect(p2.shopCategory, 'Street Wear');
      expect(p2.rating, 4.0);
      expect(p2.availableSizes.length, 3);
      expect(p2.availableSizes, containsAll(['M', 'L', 'XL']));
      expect(p2.images.length, 3);
      expect(p2.images[1], startsWith('https://'));

      // Produto 3
      final p3 = products[2];
      expect(p3.id, 3);
      expect(p3.name, 'Kit 2 Moletom Careca');
      expect(p3.price, 300.0);
      expect(p3.shopName, 'Lacoste');
      expect(p3.shopCategory, 'Luxo');
      expect(p3.rating, 5.0);
      expect(p3.availableSizes.length, 5);
      expect(p3.availableSizes, containsAll(['XS', 'S', 'M', 'L', 'XL']));
      expect(p3.images.length, 3);
      expect(p3.images[2], startsWith('https://'));

      // Produto 4
      final p4 = products[3];
      expect(p4.id, 4);
      expect(p4.name, 'Boné de Aba Reta');
      expect(p4.price, 400.0);
      expect(p4.shopName, 'Ophicina');
      expect(p4.shopCategory, 'Chapéus e Bonés');
      expect(p4.rating, 4.0);
      expect(p4.availableSizes.length, 3);
      expect(p4.availableSizes, containsAll(['M', 'L', 'XL']));
      expect(p4.images.length, 3);
      expect(p4.images[0], startsWith('https://'));
    });
  });
} 