import 'package:flutter/widgets.dart';

class ViewerHomeLayoutBackground extends StatelessWidget {
  const ViewerHomeLayoutBackground({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Opacity(
        opacity: 1,
        child: Image.asset(
          'assets/images/home_background.png',
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class ViewerHomeSceneBackground extends StatelessWidget {
  const ViewerHomeSceneBackground({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.5,
      child: Container(
        constraints: const BoxConstraints.expand(),
        child: Image.asset(
          'assets/images/winter.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
