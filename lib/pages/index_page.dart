import 'package:flutter/material.dart';
import 'package:videotron_rental/theme.dart';
import 'package:videotron_rental/widgets/category_card.dart';
import 'package:videotron_rental/widgets/product_card.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  bool isLoading = false;
  int? selectedCategoryId;
  final List<dynamic> dataCategory = [
    {'id': 1, 'name': 'LED'},
    {'id': 2, 'name': 'LCD'},
    {'id': 3, 'name': 'Video Processor'},
    {'id': 4, 'name': 'Ringging'},
    {'id': 5, 'name': 'Other'},
  ];

  final List<dynamic> dataVideotron = [
    {'category_id': 1, 'name': 'LR Pro LED 1'},
    {'category_id': 1, 'name': 'LR Pro LED 2'},
    {'category_id': 2, 'name': 'LR Pro LED 3'},
    {'category_id': 2, 'name': 'LR Pro LED 3'},
  ];

  @override
  void initState() {
    super.initState();
    selectedCategoryId = dataCategory.isNotEmpty ? dataCategory.first['id'] : 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 250,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset('assets/image-profile.png'),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Halo, Alfan",
                                style: whiteTextStyle.copyWith(fontSize: 16),
                              ),
                            ],
                          ),
                          Image.asset(
                            'assets/icon-notification.png',
                            width: 24,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Mau sewa Videotron\ndimana ?",
                        style: whiteTextStyle.copyWith(
                            fontSize: 24, fontWeight: bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: defaultMargin),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: dataCategory.map((item) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          isLoading = true;
                          selectedCategoryId = item['id'];
                        });

                        Future.delayed(const Duration(seconds: 1), () {
                          setState(() {
                            isLoading = false;
                          });
                        });
                      },
                      child: CategoryCard(
                        name: item['name'],
                        active: selectedCategoryId == item['id'] ? true : false,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: defaultMargin),
              child: Text(
                "Rekomendasi untuk kamu",
                style:
                    primaryTextStyle.copyWith(fontSize: 12, fontWeight: bold),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            isLoading == true
                ? Container(
                    margin: const EdgeInsets.only(top: 100),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(left: defaultMargin),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: dataVideotron
                            .where((element) =>
                                element['category_id'] == selectedCategoryId)
                            .map((e) {
                          return const ProductCard();
                        }).toList(),
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
