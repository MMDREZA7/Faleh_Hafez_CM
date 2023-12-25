import 'package:faleh_hafez/application/omen_list/omen_list_bloc.dart';
import 'package:faleh_hafez/presentation/home/my_button.dart';
import 'package:faleh_hafez/presentation/home/my_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: AppBar(
        iconTheme:
            IconThemeData(color: Theme.of(context).colorScheme.secondary),
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'فال حافظ',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: BlocBuilder<OmenListBloc, OmenListState>(
            builder: (context, state) {
              if (state is OmenListLoading) {
                return CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.primary,
                );
              }
              if (state is OmenListLoaded) {
                return Column(
                  children: [
                    // logo
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 15),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: const LinearGradient(
                            begin: Alignment(0, 0),
                            end: Alignment(1, 1),
                            colors: [
                              Colors.green,
                              Colors.yellow,
                            ],
                          ),
                        ),
                        child: Center(
                          child: ListView(
                            children: [
                              // faleh hafez image
                              Image.asset(
                                'assets/images/Faleh_Hafez (2).jpg',
                              ),

                              const SizedBox(height: 10),

                              // omen text
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                padding: const EdgeInsets.all(25),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  border: Border.all(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.all(25),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      border: Border.all(
                                        color: Colors.green.shade900,
                                      ),
                                    ),
                                    child: Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: Text(
                                        state.omen.omenText,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'vazir',
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // give user's omen button for second time
                    MyButton(
                      onTap: () {
                        context
                            .read<OmenListBloc>()
                            .add(OmenListShowOmenEvent());
                      },
                      text: 'گرفتن فال مجدد',
                      height: 80,
                      width: double.infinity,
                      boxColor: Theme.of(context).colorScheme.primary,
                      textColor: Colors.white,
                      icon: const Icon(Icons.get_app),
                    ),
                  ],
                );
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // logo
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 80),
                    child: Image.asset(
                      'assets/icon/letter-f.png',
                      color: Theme.of(context).colorScheme.onBackground,
                      cacheHeight: 450,
                    ),
                  ),

                  // give user's omen button for first time
                  MyButton(
                    onTap: () {
                      context.read<OmenListBloc>().add(
                            OmenListShowOmenEvent(),
                          );
                    },
                    text: 'ابتدا نیت کنید و سپس کلیک کنید',
                    height: 80,
                    width: double.infinity,
                    boxColor: Theme.of(context).colorScheme.primary,
                    textColor: Colors.white,
                    icon: const Icon(
                      Icons.get_app,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
