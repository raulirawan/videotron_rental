import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:videotron_rental/pages/history_detail_page.dart';
import 'package:videotron_rental/pages/main_page.dart';
import 'package:videotron_rental/providers/auth_provider.dart';
import 'package:videotron_rental/providers/transaction_provider.dart';
import 'package:videotron_rental/theme.dart';
import 'package:videotron_rental/widgets/history_card.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  void initState() {
    super.initState();
    final AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    final transactionProvider =
        Provider.of<TransactionProvider>(context, listen: false);
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   transactionProvider.getListTransaction(authProvider.user.token);
    // });
    transactionProvider.getTransaction(token: authProvider.user.token);
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final transactionProvider = Provider.of<TransactionProvider>(context);
  Future<void> refresh() async {
        await transactionProvider
            .getTransaction(token: authProvider.user.token);
      }
    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: ListView(
          children: [
            SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 120,
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
                                        "Halo, ${authProvider.user.name}",
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
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(
                        horizontal: defaultMargin,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 45,
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const MainPage(
                                                selectedIndex: 1,
                                              )),
                                      (route) => false);
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(yellowColor),
                                  shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                  ),
                                ),
                                child: Text(
                                  "Tambah Penyewaan",
                                  style: primaryTextStyle.copyWith(
                                    fontWeight: bold,
                                  ),
                                )),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            "History Transaksi",
                            style: primaryTextStyle.copyWith(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          // GestureDetector(
                          //     onTap: () {
                          //       Navigator.push(
                          //           context,
                          //           MaterialPageRoute(
                          //               builder: (context) =>
                          //                   const HistoryDetailPage()));
                          //     },
                          //     child: HistoryCard()),
                          Consumer<TransactionProvider>(
                            builder: (context, provider, child) {
                              if (provider.transaction.isEmpty) {
                                return Container(
                                  margin: const EdgeInsets.only(top: 100),
                                  child: const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              } else {
                                return Column(
                                  children: provider.transaction
                                      .map(
                                        (e) => GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        HistoryDetailPage(
                                                          transactionDataModel: e,
                                                        )));
                                          },
                                          child: HistoryCard(transactionDataModel: e),
                                        ),
                                      )
                                      .toList(),
                                );
            
                                // return GestureDetector(
                                //     onTap: () {
                                //       Navigator.push(
                                //           context,
                                //           MaterialPageRoute(
                                //               builder: (context) =>
                                //                   const HistoryDetailPage()));
                                //     },
                                //     child: HistoryCard(provider));
                              }
                            },
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
