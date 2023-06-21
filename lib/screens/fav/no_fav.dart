 import 'package:flutter/material.dart';
import 'package:quiz_app_new/core/toast/toast.dart';

class NoFav extends StatelessWidget {
  const NoFav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('asset/image/fav.jpg', fit: BoxFit.cover),
            const SizedBox(
              height: 11,
            ),
            Text(
              "No Fav Yet ..",
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: myColor,
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
