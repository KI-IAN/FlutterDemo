import 'package:flutter/material.dart';

const owl_url =
    'https://www.njhiking.com/wp-content/uploads/2017/12/snowy-owl-12-2017-AC0Z6032-570x570.jpg';

class FadeInDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FadeInDemoState();
  }
}

class _FadeInDemoState extends State<FadeInDemo> {
  double opacity = 0.0;
  String showDetailsText = 'Show Details';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Image.network(owl_url),
        MaterialButton(
          child: Text(
            '${showDetailsText}',
            style: TextStyle(color: Colors.blueAccent),
          ),
          onPressed: () {
            setState(() {
              var isVisible = (opacity == 1.0);
              opacity = (isVisible) ? 0 : 1.0;
              showDetailsText = (isVisible) ? 'Show Details' : 'Hide Details';
            });
          },
        ),
        AnimatedOpacity(
          duration: Duration(seconds: 1),
          opacity: opacity,
          child: Column(
            children: <Widget>[
              Text('Type: Owl'),
              Text('Age: 39'),
              Text('Employment : None'),
            ],
          ),
        )
      ],
    );
  }
}
