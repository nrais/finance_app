import 'package:flutter/material.dart';
import '../widgets/atm_card.dart';
import '../widgets/transaction_item.dart';
import '../models/transaction.dart';
import '../widgets/grid_menu_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _pageController = PageController(
    viewportFraction: 0.88,
    keepPage: true,
  );
  double _currentPage = 0;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() => _currentPage = _pageController.page ?? 0);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final transactions = [
      TransactionModel('Coffee Shop', '-Rp35.000', 'Food'),
      TransactionModel('Grab Ride', '-Rp25.000', 'Travel'),
      TransactionModel('Gym Membership', '-Rp150.000', 'Health'),
      TransactionModel('Movie Ticket', '-Rp60.000', 'Entertainment'),
      TransactionModel('Top Up E-Wallet', '+Rp200.000', 'Top Up'),
    ];

    final cards = [
      AtmCardData(
        holder: 'Ica Siti N.',
        bank: 'Bank Nusantara',
        number: '5213 87•• ••42 1993',
        balance: 'Rp 5.450.000',
        gradient: const [
          Color.fromARGB(255, 69, 120, 144),
          Color.fromARGB(255, 15, 43, 158),
        ],
        logo: Icons.credit_card_rounded,
      ),
      AtmCardData(
        holder: 'Ica Siti N.',
        bank: 'Bank Nusantara - Savings',
        number: '4029 10•• ••77 8842',
        balance: 'Rp 12.730.000',
        gradient: const [
          Color.fromARGB(255, 186, 198, 192),
          Color.fromARGB(255, 9, 61, 28),
        ],
        logo: Icons.savings_rounded,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Finance Mate',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            fontFamily: 'Montserrat',
            letterSpacing: 0.6,
          ),
        ),
      ),

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE8F1FF), Color(0xFFDDEBFF), Color(0xFFFFFFFF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ATM CARDS CAROUSEL
              SizedBox(
                height: 210,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: cards.length,
                  itemBuilder: (context, index) {
                    final t = (index - _currentPage).abs().clamp(0.0, 1.0);
                    final scale = 1 - (t * 0.06);
                    final opacity = 1 - (t * 0.3);

                    return Opacity(
                      opacity: opacity,
                      child: Transform.scale(
                        scale: scale,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: AtmCard(data: cards[index]),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 12),

              // INDICATOR
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(cards.length, (i) {
                  final selected = (i - _currentPage).abs() < 0.5;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    height: 8,
                    width: selected ? 22 : 8,
                    decoration: BoxDecoration(
                      color: selected
                          ? cs.primary
                          : cs.primary.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  );
                }),
              ),

              const SizedBox(height: 24),

              Text(
                'Quick Actions',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
              // SEARCH BAR
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.white.withOpacity(0.15)),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      color: const Color.fromARGB(
                        255,
                        0,
                        0,
                        0,
                      ).withOpacity(0.75),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Search features...',
                          hintStyle: TextStyle(
                            color: const Color.fromARGB(
                              255,
                              0,
                              0,
                              0,
                            ).withOpacity(0.5),
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // GRID MENU
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 4,
                childAspectRatio: 0.9,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                children: const [
                  GridMenuItem(icon: Icons.send_rounded, label: 'Transfer'),
                  GridMenuItem(
                    icon: Icons.phone_iphone_rounded,
                    label: 'Top Up',
                  ),
                  GridMenuItem(
                    icon: Icons.receipt_long_rounded,
                    label: 'Bills',
                  ),
                  GridMenuItem(
                    icon: Icons.qr_code_scanner_rounded,
                    label: 'QR',
                  ),
                  GridMenuItem(icon: Icons.history_rounded, label: 'History'),
                  GridMenuItem(
                    icon: Icons.lock_clock_rounded,
                    label: 'Withdraw',
                  ),
                  GridMenuItem(icon: Icons.savings_rounded, label: 'Deposit'),
                  GridMenuItem(icon: Icons.more_horiz_rounded, label: 'More'),
                ],
              ),

              const SizedBox(height: 24),

              Text(
                'Recent Transactions',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),

              Card(
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: transactions.length,
                  separatorBuilder: (_, __) => Divider(
                    height: 1,
                    color: cs.outlineVariant.withOpacity(.4),
                  ),
                  itemBuilder: (context, index) {
                    return TransactionItem(model: transactions[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
