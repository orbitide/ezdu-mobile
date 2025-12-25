import 'package:flutter/material.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("EzDu Shop"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Try for Free",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              "Start your EzDu journey with free XP and rewards.",
              style: TextStyle(color: Colors.grey[700]),
            ),
            const SizedBox(height: 24),

            // Subscription Section
            const Text(
              "Subscriptions",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              children: const [
                Expanded(
                  child: SubscriptionCard(
                    title: "Pro",
                    price: "৳299 / mo",
                    features: [
                      {"name": "No ads", "included": true},
                      {"name": "Explanations", "included": true},
                      {"name": "1 Quiz per day", "included": true},
                      {"name": "Exclusive quiz", "included": true},
                      {"name": "streak freeze", "included": false},
                      {"name": "Offline mode", "included": false},
                      {"name": "Study E-books", "included": false},
                    ],
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: SubscriptionCard(
                    title: "Max",
                    price: "৳499 / mo",
                    features: [
                      {"name": "No ads", "included": true},
                      {"name": "Explanations", "included": true},
                      {"name": "Unlimited Quiz", "included": true},
                      {"name": "Exclusive quiz", "included": true},
                      {"name": "streak freeze", "included": true},
                      {"name": "Offline mode", "included": true},
                      {"name": "Study E-books", "included": true},
                    ],
                  ),
                ),
              ],
            ),


            const SizedBox(height: 32),

            // Power-Ups Section
            const Text(
              "Power-Ups",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: const [
                PowerUpCard(
                  title: "XP Boost",
                  description: "Double your XP for 15 mins.",
                  cost: "150 💎",
                  icon: Icons.trending_up,
                ),
                PowerUpCard(
                  title: "Streak Freeze",
                  description: "Protect your streak for one day.",
                  cost: "100 💎",
                  icon: Icons.ac_unit,
                ),
                PowerUpCard(
                  title: "Time Boost",
                  description: "Add +30s for quiz challenges.",
                  cost: "120 💎",
                  icon: Icons.timer,
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Gem Pack Section
            const Text(
              "Gem Packs",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Column(
              children: const [
                GemPackCard(amount: "500 💎", price: "৳99"),
                GemPackCard(amount: "1200 💎", price: "৳199"),
                GemPackCard(amount: "3000 💎", price: "৳399"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SubscriptionCard extends StatelessWidget {
  final String title;
  final String price;
  final List<Map<String, dynamic>> features;

  const SubscriptionCard({
    super.key,
    required this.title,
    required this.price,
    required this.features,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(price, style: TextStyle(color: Colors.grey[700], fontSize: 14)),
            const Divider(height: 16),
            ...features.map((f) {
              final included = f["included"] as bool;
              return Row(
                children: [
                  Icon(
                    included ? Icons.check_circle : Icons.cancel,
                    color: included ? Colors.green : Colors.grey,
                    size: 18,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      f["name"],
                      style: TextStyle(
                        fontSize: 14,
                        color: included ? Colors.black : Colors.grey,
                        decoration: included ? null : TextDecoration.lineThrough,
                      ),
                    ),
                  ),
                ],
              );
            }),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(36),
              ),
              child: const Text("Subscribe"),
            ),
          ],
        ),
      ),
    );
  }
}


class PowerUpCard extends StatelessWidget {
  final String title;
  final String description;
  final String cost;
  final IconData icon;

  const PowerUpCard({
    super.key,
    required this.title,
    required this.description,
    required this.cost,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 5, offset: const Offset(0, 2))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 32, color: Theme.of(context).primaryColor),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 4),
          Text(description, style: TextStyle(color: Colors.grey[700], fontSize: 12)),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(cost, style: const TextStyle(fontWeight: FontWeight.bold)),
              IconButton(
                icon: const Icon(Icons.add_shopping_cart, size: 18),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class GemPackCard extends StatelessWidget {
  final String amount;
  final String price;

  const GemPackCard({super.key, required this.amount, required this.price});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: const Icon(Icons.diamond, color: Colors.blueAccent),
        title: Text(amount),
        trailing: ElevatedButton(
          onPressed: () {},
          child: Text(price),
        ),
      ),
    );
  }
}
