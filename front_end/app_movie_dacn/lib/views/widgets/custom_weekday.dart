import 'package:app_movie/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class CustomWeekday extends StatefulWidget {
  dynamic weekday;
  void Function()? onTap;
  bool checked;

  CustomWeekday({
    super.key,
    required this.weekday,
    required this.onTap,
    required this.checked,
  });

  @override
  State<CustomWeekday> createState() => _CustomWeekdayState();
}

class _CustomWeekdayState extends State<CustomWeekday> {
  dynamic weekday;
  bool checked = false;

  @override
  void initState() {
    super.initState();
    weekday = widget.weekday;
    checked = widget.checked;
  }

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat('yyy-MM-dd');
    DateTime date = dateFormat.parse(weekday['date']);
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: BoxDecoration(
          gradient: !checked 
          ? LinearGradient(
            colors: [ 
              const Color(0xFFD7F3F6).withOpacity(.6), 
              const Color(0xFFF2F2F2)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter
          )
          : LinearGradient(
            colors: [ 
              const Color(0xFFFED5B4), 
              const Color(0xFFC94044).withOpacity(.46)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(8)
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              weekday['name'],
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: !checked ? button1 : Colors.white,
                fontWeight: FontWeight.w700
              ),
            ),
            const SizedBox(height: 4),
            Container(
              height: 1,
              width: 28,
              color: button2.withOpacity(.42),
            ),
            const SizedBox(height: 8),
            Text(
              date.day < 10 ? '0${date.day.toString()}' : date.day.toString(),
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: !checked ? button1 : Colors.white,
                fontSize: 18
              ),
            ),
          ],
        ),
      ),
    );
  }
}