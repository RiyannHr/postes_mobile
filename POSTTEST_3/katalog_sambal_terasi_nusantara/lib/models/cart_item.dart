import 'sambal_model.dart';

class CartItem {
  final SambalModel sambal;
  int quantity;

  CartItem({required this.sambal, this.quantity = 1});
}