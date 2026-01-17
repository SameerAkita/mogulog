import 'package:flutter/material.dart';
import 'package:mogulog/theme/app_colors.dart';
import 'package:mogulog/widgets/food_item/macro_card_widget.dart';

class FoodItemPage extends StatefulWidget {
  final String image;

  const FoodItemPage({super.key, required this.image});

  @override
  State<FoodItemPage> createState() => _FoodItemPageState();
}

class _FoodItemPageState extends State<FoodItemPage> {
  void handleDone(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  bool showDetailsContainer = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Meal', style: TextStyle(color: Colors.white)),

        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: Image.asset(widget.image, fit: BoxFit.cover),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.55,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
              ),

              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) {
                  final offsetAnimation = Tween<Offset>(
                    begin: const Offset(0, 1),
                    end: Offset.zero,
                  ).animate(animation);

                  return SlideTransition(
                    position: offsetAnimation,
                    child: child,
                  );
                },
                child: showDetailsContainer
                    ? _detailsContainer(context)
                    : _fixResultsContainer(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _detailsContainer(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 28),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Oyakodon',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),

          Expanded(
            child: Center(
              child: GridView.count(
                padding: EdgeInsets.zero,
                primary: false,
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 2.3,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: const [
                  MacroCardWidget(
                    iconData: Icons.local_fire_department,
                    color: Colors.black,
                    title: 'Calories',
                    amount: 200,
                  ),
                  MacroCardWidget(
                    iconData: Icons.egg_alt,
                    color: AppColors.protein,
                    title: 'Protein',
                    amount: 200,
                  ),
                  MacroCardWidget(
                    iconData: Icons.water_drop,
                    color: AppColors.fats,
                    title: 'Fats',
                    amount: 200,
                  ),
                  MacroCardWidget(
                    iconData: Icons.cookie,
                    color: AppColors.carbs,
                    title: 'Carbs',
                    amount: 200,
                  ),
                ],
              ),
            ),
          ),

          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    setState(() {
                      showDetailsContainer = false;
                    });
                  },
                  style: ButtonStyle(
                    textStyle: WidgetStateProperty.all(TextStyle(fontSize: 16)),
                    padding: WidgetStateProperty.all(
                      EdgeInsets.symmetric(vertical: 14),
                    ),
                    foregroundColor: WidgetStateProperty.all(Colors.black),
                    overlayColor: WidgetStateProperty.resolveWith((states) {
                      if (states.contains(WidgetState.pressed)) {
                        return Colors.black.withAlpha(25);
                      }
                      return null;
                    }),
                    splashFactory: NoSplash.splashFactory,
                  ),

                  child: Text(
                    'Fix Results',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: TextButton(
                  onPressed: () {
                    handleDone(context);
                  },
                  style: ButtonStyle(
                    textStyle: WidgetStateProperty.all(TextStyle(fontSize: 16)),
                    padding: WidgetStateProperty.all(
                      EdgeInsets.symmetric(vertical: 14),
                    ),
                    backgroundColor: WidgetStateProperty.all(Colors.black),
                    foregroundColor: WidgetStateProperty.all(Colors.white),
                    overlayColor: WidgetStateProperty.resolveWith((states) {
                      if (states.contains(WidgetState.pressed)) {
                        return Colors.white.withAlpha(100);
                      }
                      return null;
                    }),
                    splashFactory: NoSplash.splashFactory,
                  ),
                  child: Text(
                    'Done',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _fixResultsContainer(BuildContext context) {
    return Container(color: Colors.red, child: Text('fix resuldts'));
  }
}
