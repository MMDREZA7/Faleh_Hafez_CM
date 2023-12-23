import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:faleh_hafez/domain/omen_model.dart';
import 'package:flutter/material.dart';

part 'omen_list_event.dart';
part 'omen_list_state.dart';

List<Omen> omenList = [
  //* good omens
  // 1
  Omen(
    omenText:
        'روز‌های زیبا و شادی برای شما فراخواهد آمد. امیدوار باشید و به رویاهایتان پایبند بمانید، آن‌ها در کوتاه‌ترین زمان ممکن به واقعیت تبدیل خواهند شد.',
  ),
  // 2
  Omen(
    omenText:
        'شما در مسیری هستید که به سوی موفقیت و رضایت بیشتر از زندگی می‌برد. افکار مثبت خود را حفظ کنید و با انرژی مثبتتان، به سمت دستاوردهای بزرگ حرکت کنید.',
  ),
  // 3
  Omen(
    omenText:
        'هر روز با افکار مثبت و انرژی خود را شارژ کنید، چرا که آینده‌ای درخشان در انتظار شماست. با پشتکار و تلاش مداوم، به دستاوردهای بیشتری دست خواهید یافت.',
  ),

  //* bad omens
  // 1
  Omen(
    omenText:
        'ممکن است در روزهای آینده با چالش‌ها و موانعی روبه‌رو شوید. اما به یاد داشته باشید که هر چالشی فرصتی برای رشد و یادگیری نیز می‌باشد.',
  ),
  // 2
  Omen(
    omenText:
        'انرژی منفی ممکن است در اطراف شما حضور داشته باشد. سعی کنید از آن دوری کنید و به جای آن، به افراد و اتفاقات مثبت توجه کنید تا از برخوردهای مثبت بهره‌مند شوید.',
  ),
  // 3
  Omen(
    omenText:
        'احتمال وقوع موضوعات ناخوشایندی وجود دارد، اما این موضوعات یک دوران محدودی را در بر خواهند داشت. سعی کنید با ثابت قدمی و حل مسائل به سرعت از این وضعیت عبور کنید.',
  ),

  //* nitral omens
  // 1
  Omen(
    omenText:
        'آینده همواراً پر از چالش‌ها و فرصت‌هاست. هر چیزی که در پیش روی شماست، با وابستگی به تصمیمات و اقدامات شماست.',
  ),
// 2
  Omen(
    omenText:
        'زندگی همواره با اتفاقات مختلفی پر است که نه همیشه مثبت و نه همیشه منفی هستند. مهمترین نکته این است که چگونه با آن‌ها برخورد می‌کنید.',
  ),
  // 3
  Omen(
    omenText:
        'تغییراتی در راه است که ممکن است برای شما مهم باشند، اما احتمالاً نه همیشه از نظر مثبت یا منفی. هرچیزی به دور از این دو قطبیت می‌تواند باشد.',
  ),
];

class OmenListBloc extends Bloc<OmenListEvent, OmenListState> {
  OmenListBloc() : super(OmenListInitial()) {
    on<OmenListShowOmenEvent>((event, emit) async {
      emit(OmenListLoading());

      final Random random = Random();
      final int randomIndex = random.nextInt(omenList.length);
      final selectedOmen = omenList[randomIndex];

      await Future.delayed(
        const Duration(
          seconds: 2,
        ),
      );

      emit(
        OmenListLoaded(
          omen: selectedOmen,
        ),
      );
    });
  }
}
