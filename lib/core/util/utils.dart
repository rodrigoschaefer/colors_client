import 'package:flutter/material.dart';
import 'package:web3dart/web3dart.dart';
import 'package:intl/intl.dart';

class Utils {
  static dynamic navigateToPage(context, Widget page,
      {bool fullscreen = false, String? routeName}) async {
    return await Navigator.push(
      context,
      routeName == null
          ? MaterialPageRoute(
              fullscreenDialog: fullscreen,
              builder: (BuildContext context) {
                return page;
              })
          : MaterialPageRoute(
              builder: (_) {
                return page;
              },
              settings: RouteSettings(
                name: routeName,
              ),
            ),
    );
  }

  static BigInt weiToEther(wei) {
    return EtherAmount.fromUnitAndValue(EtherUnit.wei, wei).getInEther;
  }

  static BigInt etherToWei(ether) {
    return EtherAmount.fromUnitAndValue(EtherUnit.ether, ether).getInWei;
  }

  static String formatDateTime(context, date) {
    if (date == null) return '-';
    return DateFormat.yMMMd(Localizations.localeOf(context).languageCode)
        .format(date);
  }
}
