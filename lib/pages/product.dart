import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  final String title;
  final String imageUrl;

  ProductPage(this.title, this.imageUrl);

  _showWarningDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('are you shure?'),
          content: Text('This action cannot be undone'),
          actions: [
            TextButton(
              onPressed: () => {
                Navigator.pop(context),
              },
              child: Text('DISCARD'),
              style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.red)),
            ),
            TextButton(
              onPressed: () => {
                Navigator.pop(context),
                Navigator.pop(context,true)
              },
              child: Text('CONTINUE'),
              style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(imageUrl),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Text(title),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red, // background
                  onPrimary: Colors.white, // foreground
                ),
                //style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () {
                  //Navigator.pop(context, true);
                  _showWarningDialog(context);
                },
                child: Text('delete'),
              ),
            ),
          ],
        ),
      ),
      onWillPop: () async {
        Navigator.pop(context, false);
        return Future.value(false);
      },
    );
  }
}
