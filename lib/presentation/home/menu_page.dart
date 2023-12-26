import 'package:faleh_hafez/application/omen_list/omen_list_bloc.dart';
import 'package:faleh_hafez/presentation/home/components/Quick_guide_dialog.dart';
import 'package:faleh_hafez/presentation/home/components/button.dart';
import 'package:faleh_hafez/presentation/home/components/my_drawer.dart';
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
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => const QuickGuideDialog(
                  text:
                      'برای عوض کردن تِم برنامه ، میتوانید به منوی سمت چپ صفحه مراجعه کنید و سپس دکمه "عوض کردن تِم"را کلیک کنید',
                ),
              );

              showDialog(
                context: context,
                builder: (context) => const QuickGuideDialog(
                  text:
                      "همچنین شما میتوانید در منوی سمت چب صفحه درباره اپلیکشین (فال حافظ) بیشتر بدانید",
                ),
              );

              showDialog(
                context: context,
                builder: (context) => const QuickGuideDialog(
                  text:
                      'برای استفاده از برنامه، شما باید دکمه ی پایین صفحه را فشار دهید و سپس منتظر بمانید تا فال شما نمایان شود',
                ),
              );
            },
            icon: Icon(
              Icons.help,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ],
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'فال حافظ',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onPrimary,
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
                  color: Theme.of(context).colorScheme.onPrimary,
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
                          gradient: LinearGradient(
                            begin: const Alignment(-1, -1),
                            end: const Alignment(1, 1),
                            colors: [
                              Theme.of(context).colorScheme.primaryContainer,
                              Theme.of(context).colorScheme.onPrimaryContainer,
                            ],
                          ),
                        ),

                        //* user's omen
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 35,
                              horizontal: 10,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // faleh hafez image
                                Image.asset(
                                  'assets/images/Faleh_Hafez (2).jpg',
                                  cacheHeight: 200,
                                ),

                                // First Contaner
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    border: Border.all(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondary,
                                      width: 10,
                                    ),
                                  ),

                                  // Secend Container
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      border: Border.all(
                                        width: 10,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSecondary,
                                      ),
                                    ),
                                    child: Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: Text(
                                        state.omen.omenText,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'vazir',
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSecondary,
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
                      text: 'برای دریافت فال دیگر کلیک کنید',
                      height: 80,
                      width: double.infinity,
                      icon: Icon(
                        Icons.get_app,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
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
                    icon: Icon(
                      Icons.get_app,
                      color: Theme.of(context).colorScheme.onPrimary,
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
