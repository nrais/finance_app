import 'package:flutter/material.dart';

class AtmCardData {
  final String holder;
  final String bank;
  final String number;
  final String balance;
  final List<Color> gradient;
  final IconData logo;

  AtmCardData({
    required this.holder,
    required this.bank,
    required this.number,
    required this.balance,
    required this.gradient,
    required this.logo,
  });
}

class AtmCard extends StatelessWidget {
  final AtmCardData data;
  const AtmCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: const [
            Color(0xFF4A90E2),
            Color(0xFF6FB1FC),
            Color(0xFF1E3C72),
          ],
          stops: const [0.0, 0.5, 1.0],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: data.gradient.last.withOpacity(0.35),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bank + logo
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  data.bank,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    letterSpacing: .4,
                  ),
                ),
                Icon(
                  data.logo,
                  color: Colors.white.withOpacity(0.95),
                  size: 28,
                ),
              ],
            ),
            const SizedBox(height: 18),

            // Chip + NFC glyph
            Row(
              children: [
                Container(
                  width: 38,
                  height: 28,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.85),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                const SizedBox(width: 10),
                Icon(
                  Icons.wifi_tethering,
                  size: 20,
                  color: Colors.white.withOpacity(.9),
                ),
              ],
            ),
            const Spacer(),

            // Card number
            Text(
              data.number,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                letterSpacing: 2,
                fontFeatures: [FontFeature.tabularFigures()],
              ),
            ),

            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _kv('Card Holder', data.holder),
                _kv('Balance', data.balance, alignEnd: true),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _kv(String k, String v, {bool alignEnd = false}) {
    return Column(
      crossAxisAlignment: alignEnd
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        Text(
          k,
          style: TextStyle(color: Colors.white.withOpacity(.8), fontSize: 11),
        ),
        const SizedBox(height: 2),
        Text(
          v,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
