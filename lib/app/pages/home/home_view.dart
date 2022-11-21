import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:foxbit_hiring_test_template/app/pages/home/home_controller.dart';
import 'package:foxbit_hiring_test_template/app/widgets/_exports.dart';

class HomePage extends View {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends ViewState<HomePage, HomeController> {
  HomePageState() : super(HomeController());

  @override
  Widget get view => Scaffold(
        key: globalKey,
        appBar: AppBar(
          title: const Text('Home Screen'),
        ),
        body: Column(
          children: [
            const Text(
              'Cotação',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 500,
              width: double.infinity,
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return const CotationWidget(
                    coinImageId: '',
                    coinName: 'Bitcoin',
                    coinSymbol: 'BTC',
                    coinValue: 29.000,
                    coinVariationValue: '+1.20',
                  );
                },
              ),
            ),
          ],
        ),
      );
}
