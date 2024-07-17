import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Card with Continue Example'),
        ),
        body: Center(
          child: MyCard(),
        ),
      ),
    );
  }
}

class MyCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double cardHeight = screenHeight * 0.6; // Ubah sesuai kebutuhan

    return Card(
      child: Stack(
        children: [
          OverflowBox(
            maxHeight: double.infinity,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: cardHeight),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Judul Card',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'Isi konten card yang panjang-panjang disini. '
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                        'Pellentesque imperdiet consectetur dolor in elementum. '
                        'Nulla facilisi. Sed ac nisi a quam vulputate tincidunt vitae '
                        'ut urna. Phasellus vehicula condimentum ligula a eleifend. '
                        'Maecenas euismod metus in tortor faucibus, nec volutpat ante '
                        'ultricies. Integer eget turpis orci. Morbi suscipit libero ut '
                        'nulla facilisis, ac fermentum massa scelerisque. Vestibulum sit '
                        'amet arcu euismod, tincidunt augue sit amet, dictum lacus. '
                        'Pellentesque habitant morbi tristique senectus et netus et '
                        'malesuada fames ac turpis egestas.',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                    // Tambahkan lebih banyak konten sesuai kebutuhan
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Konten tambahan yang lebih panjang agar card memanjang. '
                        'Vivamus hendrerit velit nec ligula aliquet, id scelerisque odio '
                        'consequat. Integer at sapien nec lorem feugiat venenatis. '
                        'Sed elementum ultricies lorem, eget fermentum turpis venenatis sit amet. '
                        'Nulla at facilisis justo. Proin vel molestie ipsum. '
                        'Quisque euismod justo eget lacus laoreet, ac placerat libero venenatis.',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: Text(
                'Continue',
                style: TextStyle(fontSize: 16.0, color: Colors.blue),
              ),
            ),
          ),
        ],
     ),
);
}
}
