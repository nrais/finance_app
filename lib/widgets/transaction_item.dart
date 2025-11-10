import 'package:flutter/material.dart';
import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  final TransactionModel model;
  const TransactionItem({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isMinus = model.amount.trim().startsWith('-');

    IconData icon;
    switch (model.category.toLowerCase()) {
      case 'food':
        icon = Icons.fastfood_rounded;
        break;
      case 'travel':
        icon = Icons.pedal_bike_rounded;
        break;
      case 'health':
        icon = Icons.health_and_safety_rounded;
        break;
      case 'entertainment':
        icon = Icons.movie_rounded;
        break;
      case 'top up':
        icon = Icons.phone_iphone_rounded;
        break;
      default:
        icon = Icons.payments_rounded;
    }

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: CircleAvatar(
        radius: 22,
        backgroundColor: (isMinus ? cs.error : cs.primary).withOpacity(.12),
        child: Icon(
          isMinus ? Icons.south_west_rounded : Icons.north_east_rounded,
          color: isMinus ? cs.error : cs.primary,
        ),
      ),
      title: Text(
        model.title,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(model.category),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            model.amount,
            style: TextStyle(
              color: isMinus ? cs.error : cs.primary,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            _fmtDate(model.date),
            style: TextStyle(color: cs.onSurfaceVariant, fontSize: 11),
          ),
        ],
      ),
    );
  }

  String _fmtDate(DateTime d) {
    String two(int n) => n.toString().padLeft(2, '0');
    return '${two(d.day)}/${two(d.month)}/${d.year}';
  }
}
