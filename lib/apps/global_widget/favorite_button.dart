import 'package:flutter/material.dart';

class FavoriteButton extends StatefulWidget {
  FavoriteButton(
      {super.key,
      required this.productId,
      this.from,
      required this.isFav,
      this.adsUserId,
      this.logInUserId,
      this.onFavClick});

  final int productId;
  bool isFav;
  final String? from;
  final int? adsUserId;
  final int? logInUserId;
  Function()? onFavClick;

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onFavClick ?? () => {},
      child: widget.isFav
          ? const Icon(Icons.favorite, color: Colors.red, size: 20)
          : Icon(Icons.favorite_outline, color: Colors.grey.shade500, size: 20),
    );
  }
}
