import 'dart:ui' as ui;
import 'package:flutter/material.dart';

CustomPaint metaLogo(double width) {
  return CustomPaint(
    size: Size(
      width,
      (width * 0.48716379413048094).toDouble(),
    ),
    painter: RPSCustomPainter(),
  );
}

//Copy this CustomPainter code to the Bottom of the File
class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_1 = Path();
    path_1.moveTo(size.width * 0.1966055, size.height * 0.6036527);
    path_1.cubicTo(
        size.width * 0.1914474,
        size.height * 0.6252964,
        size.width * 0.1840819,
        size.height * 0.6559426,
        size.width * 0.1755745,
        size.height * 0.6605085);
    path_1.cubicTo(
        size.width * 0.1367087,
        size.height * 0.6813540,
        size.width * 0.1535702,
        size.height * 0.3959717,
        size.width * 0.1857106,
        size.height * 0.3460645);
    path_1.cubicTo(
        size.width * 0.2051205,
        size.height * 0.3159346,
        size.width * 0.2265922,
        size.height * 0.3890115,
        size.width * 0.2327581,
        size.height * 0.4297753);
    path_1.cubicTo(
        size.width * 0.2302825,
        size.height * 0.4519355,
        size.width * 0.2031048,
        size.height * 0.5764102,
        size.width * 0.1966055,
        size.height * 0.6036527);
    path_1.close();
    path_1.moveTo(size.width * 0.1439055, size.height * 0.7114956);
    path_1.cubicTo(
        size.width * 0.1587015,
        size.height * 0.7511444,
        size.width * 0.1806445,
        size.height * 0.7475645,
        size.width * 0.1935972,
        size.height * 0.7194652);
    path_1.cubicTo(
        size.width * 0.2015451,
        size.height * 0.7022231,
        size.width * 0.2077187,
        size.height * 0.6788892,
        size.width * 0.2138617,
        size.height * 0.6527266);
    path_1.cubicTo(
        size.width * 0.2254923,
        size.height * 0.6032301,
        size.width * 0.2349501,
        size.height * 0.5444494,
        size.width * 0.2451322,
        size.height * 0.4911970);
    path_1.cubicTo(
        size.width * 0.2502558,
        size.height * 0.5012089,
        size.width * 0.2598592,
        size.height * 0.5587220,
        size.width * 0.2629824,
        size.height * 0.5749079);
    path_1.cubicTo(
        size.width * 0.2683628,
        size.height * 0.6028076,
        size.width * 0.2736435,
        size.height * 0.6313411,
        size.width * 0.2807982,
        size.height * 0.6599685);
    path_1.cubicTo(
        size.width * 0.2879452,
        size.height * 0.6885725,
        size.width * 0.2945940,
        size.height * 0.7138430,
        size.width * 0.3041859,
        size.height * 0.7281509);
    path_1.cubicTo(
        size.width * 0.3149581,
        size.height * 0.7442193,
        size.width * 0.3328965,
        size.height * 0.7447945,
        size.width * 0.3419097,
        size.height * 0.7257213);
    path_1.cubicTo(
        size.width * 0.3731419,
        size.height * 0.6847226,
        size.width * 0.3660639,
        size.height * 0.4795887,
        size.width * 0.3499573,
        size.height * 0.3820630);
    path_1.cubicTo(
        size.width * 0.3256498,
        size.height * 0.2348529,
        size.width * 0.2903939,
        size.height * 0.2480223,
        size.width * 0.2721605,
        size.height * 0.2837743);
    path_1.cubicTo(
        size.width * 0.2623501,
        size.height * 0.3030118,
        size.width * 0.2559887,
        size.height * 0.3350313,
        size.width * 0.2491215,
        size.height * 0.3565929);
    path_1.cubicTo(
        size.width * 0.2451628,
        size.height * 0.3439283,
        size.width * 0.2343370,
        size.height * 0.2958755,
        size.width * 0.2167512,
        size.height * 0.2724477);
    path_1.cubicTo(
        size.width * 0.2089757,
        size.height * 0.2620954,
        size.width * 0.2002000,
        size.height * 0.2574121,
        size.width * 0.1917424,
        size.height * 0.2596305);
    path_1.cubicTo(
        size.width * 0.1574522,
        size.height * 0.2686565,
        size.width * 0.1375403,
        size.height * 0.3893753,
        size.width * 0.1309260,
        size.height * 0.4799761);
    path_1.cubicTo(
        size.width * 0.1286803,
        size.height * 0.5106927,
        size.width * 0.1273812,
        size.height * 0.5483579,
        size.width * 0.1277069,
        size.height * 0.5843682);
    path_1.cubicTo(
        size.width * 0.1281323,
        size.height * 0.6316698,
        size.width * 0.1319492,
        size.height * 0.6794643,
        size.width * 0.1439055,
        size.height * 0.7114956);
    path_1.close();
    path_1.moveTo(size.width * 0.3352264, size.height * 0.6456607);
    path_1.cubicTo(
        size.width * 0.3178667,
        size.height * 0.7066363,
        size.width * 0.2977670,
        size.height * 0.5931595,
        size.width * 0.2918271,
        size.height * 0.5639100);
    path_1.lineTo(size.width * 0.2613767, size.height * 0.4113829);
    path_1.cubicTo(
        size.width * 0.2693860,
        size.height * 0.3774854,
        size.width * 0.2760769,
        size.height * 0.3430480,
        size.width * 0.2896696,
        size.height * 0.3279302);
    path_1.cubicTo(
        size.width * 0.3311567,
        size.height * 0.2817554,
        size.width * 0.3527777,
        size.height * 0.5840043,
        size.width * 0.3352264,
        size.height * 0.6456607);
    path_1.close();

    Paint paint_1_fill = Paint()..style = PaintingStyle.fill;
    paint_1_fill.shader = ui.Gradient.linear(
        Offset(size.width * 0.3524252, size.height * 0.5184629),
        Offset(size.width * 0.1355246, size.height * 0.4752694), [
      Color(0xffEE3A4C).withOpacity(1),
      Color(0xffF16350).withOpacity(1),
      Color(0xffEE374C).withOpacity(1),
      Color(0xffFEC15B).withOpacity(1)
    ], [
      0,
      0.34902,
      0.670588,
      1
    ]);
    canvas.drawPath(path_1, paint_1_fill);

    Path path_2 = Path();
    path_2.moveTo(size.width * 0.6002935, size.height * 0.5436513);
    path_2.cubicTo(
        size.width * 0.6031255,
        size.height * 0.4381793,
        size.width * 0.6515143,
        size.height * 0.4241062,
        size.width * 0.6550284,
        size.height * 0.5437569);
    path_2.lineTo(size.width * 0.6002935, size.height * 0.5436513);
    path_2.close();
    path_2.moveTo(size.width * 0.4165335, size.height * 0.7390080);
    path_2.lineTo(size.width * 0.4393464, size.height * 0.7393366);
    path_2.lineTo(size.width * 0.4394192, size.height * 0.4116294);
    path_2.lineTo(size.width * 0.4828185, size.height * 0.6374680);
    path_2.lineTo(size.width * 0.5015961, size.height * 0.6374798);
    path_2.lineTo(size.width * 0.5439377, size.height * 0.4115003);
    path_2.lineTo(size.width * 0.5442404, size.height * 0.7389493);
    path_2.lineTo(size.width * 0.5672296, size.height * 0.7394657);
    path_2.lineTo(size.width * 0.5672833, size.height * 0.3067443);
    path_2.lineTo(size.width * 0.5391437, size.height * 0.3067443);
    path_2.lineTo(size.width * 0.4919352, size.height * 0.5649076);
    path_2.lineTo(size.width * 0.4445696, size.height * 0.3067443);
    path_2.lineTo(size.width * 0.4166216, size.height * 0.3067443);
    path_2.lineTo(size.width * 0.4165335, size.height * 0.7390080);
    path_2.close();
    path_2.moveTo(size.width * 0.8723429, size.height * 0.7287730);
    path_2.lineTo(size.width * 0.8723429, size.height * 0.3946337);
    path_2.lineTo(size.width * 0.8503079, size.height * 0.3946337);
    path_2.lineTo(size.width * 0.8503079, size.height * 0.4414188);
    path_2.cubicTo(
        size.width * 0.8422335,
        size.height * 0.4066645,
        size.width * 0.8273992,
        size.height * 0.3846100,
        size.width * 0.8121242,
        size.height * 0.3846100);
    path_2.cubicTo(
        size.width * 0.7813634,
        size.height * 0.3846100,
        size.width * 0.7593246,
        size.height * 0.4674758,
        size.width * 0.7593246,
        size.height * 0.5617033);
    path_2.cubicTo(
        size.width * 0.7593246,
        size.height * 0.6559309,
        size.width * 0.7813634,
        size.height * 0.7394657,
        size.width * 0.8119096,
        size.height * 0.7394657);
    path_2.cubicTo(
        size.width * 0.8273992,
        size.height * 0.7394657,
        size.width * 0.8422335,
        size.height * 0.7167422,
        size.width * 0.8503079,
        size.height * 0.6826569);
    path_2.lineTo(size.width * 0.8503079, size.height * 0.7287730);
    path_2.lineTo(size.width * 0.8723429, size.height * 0.7287730);
    path_2.close();
    path_2.moveTo(size.width * 0.8503079, size.height * 0.6185004);
    path_2.cubicTo(
        size.width * 0.8452878,
        size.height * 0.6418930,
        size.width * 0.8335077,
        size.height * 0.6733022,
        size.width * 0.8162706,
        size.height * 0.6733022);
    path_2.cubicTo(
        size.width * 0.7968530,
        size.height * 0.6733022,
        size.width * 0.7818003,
        size.height * 0.6218456,
        size.width * 0.7818003,
        size.height * 0.5617033);
    path_2.cubicTo(
        size.width * 0.7818003,
        size.height * 0.5015611,
        size.width * 0.7968530,
        size.height * 0.4507735,
        size.width * 0.8162706,
        size.height * 0.4507735);
    path_2.cubicTo(
        size.width * 0.8335077,
        size.height * 0.4507735,
        size.width * 0.8452878,
        size.height * 0.4815137,
        size.width * 0.8503079,
        size.height * 0.5055752);
    path_2.lineTo(size.width * 0.8503079, size.height * 0.6185004);
    path_2.close();
    path_2.moveTo(size.width * 0.7532698, size.height * 0.6608254);
    path_2.cubicTo(
        size.width * 0.7480082,
        size.height * 0.6692058,
        size.width * 0.7416967,
        size.height * 0.6756497,
        size.width * 0.7339097,
        size.height * 0.6756497);
    path_2.cubicTo(
        size.width * 0.7248581,
        size.height * 0.6756497,
        size.width * 0.7193896,
        size.height * 0.6582432,
        size.width * 0.7193896,
        size.height * 0.6311768);
    path_2.lineTo(size.width * 0.7193896, size.height * 0.4706683);
    path_2.lineTo(size.width * 0.7549521, size.height * 0.4706683);
    path_2.lineTo(size.width * 0.7549521, size.height * 0.4094345);
    path_2.lineTo(size.width * 0.7193896, size.height * 0.4094345);
    path_2.lineTo(size.width * 0.7193896, size.height * 0.3166154);
    path_2.lineTo(size.width * 0.6979218, size.height * 0.3166154);
    path_2.lineTo(size.width * 0.6979218, size.height * 0.4094345);
    path_2.lineTo(size.width * 0.6791902, size.height * 0.4094345);
    path_2.lineTo(size.width * 0.6791902, size.height * 0.4706683);
    path_2.lineTo(size.width * 0.6979218, size.height * 0.4706683);
    path_2.lineTo(size.width * 0.6979218, size.height * 0.6305312);
    path_2.cubicTo(
        size.width * 0.6979218,
        size.height * 0.7007911,
        size.width * 0.7107596,
        size.height * 0.7394657,
        size.width * 0.7326451,
        size.height * 0.7394657);
    path_2.cubicTo(
        size.width * 0.7431682,
        size.height * 0.7394657,
        size.width * 0.7532698,
        size.height * 0.7278575,
        size.width * 0.7570598,
        size.height * 0.7220592);
    path_2.lineTo(size.width * 0.7532698, size.height * 0.6608254);
    path_2.close();
    path_2.moveTo(size.width * 0.6742084, size.height * 0.6890068);
    path_2.cubicTo(
        size.width * 0.6725605,
        size.height * 0.6775394,
        size.width * 0.6655477,
        size.height * 0.6516585,
        size.width * 0.6626391,
        size.height * 0.6443344);
    path_2.cubicTo(
        size.width * 0.6567069,
        size.height * 0.6525388,
        size.width * 0.6464367,
        size.height * 0.6903918,
        size.width * 0.6243251,
        size.height * 0.6776920);
    path_2.cubicTo(
        size.width * 0.6112880,
        size.height * 0.6702035,
        size.width * 0.6011481,
        size.height * 0.6377497,
        size.width * 0.6001633,
        size.height * 0.5957182);
    path_2.lineTo(size.width * 0.6772205, size.height * 0.5953896);
    path_2.cubicTo(
        size.width * 0.6803360,
        size.height * 0.2846076,
        size.width * 0.5551353,
        size.height * 0.3776849,
        size.width * 0.5796458,
        size.height * 0.6287589);
    path_2.cubicTo(
        size.width * 0.5931542,
        size.height * 0.7671307,
        size.width * 0.6513725,
        size.height * 0.7618723,
        size.width * 0.6742084,
        size.height * 0.6890068);
    path_2.close();

    Paint paint_2_fill = Paint()..style = PaintingStyle.fill;
    paint_2_fill.shader = ui.Gradient.linear(
        Offset(size.width * 1.249555, size.height * 0.3287401),
        Offset(size.width * 0.2975409, size.height * 0.5925961), [
      Color(0xff5F5EA7).withOpacity(1),
      Color(0xffAD4999).withOpacity(1),
      Color(0xffEE374C).withOpacity(1),
      Color(0xffFEC15B).withOpacity(1)
    ], [
      0,
      0.34902,
      0.670588,
      1
    ]);
    canvas.drawPath(path_2, paint_2_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
