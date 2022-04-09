import 'dart:ui';

import 'constants.dart';

class Shoes {
  late int id;
  late String images;
  late double price;
  int rate;
  final description =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. "
      "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
  late String title;
  Color linearGradientColor1 = const Color(0xFF8AA560);
  Color linearGradientColor2 = const Color(0xFF8AA560);
  Color background = const Color(0xFFFFFFFF);
  String brand;
  Color logoColor = const Color(0xFFFFFFFF);

  Shoes(this.id, this.images, this.title, this.price, this.rate, this.brand);
}

final List<Shoes> shoes = [
  ///Shoes
  Shoes(1, 'lib/assets/images/shoes_1.png', 'Pegasus 34', 101, 3, nikeLogo),
  Shoes(3, 'lib/assets/images/shoes_4.png', 'Nike Flywire Air Max', 134.5, 2,
      nikeLogo),
  Shoes(4, 'lib/assets/images/shoes_5.png', 'Nike Flywire Air Max', 134.5, 5,
      nikeLogo),
  Shoes(5, 'lib/assets/images/shoes_6.png', 'Adidas Superstar', 134.5, 3,
      adidasLogo),
  Shoes(6, 'lib/assets/images/shoes_7.png', 'Nike Huarache Air Force', 134.5, 4,
      nikeLogo),
  Shoes(
      7, 'lib/assets/images/shoes_8.png', 'Nike Mercurial', 134.5, 4, nikeLogo),
  Shoes(8, 'lib/assets/images/shoes_9.png', 'Adidas Superstar', 134.5, 4,
      adidasLogo),
  Shoes(
      9, 'lib/assets/images/shoes_10.png', 'Nike Flywire', 134.5, 5, nikeLogo),
  Shoes(10, 'lib/assets/images/shoes_11.png', 'Adidas Barricade', 134.5, 3,
      adidasLogo),
  Shoes(11, 'lib/assets/images/shoes_12.png', 'Nike Air Max 97', 134.5, 1,
      nikeLogo),
  Shoes(12, 'lib/assets/images/shoes_13.png', 'Nike Air Force I', 134.5, 0,
      nikeLogo),
  Shoes(13, 'lib/assets/images/shoes_14.png', 'Nike Pegasus 35 Blue', 134.5, 5,
      nikeLogo),
  Shoes(
      14, 'lib/assets/images/shoes_16.png', 'Nike Jordan', 134.5, 3, nikeLogo),
  Shoes(15, 'lib/assets/images/shoes_18.png', 'Nike Huarache Air Force', 134.5,
      5, nikeLogo),
  Shoes(16, 'lib/assets/images/shoes_19.png', 'Nike Air Max Red', 134.5, 4,
      nikeLogo),
  Shoes(17, 'lib/assets/images/shoes_20.png', 'Nike Air Max Grey and Red',
      134.5, 3, nikeLogo),
];
