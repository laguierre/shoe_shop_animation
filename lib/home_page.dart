import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/provider.dart';
import 'package:shoe_shop_animation/data/data.dart';
import 'package:shoe_shop_animation/models/sizebtn_model.dart';

import 'data/constants.dart';
import 'models/colorbtn_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _pageController = PageController(initialPage: 0);
  bool flagInit = false;
  double currentPage = 0;

  @override
  void initState() {
    _pageController.addListener(pagePosition);
    _initializeColor();
    super.initState();
  }

  Future _initializeColor() async {
    for (int i = 0; i < shoes.length; i++) {
      PaletteGenerator colors =
          await PaletteGenerator.fromImageProvider(AssetImage(shoes[i].images));
      shoes[i].background = colors.dominantColor!.color;
      shoes[i].linearGradientColor1 = colors.dominantColor!.color;
      shoes[i].linearGradientColor2 =
          colors.dominantColor!.color.withAlpha(150);
      shoes[i].logoColor = colors.dominantColor!.color.value <
              const Color(0xFF26231F).value + 100
          ? Colors.grey
          : colors.lightMutedColor!.bodyTextColor;
    }
    setState(() {
      flagInit = true;
    });
  }

  @override
  void dispose() {
    _pageController.removeListener(pagePosition);
    _pageController.dispose();
    super.dispose();
  }

  void pagePosition() {
    setState(() {
      currentPage = _pageController.page!;
    });
    //print(pos);
  }

  @override
  Widget build(BuildContext context) {
    int numberSize = Provider.of<SizeButtonModel>(context).number;
    int numberColor = Provider.of<ColorButtonModel>(context).number;
    var size = MediaQuery.of(context).size;

    if (!flagInit) {
      return const MyCircularProgress();
    }
    return SafeArea(
        child: Scaffold(
      extendBody: true,
      body: FutureBuilder(
          future: Future.value(true),
          builder: (context, AsyncSnapshot<void> snap) {
            return PageView.builder(
              physics: const BouncingScrollPhysics(),
              controller: _pageController,
              itemCount: shoes.length,
              itemBuilder: (BuildContext context, int index) {
                final result = currentPage - index;
                double value = (-1 * result * result + 1).clamp(0, 1);
                return Column(
                  children: [
                    Container(
                        width: double.infinity,
                        height: size.height * 0.60,
                        color: Colors.transparent,
                        child: Stack(
                          children: [
                            Container(
                              alignment: Alignment.bottomCenter,
                              width: double.infinity,
                              height: size.height * 0.45,
                              decoration: BoxDecoration(
                                  color: shoes[index].background,
                                  borderRadius: const BorderRadius.only(
                                      bottomRight: Radius.circular(0),
                                      bottomLeft: Radius.circular(0))),
                            ),
                            Positioned(
                                left: 0,
                                top: size.height * 0.12,
                                child: Transform.translate(
                                  offset: index != result
                                      ? Offset((1 - value) * 300, 0)
                                      : Offset((1 - value) * -600, 0),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    height: 130,
                                    width: size.width,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AutoSizeText(shoes[index].title,
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700,
                                                color: shoes[index].logoColor)),
                                        const SizedBox(height: 10),
                                        AutoSizeText(
                                          shoes[index].description,
                                          style: TextStyle(
                                              fontSize: 14,
                                              overflow: TextOverflow.ellipsis,
                                              color: shoes[index].logoColor),
                                          minFontSize: 13,
                                          maxLines: 6,
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                            Positioned(
                                child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 60),
                              alignment: Alignment.bottomCenter,
                              child: Opacity(
                                opacity: value,
                                child: Transform.scale(
                                  scale: index != result ? value : 1,
                                  child: Image.asset(shoes[index].images,
                                      fit: BoxFit.contain),
                                )..transform.rotateZ((1 - value) + 0.2),
                              ),
                            )),
                            Positioned(
                                top: 0,
                                left: 0,
                                child: Opacity(
                                  opacity: value,
                                  child: SizedBox(
                                    width: size.width * 0.4,
                                    height: size.height * 0.115,
                                    child: Image.asset(
                                      shoes[index].brand,
                                      fit: BoxFit.scaleDown,
                                      color: shoes[index].logoColor,
                                    ),
                                  ),
                                )),
                          ],
                        )),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: kPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            SizedBox(
                              width: size.width * 0.63,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AutoSizeText(
                                    shoes[index].title.toUpperCase(),
                                    style: const TextStyle(fontSize: 27),
                                    //minFontSize: 16,
                                    maxLines: 1,
                                  ),
                                  Text('Running collection'.toUpperCase(),
                                      style: const TextStyle(
                                          fontSize: 20, color: Colors.grey)),
                                ],
                              ),
                            ),
                            const Spacer(),
                            LinearGradientButton(
                              text: 'NEW',
                              linearGradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    shoes[index].linearGradientColor1,
                                    shoes[index].linearGradientColor2,
                                  ]),
                            )
                          ]),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              for (int i = 0; i < shoes[index].rate; ++i)
                                const Icon(Icons.star)
                            ],
                          ),
                          const SizedBox(height: 15),
                          const Text('SIZE',
                              style: TextStyle(
                                  letterSpacing: 1.2,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700)),
                          const SizedBox(height: 10),
                          Row(children: [
                            for (int i = 0; i < 5; ++i) ...[
                              InkWell(
                                borderRadius: BorderRadius.circular(35),
                                onTap: () {
                                  Provider.of<SizeButtonModel>(context,
                                          listen: false)
                                      .number = i;
                                },
                                child: CircleButton(
                                  text: (i + 7).toString(),
                                  color: numberSize != i
                                      ? Colors.white
                                      : Colors.grey,
                                  textColor: numberSize == i
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              const SizedBox(width: 10),
                            ]
                          ]),
                          const SizedBox(height: 15),
                          const Text('COLOR',
                              style: TextStyle(
                                  letterSpacing: 1.2,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: kPadding),
                      child: Row(children: [
                        for (int i = 0; i < 3; i++) ...[
                          InkWell(
                            borderRadius: BorderRadius.circular(35),
                            onTap: () {
                              Provider.of<ColorButtonModel>(context,
                                      listen: false)
                                  .number = i;
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  border: numberColor == i
                                      ? Border.all(color: colors[i], width: 2)
                                      : null,
                                  shape: BoxShape.circle,
                                  color: Colors.white),
                              child: Stack(
                                children: [
                                  Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                      color: colors[i],
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 10)
                        ],
                        const Spacer(),
                        LinearGradientButton(
                          linearGradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                shoes[index].linearGradientColor1,
                                shoes[index].linearGradientColor2,
                              ]),
                          text: 'USD 135',
                          topLeft: 8,
                          bottomLeft: 8,
                          topRight: 0,
                          bottomRight: 0,
                        ),
                      ]),
                    ),
                  ],
                );
              },
            );
          }),
    ));
  }
}

class LinearGradientButton extends StatelessWidget {
  const LinearGradientButton({
    Key? key,
    this.height = 40.0,
    this.width = 80.0,
    required this.text,
    this.topLeft = 8.0,
    this.topRight = 8.0,
    this.bottomLeft = 8.0,
    this.bottomRight = 8.0,
    this.linearGradient = const LinearGradient(colors: [
      Color(0xFF608DB9),
      Color(0xFF6596C5),
    ]),
  }) : super(key: key);
  final height;
  final width;
  final String text;
  final double topLeft, topRight, bottomLeft, bottomRight;
  final LinearGradient linearGradient;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      alignment: Alignment.center,
      height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(topLeft),
              topRight: Radius.circular(topRight),
              bottomLeft: Radius.circular(bottomLeft),
              bottomRight: Radius.circular(bottomRight)),
          gradient: linearGradient),
      child: Text(
        text,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class CircleButton extends StatelessWidget {
  const CircleButton(
      {Key? key,
      this.size = 35,
      this.text = '',
      this.color = Colors.grey,
      this.textColor = Colors.black})
      : super(key: key);
  final String text;
  final double size;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: size,
      width: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: Text(
        text,
        style: TextStyle(color: textColor),
      ),
    );
  }
}

///Circular Progress Bar when BackGround Colors is calculated///
class MyCircularProgress extends StatelessWidget {
  const MyCircularProgress({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(flex: 2, child: Container()),
            Column(
              children: const [
                Text("Loading...", style: TextStyle(fontSize: 20)),
                SizedBox(height: 10),
                CircularProgressIndicator(),
                SizedBox(height: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
