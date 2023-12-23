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
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.green[900],
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
      backgroundColor: Colors.green[800],
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: BlocBuilder<OmenListBloc, OmenListState>(
            builder: (context, state) {
              if (state is OmenListLoading) {
                return CircularProgressIndicator(
                  color: Colors.green[900],
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
                          child: Expanded(
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
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.green.shade900,
                                    ),
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.green,
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.all(25),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Colors.green.shade900,
                                        ),
                                      ),
                                      child: Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: Text(
                                          state.omen.omenText,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 35,
                                            fontFamily: 'iranNastaliq',
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
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
                      boxColor: Colors.green[900],
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
                      color: Colors.green[300],
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
                    boxColor: Colors.green[900],
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
