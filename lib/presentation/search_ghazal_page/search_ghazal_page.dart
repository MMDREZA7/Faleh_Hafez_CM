import 'package:faleh_hafez/presentation/home/components/button.dart';
import 'package:flutter/material.dart';

class SearchGhazalPage extends StatefulWidget {
  const SearchGhazalPage({super.key});

  @override
  State<SearchGhazalPage> createState() => _SearchGhazalPageState();
}

class _SearchGhazalPageState extends State<SearchGhazalPage> {
  TextEditingController searchEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Column(
                children: [
                  // search box
                  Row(
                    children: [
                      Container(
                        width: 130,
                        height: 80,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        child: Center(
                          child: TextField(
                            maxLength: 3,
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                            controller: searchEditingController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: '................',
                              hintStyle: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 48),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Text(
                          'برو به عزل :',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  MyButton(
                    onTap: () {
                      if (searchEditingController.text.isEmpty) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(),
                        );
                      }
                    },
                    text: 'جست و جو کردن',
                    height: 80,
                    width: double.infinity,
                    icon: Icon(
                      Icons.search,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
