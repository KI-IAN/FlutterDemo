import 'package:flutter/material.dart';

class CardDemo extends StatelessWidget {
  Widget _buildCard() => SizedBox(
        height: 218,
        child: Card(
          elevation: 20,
          child: Column(
            children: <Widget>[
              ListTile(
                
                title: Text('1625 Main Street',
                    style: TextStyle(fontWeight: FontWeight.w500)),
                subtitle: Text('My City, CA 99884'),
                leading: Icon(
                  Icons.restaurant_menu,
                  color: Colors.blue[500],
                ),
              ),
              Divider(),
              ListTile(
                title: Text('(408) 55-1212', style: TextStyle(
                  fontWeight: FontWeight.w500,
                )),
                leading: Icon(
                  Icons.contact_phone,
                  color: Colors.blue[500]
                ),
              ),
              ListTile(
                title: Text('costa@example.com'),

                leading: Icon(
                  Icons.contact_mail,
                  color: Colors.blue[500]
                ),
              ),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return _buildCard();
  }
}
