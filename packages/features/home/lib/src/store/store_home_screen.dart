import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:home/src/components/status_overview_section.dart';
import 'package:home/src/components/store_metric_card.dart';
import 'package:store_repository/store_repository.dart';
import 'package:wallet/wallet.dart';

class StoreHomeScreen extends StatelessWidget {
  const StoreHomeScreen({
    super.key,
    required this.onViewOrderTap,
    required this.onManageProductsTap,
    required this.storeRepository,
    this.storeId = '3b4c5d6e-7f8a-9b0c-1d2e-3f4a5b6c7d8e',
  });

  final VoidCallback onViewOrderTap;
  final VoidCallback onManageProductsTap;
  final StoreRepository storeRepository;
  final String storeId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: storeRepository.getStoreDashboardMetric(storeId),
        builder: (context, asyncSnapshot) {
          switch (asyncSnapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
              return const CenteredProgressIndicator();
            case ConnectionState.done:
              if (asyncSnapshot.hasData) {
                final metrics = asyncSnapshot.data;
                if (metrics == null) {
                  return Center(child: Text('No data'));
                }
                return Scaffold(
                  appBar: AppBar(title: Text(metrics.storeName)),
                  body: SingleChildScrollView(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        WithdrawalWalletCard(
                          walletId: 'fac-k6HP8ZFwm6z6Et1j9Db95ruEY4S',
                        ),
                        SizedBox(height: 20),

                        StoreMetricCard(
                          title: 'Revenue',
                          value: 'NLe ${metrics.totalNetPayoutAllTime}',
                          icon: Icons.monetization_on,
                        ),

                        StoreMetricCard(
                          title: 'Total Products Offers',
                          value: metrics.totalOffers.toString(),
                          icon: Icons.shopping_bag,
                          trailing: PrimaryActionButton(
                            label: 'Manage',
                            isExtended: false,
                            onPressed: onManageProductsTap,
                          ),
                        ),

                        SizedBox(height: 30),
                        StatusOverviewSection(
                          title: 'Order Overview',
                          amountHeld: metrics.netPayoutEscrow,
                          items: [
                            StatusItemData(
                              label: 'Pending',
                              value: metrics.totalPendingItems.toString(),
                              icon: Icon(
                                Icons.access_time,
                                color: Colors.amber,
                              ),
                            ),
                            StatusItemData(
                              label: 'Out for Delivery',
                              value: metrics.totalOutForDeliveryProxy
                                  .toString(),
                              icon: Icon(
                                Icons.local_shipping,
                                color: Colors.blue,
                              ),
                            ),
                            StatusItemData(
                              label: 'Approved',
                              value: metrics.totalApprovedItems.toString(),
                              icon: Icon(
                                Icons.check_circle,
                                color: Colors.green,
                              ),
                            ),
                            StatusItemData(
                              label: 'Rejected',
                              value: metrics.totalRejectedItems.toString(),
                              icon: Icon(Icons.cancel, color: Colors.red),
                            ),
                          ],
                          buttonText: 'View Orders',
                          onButtonPressed: onViewOrderTap,
                        ),

                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                );
              } else {
                return ExceptionIndicator();
              }
          }
        },
      ),
    );
  }
}
