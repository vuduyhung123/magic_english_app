import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:magic_english_app/views/grammar_screen.dart';
class GrammarChecker extends StatefulWidget {
  const GrammarChecker({super.key});

  @override
  State<GrammarChecker> createState() => _GrammarCheckerState();
}
class _GrammarCheckerState extends State<GrammarChecker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: 2100,
          decoration: BoxDecoration(color: const Color(0xFFF8F9FA)),
          child: Stack(
            children: [
              Positioned(
                left: -12,
                top: 0,
                child: Container(
                  width: 412,
                  height: 2100,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(color: const Color(0xFFF9FAFB)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 2093.10,
                        decoration: BoxDecoration(color: const Color(0xFFF9FAFB)),
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0,
                              top: 0,
                              child: Container(
                                width: 412,
                                height: 121,
                                padding: const EdgeInsets.only(
                                  top: 31.99,
                                  left: 24,
                                  right: 26,
                                  bottom: 1.27,
                                ),
                                decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 1.27,
                                      color: const Color(0xFFE5E7EB),
                                    ),
                                  ),
                                ),
                                child: Column(
                                  spacing: 3.98,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: 35.99,
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            left: 0,
                                            top: -1.45,
                                            child: Row(
                                              children: [
                                                  Text(
                                                    'Grammar Checker',
                                                    style: TextStyle(
                                                      color: const Color(0xFF101727),
                                                      fontSize: 24,
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w500,
                                                      height: 1.50,
                                                    ),
                                                  ),
                                                  SizedBox(width: 110),
                                                  IconButton(
                                                    icon: const Icon(Icons.close), 
                                                    onPressed: () => Navigator.pop(context)
                                                  ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      height: 23.98,
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            left: 0,
                                            top: -1.73,
                                            child: Text(
                                              'AI-powered writing assistant',
                                              style: TextStyle(
                                                color: const Color(0xFF495565),
                                                fontSize: 16,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w400,
                                                height: 1.50,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 37,
                              top: 121.21,
                              child: Container(
                                width: 338.22,
                                height: 1947.89,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 0,
                                      top: 24,
                                      child: Container(
                                        width: 338.22,
                                        height: 85.52,
                                        padding: const EdgeInsets.symmetric(horizontal: 15.99),
                                        decoration: ShapeDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment(0.00, 0.50),
                                            end: Alignment(1.00, 0.50),
                                            colors: [const Color(0xFFF0FDF4), const Color(0xFFEBFCF4)],
                                          ),
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                              width: 1.27,
                                              color: const Color(0xFFB8F7CF),
                                            ),
                                            borderRadius: BorderRadius.circular(16),
                                          ),
                                          shadows: [
                                            BoxShadow(
                                              color: Color(0x19000000),
                                              blurRadius: 2,
                                              offset: Offset(0, 1),
                                              spreadRadius: -1,
                                            ),
                                            BoxShadow(
                                              color: Color(0x19000000),
                                              blurRadius: 3,
                                              offset: Offset(0, 1),
                                              spreadRadius: 0,
                                            )
                                          ],
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          spacing: 11.99,
                                          children: [
                                            Container(
                                              width: 39.97,
                                              height: 39.97,
                                              padding: const EdgeInsets.only(top: 7.99, left: 7.99, right: 7.99),
                                              decoration: ShapeDecoration(
                                                color: const Color(0xFFDCFCE7),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(42770700),
                                                ),
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: 24,
                                                    height: 24,
                                                    clipBehavior: Clip.antiAlias,
                                                    decoration: BoxDecoration(),
                                                    child: Icon(  
                                                      Icons.check_circle_outline,
                                                      color: const Color(0xFF10B981),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                height: 50.99,
                                                child: Stack(
                                                  children: [
                                                    Positioned(
                                                      left: 0,
                                                      top: 0,
                                                      child: Container(
                                                        width: 251.73,
                                                        height: 27.01,
                                                        child: Stack(
                                                          children: [
                                                            Positioned(
                                                              left: 0,
                                                              top: 0.55,
                                                              child: Text(
                                                                'Analysis Complete!',
                                                                style: TextStyle(
                                                                  color: const Color(0xFF0D532B),
                                                                  fontSize: 18,
                                                                  fontFamily: 'Inter',
                                                                  fontWeight: FontWeight.w500,
                                                                  height: 1.50,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      left: 0,
                                                      top: 27.01,
                                                      child: Container(
                                                        width: 251.73,
                                                        height: 23.98,
                                                        child: Stack(
                                                          children: [
                                                            Positioned(
                                                              left: 0,
                                                              top: -1.73,
                                                              child: SizedBox(
                                                                width: 174,
                                                                child: Text(
                                                                  'Found 4 improvements',
                                                                  style: TextStyle(
                                                                    color: const Color(0xFF008235),
                                                                    fontSize: 16,
                                                                    fontFamily: 'Inter',
                                                                    fontWeight: FontWeight.w400,
                                                                    height: 1.50,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 0,
                                      top: 133.52,
                                      child: Container(
                                        width: 338.22,
                                        height: 294.47,
                                        decoration: ShapeDecoration(
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                              width: 1.27,
                                              color: const Color(0xFFE5E7EB),
                                            ),
                                            borderRadius: BorderRadius.circular(16),
                                          ),
                                          shadows: [
                                            BoxShadow(
                                              color: Color(0x19000000),
                                              blurRadius: 2,
                                              offset: Offset(0, 1),
                                              spreadRadius: -1,
                                            ),
                                            BoxShadow(
                                              color: Color(0x19000000),
                                              blurRadius: 3,
                                              offset: Offset(0, 1),
                                              spreadRadius: 0,
                                            )
                                          ],
                                        ),
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              left: 1.27,
                                              top: 185.26,
                                              child: Container(
                                                width: 335.68,
                                                height: 47.96,
                                                child: Stack(
                                                  children: [
                                                    Positioned(
                                                      left: 36.73,
                                                      top: 0,
                                                      child: SizedBox(
                                                        width: 261,
                                                        child: Text(
                                                          'Good writing! Minor improvements suggested',
                                                          style: TextStyle(
                                                            color: const Color(0xFF354152),
                                                            fontSize: 16,
                                                            fontFamily: 'Inter',
                                                            fontWeight: FontWeight.w400,
                                                            height: 1.50,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              left: 62.22,
                                              top: 245.21,
                                              child: Container(
                                                width: 213.79,
                                                height: 23.98,
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  spacing: 15.99,
                                                  children: [
                                                    Container(
                                                      width: 75.66,
                                                      height: 23.98,
                                                      child: Row(
                                                        mainAxisSize: MainAxisSize.min,
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        spacing: 3.98,
                                                        children: [
                                                          Container(
                                                            width: 11.99,
                                                            height: 11.99,
                                                            decoration: ShapeDecoration(
                                                              color: const Color(0xFFEF4444),
                                                              shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(42770700),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Container(
                                                              height: 23.98,
                                                              child: Stack(
                                                                children: [
                                                                  Positioned(
                                                                    left: 0,
                                                                    top: -1.73,
                                                                    child: SizedBox(
                                                                      width: 60,
                                                                      child: Text(
                                                                        '2 errors',
                                                                        style: TextStyle(
                                                                          color: const Color(0xFF495565),
                                                                          fontSize: 16,
                                                                          fontFamily: 'Inter',
                                                                          fontWeight: FontWeight.w400,
                                                                          height: 1.50,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 122.13,
                                                      height: 23.98,
                                                      child: Row(
                                                        mainAxisSize: MainAxisSize.min,
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        spacing: 3.98,
                                                        children: [
                                                          Container(
                                                            width: 11.99,
                                                            height: 11.99,
                                                            decoration: ShapeDecoration(
                                                              color: const Color(0xFF10B981),
                                                              shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(42770700),
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            width: 106.16,
                                                            height: 23.98,
                                                            child: Stack(
                                                              children: [
                                                                Positioned(
                                                                  left: 0,
                                                                  top: -1.73,
                                                                  child: SizedBox(
                                                                    width: 107,
                                                                    child: Text(
                                                                      '2 suggestions',
                                                                      style: TextStyle(
                                                                        color: const Color(0xFF495565),
                                                                        fontSize: 16,
                                                                        fontFamily: 'Inter',
                                                                        fontWeight: FontWeight.w400,
                                                                        height: 1.50,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              left: 97.11,
                                              top: 25.27,
                                              child: Container(
                                                width: 144,
                                                height: 144,
                                                child: Stack(
                                                  children: [
                                                    Positioned(
                                                      left: 0,
                                                      top: 0,
                                                      child: Container(
                                                        width: 144,
                                                        height: 144,
                                                        child: Column(
                                                          mainAxisSize: MainAxisSize.min,
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          spacing: 0,
                                                          children: [
                                                            Container(
                                                              width: 63.42,
                                                              height: 23.98,
                                                              child: Stack(
                                                                children: [
                                                                  Positioned(
                                                                    left: 40,
                                                                    top: -1.73,
                                                                    child: Text(
                                                                      '8.5',
                                                                      style: TextStyle(
                                                                        color: const Color(0xFF101727),
                                                                        fontSize: 16,
                                                                        fontFamily: 'Inter',
                                                                        fontWeight: FontWeight.w400,
                                                                        height: 1.50,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Container(
                                                              width: 105.41,
                                                              height: 23.98,
                                                              child: Stack(
                                                                children: [
                                                                  Positioned(
                                                                    left: 40,
                                                                    top: -1.73,
                                                                    child: Text(
                                                                      'out of 10',
                                                                      style: TextStyle(
                                                                        color: const Color(0xFF697282),
                                                                        fontSize: 16,
                                                                        fontFamily: 'Inter',
                                                                        fontWeight: FontWeight.w400,
                                                                        height: 1.50,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              left: 47,
                                              top: 60,
                                              child: Container(
                                                height: 70,
                                                width: 70,
                                                clipBehavior: Clip.antiAlias,
                                                decoration: BoxDecoration(),
                                                child: SvgPicture.asset(  
                                                  'assets/icons/circle.svg',
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 0,
                                      top: 451.99,
                                      child: Container(
                                        width: 338.22,
                                        height: 1405.40,
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              left: 0,
                                              top: 0,
                                              child: Container(
                                                width: 338.22,
                                                height: 23.98,
                                                child: Stack(
                                                  children: [
                                                    Positioned(
                                                      left: 0,
                                                      top: -1.73,
                                                      child: Text(
                                                        'Detailed Feedback',
                                                        style: TextStyle(
                                                          color: const Color(0xFF101727),
                                                          fontSize: 16,
                                                          fontFamily: 'Inter',
                                                          fontWeight: FontWeight.w400,
                                                          height: 1.50,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              left: 0,
                                              top: 39.97,
                                              child: Container(
                                                width: 338.22,
                                                height: 299.39,
                                                padding: const EdgeInsets.only(
                                                  top: 21.27,
                                                  left: 21.27,
                                                  right: 21.27,
                                                  bottom: 1.27,
                                                ),
                                                decoration: ShapeDecoration(
                                                  color: const Color(0xFFFEF2F2),
                                                  shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                      width: 1.27,
                                                      color: const Color(0xFFFFC9C9),
                                                    ),
                                                    borderRadius: BorderRadius.circular(16),
                                                  ),
                                                  shadows: [
                                                    BoxShadow(
                                                      color: Color(0x19000000),
                                                      blurRadius: 2,
                                                      offset: Offset(0, 1),
                                                      spreadRadius: -1,
                                                    ),
                                                    BoxShadow(
                                                      color: Color(0x19000000),
                                                      blurRadius: 3,
                                                      offset: Offset(0, 1),
                                                      spreadRadius: 0,
                                                    )
                                                  ],
                                                ),
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  spacing: 15.99,
                                                  children: [
                                                    Container(
                                                      width: double.infinity,
                                                      height: 75.92,
                                                      child: Row(
                                                        mainAxisSize: MainAxisSize.min,
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        spacing: 11.99,
                                                        children: [
                                                          Container(
                                                            width: 35.97,
                                                            height: 35.97,
                                                            padding: const EdgeInsets.only(top: 7.99, left: 7.99, right: 7.99),
                                                            decoration: ShapeDecoration(
                                                              color: const Color(0xFFFFE2E2),
                                                              shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(12),
                                                              ),
                                                            ),
                                                            child: Column(
                                                              mainAxisSize: MainAxisSize.min,
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Container(
                                                                  clipBehavior: Clip.antiAlias,
                                                                  decoration: BoxDecoration(),
                                                                  child: Icon( 
                                                                    size: 20, 
                                                                    Icons.error_outline,
                                                                    color: const Color(0xFFEF4444),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Container(
                                                              height: 75.92,
                                                              child: Column(
                                                                mainAxisSize: MainAxisSize.min,
                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                spacing: 3.98,
                                                                children: [
                                                                  Container(
                                                                    width: double.infinity,
                                                                    height: 23.98,
                                                                    child: Stack(
                                                                      children: [
                                                                        Positioned(
                                                                          left: 0,
                                                                          top: -1.73,
                                                                          child: Text(
                                                                            'Subject-Verb Agreement',
                                                                            style: TextStyle(
                                                                              color: const Color(0xFF811719),
                                                                              fontSize: 16,
                                                                              fontFamily: 'Inter',
                                                                              fontWeight: FontWeight.w400,
                                                                              height: 1.50,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    width: double.infinity,
                                                                    height: 47.96,
                                                                    child: Stack(
                                                                      children: [
                                                                        Positioned(
                                                                          left: 0,
                                                                          top: -1.73,
                                                                          child: SizedBox(
                                                                            width: 241,
                                                                            child: Text(
                                                                              "Use doesn't with third-person singular subjects (she/he/it)",
                                                                              style: TextStyle(
                                                                                color: const Color(0xFFC10007),
                                                                                fontSize: 16,
                                                                                fontFamily: 'Inter',
                                                                                fontWeight: FontWeight.w400,
                                                                                height: 1.50,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      width: double.infinity,
                                                      height: 164.93,
                                                      child: Column(
                                                        mainAxisSize: MainAxisSize.min,
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        spacing: 7.99,
                                                        children: [
                                                          Container(
                                                            width: double.infinity,
                                                            height: 78.47,
                                                            padding: const EdgeInsets.only(
                                                              top: 13.26,
                                                              left: 13.26,
                                                              right: 13.26,
                                                              bottom: 1.27,
                                                            ),
                                                            decoration: ShapeDecoration(
                                                              color: Colors.white.withValues(alpha: 0.60),
                                                              shape: RoundedRectangleBorder(
                                                                side: BorderSide(
                                                                  width: 1.27,
                                                                  color: const Color(0xFFE5E7EB),
                                                                ),
                                                                borderRadius: BorderRadius.circular(12),
                                                              ),
                                                            ),
                                                            child: Column(
                                                              mainAxisSize: MainAxisSize.min,
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              spacing: 3.98,
                                                              children: [
                                                                Container(
                                                                  width: double.infinity,
                                                                  height: 23.98,
                                                                  child: Stack(
                                                                    children: [
                                                                      Positioned(
                                                                        left: 0,
                                                                        top: -1.73,
                                                                        child: Text(
                                                                          'Original:',
                                                                          style: TextStyle(
                                                                            color: const Color(0xFF697282),
                                                                            fontSize: 16,
                                                                            fontFamily: 'Inter',
                                                                            fontWeight: FontWeight.w400,
                                                                            height: 1.50,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: double.infinity,
                                                                  height: 23.98,
                                                                  child: Stack(
                                                                    children: [
                                                                      Positioned(
                                                                        left: 0,
                                                                        top: -1.73,
                                                                        child: Text(
                                                                          "She don't like coffee",
                                                                          style: TextStyle(
                                                                            color: const Color(0xFFC10007),
                                                                            fontSize: 16,
                                                                            fontFamily: 'Inter',
                                                                            fontWeight: FontWeight.w400,
                                                                            height: 1.50,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Container(
                                                            width: double.infinity,
                                                            height: 78.47,
                                                            padding: const EdgeInsets.only(
                                                              top: 13.26,
                                                              left: 13.26,
                                                              right: 13.26,
                                                              bottom: 1.27,
                                                            ),
                                                            decoration: ShapeDecoration(
                                                              color: Colors.white.withValues(alpha: 0.60),
                                                              shape: RoundedRectangleBorder(
                                                                side: BorderSide(
                                                                  width: 1.27,
                                                                  color: const Color(0xFFE5E7EB),
                                                                ),
                                                                borderRadius: BorderRadius.circular(12),
                                                              ),
                                                            ),
                                                            child: Column(
                                                              mainAxisSize: MainAxisSize.min,
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              spacing: 3.98,
                                                              children: [
                                                                Container(
                                                                  width: double.infinity,
                                                                  height: 23.98,
                                                                  child: Stack(
                                                                    children: [
                                                                      Positioned(
                                                                        left: 0,
                                                                        top: -1.73,
                                                                        child: Text(
                                                                          'Suggested:',
                                                                          style: TextStyle(
                                                                            color: const Color(0xFF697282),
                                                                            fontSize: 16,
                                                                            fontFamily: 'Inter',
                                                                            fontWeight: FontWeight.w400,
                                                                            height: 1.50,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: double.infinity,
                                                                  height: 23.98,
                                                                  child: Stack(
                                                                    children: [
                                                                      Positioned(
                                                                        left: 0,
                                                                        top: -1.73,
                                                                        child: Text(
                                                                          "She doesn't like coffee",
                                                                          style: TextStyle(
                                                                            color: const Color(0xFF10B981),
                                                                            fontSize: 16,
                                                                            fontFamily: 'Inter',
                                                                            fontWeight: FontWeight.w400,
                                                                            height: 1.50,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              left: 0,
                                              top: 355.35,
                                              child: Container(
                                                width: 338.22,
                                                height: 323.37,
                                                padding: const EdgeInsets.only(
                                                  top: 21.27,
                                                  left: 21.27,
                                                  right: 21.27,
                                                  bottom: 1.27,
                                                ),
                                                decoration: ShapeDecoration(
                                                  color: const Color(0xFFFEF2F2),
                                                  shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                      width: 1.27,
                                                      color: const Color(0xFFFFC9C9),
                                                    ),
                                                    borderRadius: BorderRadius.circular(16),
                                                  ),
                                                  shadows: [
                                                    BoxShadow(
                                                      color: Color(0x19000000),
                                                      blurRadius: 2,
                                                      offset: Offset(0, 1),
                                                      spreadRadius: -1,
                                                    ),
                                                    BoxShadow(
                                                      color: Color(0x19000000),
                                                      blurRadius: 3,
                                                      offset: Offset(0, 1),
                                                      spreadRadius: 0,
                                                    )
                                                  ],
                                                ),
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  spacing: 15.99,
                                                  children: [
                                                    Container(
                                                      width: double.infinity,
                                                      height: 99.90,
                                                      child: Row(
                                                        mainAxisSize: MainAxisSize.min,
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        spacing: 11.99,
                                                        children: [
                                                          Container(
                                                            width: 35.97,
                                                            height: 35.97,
                                                            padding: const EdgeInsets.only(top: 7.99, left: 7.99, right: 7.99),
                                                            decoration: ShapeDecoration(
                                                              color: const Color(0xFFFFE2E2),
                                                              shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(12),
                                                              ),
                                                            ),
                                                            child: Column(
                                                              mainAxisSize: MainAxisSize.min,
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Container(
                                                                  clipBehavior: Clip.antiAlias,
                                                                  decoration: BoxDecoration(),
                                                                  child: Icon( 
                                                                    size: 20, 
                                                                    Icons.error_outline,
                                                                    color: const Color(0xFFEF4444),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Container(
                                                              height: 99.90,
                                                              child: Column(
                                                                mainAxisSize: MainAxisSize.min,
                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                spacing: 3.98,
                                                                children: [
                                                                  Container(
                                                                    width: double.infinity,
                                                                    height: 23.98,
                                                                    child: Stack(
                                                                      children: [
                                                                        Positioned(
                                                                          left: 0,
                                                                          top: -1.73,
                                                                          child: Text(
                                                                            'Verb Conjugation',
                                                                            style: TextStyle(
                                                                              color: const Color(0xFF811719),
                                                                              fontSize: 16,
                                                                              fontFamily: 'Inter',
                                                                              fontWeight: FontWeight.w400,
                                                                              height: 1.50,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    width: double.infinity,
                                                                    height: 71.94,
                                                                    child: Stack(
                                                                      children: [
                                                                        Positioned(
                                                                          left: 0,
                                                                          top: -1.73,
                                                                          child: SizedBox(
                                                                            width: 222,
                                                                            child: Text(
                                                                              'The verb must agree with the subject "she" in third person singular',
                                                                              style: TextStyle(
                                                                                color: const Color(0xFFC10007),
                                                                                fontSize: 16,
                                                                                fontFamily: 'Inter',
                                                                                fontWeight: FontWeight.w400,
                                                                                height: 1.50,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      width: double.infinity,
                                                      height: 164.93,
                                                      child: Column(
                                                        mainAxisSize: MainAxisSize.min,
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        spacing: 7.99,
                                                        children: [
                                                          Container(
                                                            width: double.infinity,
                                                            height: 78.47,
                                                            padding: const EdgeInsets.only(
                                                              top: 13.26,
                                                              left: 13.26,
                                                              right: 13.26,
                                                              bottom: 1.27,
                                                            ),
                                                            decoration: ShapeDecoration(
                                                              color: Colors.white.withValues(alpha: 0.60),
                                                              shape: RoundedRectangleBorder(
                                                                side: BorderSide(
                                                                  width: 1.27,
                                                                  color: const Color(0xFFE5E7EB),
                                                                ),
                                                                borderRadius: BorderRadius.circular(12),
                                                              ),
                                                            ),
                                                            child: Column(
                                                              mainAxisSize: MainAxisSize.min,
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              spacing: 3.98,
                                                              children: [
                                                                Container(
                                                                  width: double.infinity,
                                                                  height: 23.98,
                                                                  child: Stack(
                                                                    children: [
                                                                      Positioned(
                                                                        left: 0,
                                                                        top: -1.73,
                                                                        child: Text(
                                                                          'Original:',
                                                                          style: TextStyle(
                                                                            color: const Color(0xFF697282),
                                                                            fontSize: 16,
                                                                            fontFamily: 'Inter',
                                                                            fontWeight: FontWeight.w400,
                                                                            height: 1.50,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: double.infinity,
                                                                  height: 23.98,
                                                                  child: Stack(
                                                                    children: [
                                                                      Positioned(
                                                                        left: 0,
                                                                        top: -1.73,
                                                                        child: Text(
                                                                          'but she enjoy tea',
                                                                          style: TextStyle(
                                                                            color: const Color(0xFFC10007),
                                                                            fontSize: 16,
                                                                            fontFamily: 'Inter',
                                                                            fontWeight: FontWeight.w400,
                                                                            height: 1.50,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Container(
                                                            width: double.infinity,
                                                            height: 78.47,
                                                            padding: const EdgeInsets.only(
                                                              top: 13.26,
                                                              left: 13.26,
                                                              right: 13.26,
                                                              bottom: 1.27,
                                                            ),
                                                            decoration: ShapeDecoration(
                                                              color: Colors.white.withValues(alpha: 0.60),
                                                              shape: RoundedRectangleBorder(
                                                                side: BorderSide(
                                                                  width: 1.27,
                                                                  color: const Color(0xFFE5E7EB),
                                                                ),
                                                                borderRadius: BorderRadius.circular(12),
                                                              ),
                                                            ),
                                                            child: Column(
                                                              mainAxisSize: MainAxisSize.min,
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              spacing: 3.98,
                                                              children: [
                                                                Container(
                                                                  width: double.infinity,
                                                                  height: 23.98,
                                                                  child: Stack(
                                                                    children: [
                                                                      Positioned(
                                                                        left: 0,
                                                                        top: -1.73,
                                                                        child: Text(
                                                                          'Suggested:',
                                                                          style: TextStyle(
                                                                            color: const Color(0xFF697282),
                                                                            fontSize: 16,
                                                                            fontFamily: 'Inter',
                                                                            fontWeight: FontWeight.w400,
                                                                            height: 1.50,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: double.infinity,
                                                                  height: 23.98,
                                                                  child: Stack(
                                                                    children: [
                                                                      Positioned(
                                                                        left: 0,
                                                                        top: -1.73,
                                                                        child: Text(
                                                                          'but she enjoys tea',
                                                                          style: TextStyle(
                                                                            color: const Color(0xFF10B981),
                                                                            fontSize: 16,
                                                                            fontFamily: 'Inter',
                                                                            fontWeight: FontWeight.w400,
                                                                            height: 1.50,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              left: 0,
                                              top: 694.71,
                                              child: Container(
                                                width: 338.22,
                                                height: 323.37,
                                                padding: const EdgeInsets.only(
                                                  top: 21.27,
                                                  left: 21.27,
                                                  right: 21.27,
                                                  bottom: 1.27,
                                                ),
                                                decoration: ShapeDecoration(
                                                  color: const Color(0xFFF0FDF4),
                                                  shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                      width: 1.27,
                                                      color: const Color(0xFFB8F7CF),
                                                    ),
                                                    borderRadius: BorderRadius.circular(16),
                                                  ),
                                                  shadows: [
                                                    BoxShadow(
                                                      color: Color(0x19000000),
                                                      blurRadius: 2,
                                                      offset: Offset(0, 1),
                                                      spreadRadius: -1,
                                                    ),
                                                    BoxShadow(
                                                      color: Color(0x19000000),
                                                      blurRadius: 3,
                                                      offset: Offset(0, 1),
                                                      spreadRadius: 0,
                                                    )
                                                  ],
                                                ),
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  spacing: 15.99,
                                                  children: [
                                                    Container(
                                                      width: double.infinity,
                                                      height: 99.90,
                                                      child: Row(
                                                        mainAxisSize: MainAxisSize.min,
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        spacing: 11.99,
                                                        children: [
                                                          Container(
                                                            width: 35.97,
                                                            height: 35.97,
                                                            padding: const EdgeInsets.only(top: 7.99, left: 7.99, right: 7.99),
                                                            decoration: ShapeDecoration(
                                                              color: const Color(0xFFDCFCE7),
                                                              shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(12),
                                                              ),
                                                            ),
                                                            child: Column(
                                                              mainAxisSize: MainAxisSize.min,
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Container(
                                                                  clipBehavior: Clip.antiAlias,
                                                                  decoration: BoxDecoration(),
                                                                  child: Icon(  
                                                                    size: 20,
                                                                    Icons.tips_and_updates_outlined,
                                                                    color: const Color(0xFF22C55E),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Container(
                                                              height: 99.90,
                                                              child: Column(
                                                                mainAxisSize: MainAxisSize.min,
                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                spacing: 3.98,
                                                                children: [
                                                                  Container(
                                                                    width: double.infinity,
                                                                    height: 23.98,
                                                                    child: Stack(
                                                                      children: [
                                                                        Positioned(
                                                                          left: 0,
                                                                          top: -1.73,
                                                                          child: Text(
                                                                            'More Natural Phrasing',
                                                                            style: TextStyle(
                                                                              color: const Color(0xFF0D532B),
                                                                              fontSize: 16,
                                                                              fontFamily: 'Inter',
                                                                              fontWeight: FontWeight.w400,
                                                                              height: 1.50,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    width: double.infinity,
                                                                    height: 71.94,
                                                                    child: Stack(
                                                                      children: [
                                                                        Positioned(
                                                                          left: 0,
                                                                          top: -1.73,
                                                                          child: SizedBox(
                                                                            width: 226,
                                                                            child: Text(
                                                                              'Using "really" sounds more natural in casual conversation than "very much"',
                                                                              style: TextStyle(
                                                                                color: const Color(0xFF008235),
                                                                                fontSize: 16,
                                                                                fontFamily: 'Inter',
                                                                                fontWeight: FontWeight.w400,
                                                                                height: 1.50,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      width: double.infinity,
                                                      height: 164.93,
                                                      child: Column(
                                                        mainAxisSize: MainAxisSize.min,
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        spacing: 7.99,
                                                        children: [
                                                          Container(
                                                            width: double.infinity,
                                                            height: 78.47,
                                                            padding: const EdgeInsets.only(
                                                              top: 13.26,
                                                              left: 13.26,
                                                              right: 13.26,
                                                              bottom: 1.27,
                                                            ),
                                                            decoration: ShapeDecoration(
                                                              color: Colors.white.withValues(alpha: 0.60),
                                                              shape: RoundedRectangleBorder(
                                                                side: BorderSide(
                                                                  width: 1.27,
                                                                  color: const Color(0xFFE5E7EB),
                                                                ),
                                                                borderRadius: BorderRadius.circular(12),
                                                              ),
                                                            ),
                                                            child: Column(
                                                              mainAxisSize: MainAxisSize.min,
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              spacing: 3.98,
                                                              children: [
                                                                Container(
                                                                  width: double.infinity,
                                                                  height: 23.98,
                                                                  child: Stack(
                                                                    children: [
                                                                      Positioned(
                                                                        left: 0,
                                                                        top: -1.73,
                                                                        child: Text(
                                                                          'Original:',
                                                                          style: TextStyle(
                                                                            color: const Color(0xFF697282),
                                                                            fontSize: 16,
                                                                            fontFamily: 'Inter',
                                                                            fontWeight: FontWeight.w400,
                                                                            height: 1.50,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: double.infinity,
                                                                  height: 23.98,
                                                                  child: Stack(
                                                                    children: [
                                                                      Positioned(
                                                                        left: 0,
                                                                        top: -1.73,
                                                                        child: Text(
                                                                          'she enjoy tea very much',
                                                                          style: TextStyle(
                                                                            color: const Color(0xFF354152),
                                                                            fontSize: 16,
                                                                            fontFamily: 'Inter',
                                                                            fontWeight: FontWeight.w400,
                                                                            height: 1.50,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Container(
                                                            width: double.infinity,
                                                            height: 78.47,
                                                            padding: const EdgeInsets.only(
                                                              top: 13.26,
                                                              left: 13.26,
                                                              right: 13.26,
                                                              bottom: 1.27,
                                                            ),
                                                            decoration: ShapeDecoration(
                                                              color: Colors.white.withValues(alpha: 0.60),
                                                              shape: RoundedRectangleBorder(
                                                                side: BorderSide(
                                                                  width: 1.27,
                                                                  color: const Color(0xFFE5E7EB),
                                                                ),
                                                                borderRadius: BorderRadius.circular(12),
                                                              ),
                                                            ),
                                                            child: Column(
                                                              mainAxisSize: MainAxisSize.min,
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              spacing: 3.98,
                                                              children: [
                                                                Container(
                                                                  width: double.infinity,
                                                                  height: 23.98,
                                                                  child: Stack(
                                                                    children: [
                                                                      Positioned(
                                                                        left: 0,
                                                                        top: -1.73,
                                                                        child: Text(
                                                                          'Suggested:',
                                                                          style: TextStyle(
                                                                            color: const Color(0xFF697282),
                                                                            fontSize: 16,
                                                                            fontFamily: 'Inter',
                                                                            fontWeight: FontWeight.w400,
                                                                            height: 1.50,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: double.infinity,
                                                                  height: 23.98,
                                                                  child: Stack(
                                                                    children: [
                                                                      Positioned(
                                                                        left: 0,
                                                                        top: -1.73,
                                                                        child: Text(
                                                                          'she really enjoys tea',
                                                                          style: TextStyle(
                                                                            color: const Color(0xFF10B981),
                                                                            fontSize: 16,
                                                                            fontFamily: 'Inter',
                                                                            fontWeight: FontWeight.w400,
                                                                            height: 1.50,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              left: 0,
                                              top: 1034.07,
                                              child: Container(
                                                width: 338.22,
                                                height: 371.33,
                                                padding: const EdgeInsets.only(
                                                  top: 21.27,
                                                  left: 21.27,
                                                  right: 21.27,
                                                  bottom: 1.27,
                                                ),
                                                decoration: ShapeDecoration(
                                                  color: const Color(0xFFF0FDF4),
                                                  shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                      width: 1.27,
                                                      color: const Color(0xFFB8F7CF),
                                                    ),
                                                    borderRadius: BorderRadius.circular(16),
                                                  ),
                                                  shadows: [
                                                    BoxShadow(
                                                      color: Color(0x19000000),
                                                      blurRadius: 2,
                                                      offset: Offset(0, 1),
                                                      spreadRadius: -1,
                                                    ),
                                                    BoxShadow(
                                                      color: Color(0x19000000),
                                                      blurRadius: 3,
                                                      offset: Offset(0, 1),
                                                      spreadRadius: 0,
                                                    )
                                                  ],
                                                ),
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  spacing: 15.99,
                                                  children: [
                                                    Container(
                                                      width: double.infinity,
                                                      height: 99.90,
                                                      child: Row(
                                                        mainAxisSize: MainAxisSize.min,
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        spacing: 11.99,
                                                        children: [
                                                          Container(
                                                            width: 35.97,
                                                            height: 35.97,
                                                            padding: const EdgeInsets.only(top: 7.99, left: 7.99, right: 7.99),
                                                            decoration: ShapeDecoration(
                                                              color: const Color(0xFFDCFCE7),
                                                              shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(12),
                                                              ),
                                                            ),
                                                            child: Column(
                                                              mainAxisSize: MainAxisSize.min,
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Container(
                                                                  clipBehavior: Clip.antiAlias,
                                                                  decoration: BoxDecoration(),
                                                                  child: Icon(  
                                                                    size: 20,
                                                                    Icons.tips_and_updates_outlined,
                                                                    color: const Color(0xFF22C55E),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Container(
                                                              height: 99.90,
                                                              child: Column(
                                                                mainAxisSize: MainAxisSize.min,
                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                spacing: 3.98,
                                                                children: [
                                                                  Container(
                                                                    width: double.infinity,
                                                                    height: 23.98,
                                                                    child: Stack(
                                                                      children: [
                                                                        Positioned(
                                                                          left: 0,
                                                                          top: -1.73,
                                                                          child: Text(
                                                                            'Sentence Flow',
                                                                            style: TextStyle(
                                                                              color: const Color(0xFF0D532B),
                                                                              fontSize: 16,
                                                                              fontFamily: 'Inter',
                                                                              fontWeight: FontWeight.w400,
                                                                              height: 1.50,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    width: double.infinity,
                                                                    height: 71.94,
                                                                    child: Stack(
                                                                      children: [
                                                                        Positioned(
                                                                          left: 0,
                                                                          top: -1.73,
                                                                          child: SizedBox(
                                                                            width: 237,
                                                                            child: Text(
                                                                              'Starting with "While" creates a smoother contrast between the two clauses',
                                                                              style: TextStyle(
                                                                                color: const Color(0xFF008235),
                                                                                fontSize: 16,
                                                                                fontFamily: 'Inter',
                                                                                fontWeight: FontWeight.w400,
                                                                                height: 1.50,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      width: double.infinity,
                                                      height: 212.89,
                                                      child: Column(
                                                        mainAxisSize: MainAxisSize.min,
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        spacing: 7.99,
                                                        children: [
                                                          Container(
                                                            width: double.infinity,
                                                            height: 102.45,
                                                            padding: const EdgeInsets.only(
                                                              top: 13.26,
                                                              left: 13.26,
                                                              right: 13.26,
                                                              bottom: 1.27,
                                                            ),
                                                            decoration: ShapeDecoration(
                                                              color: Colors.white.withValues(alpha: 0.60),
                                                              shape: RoundedRectangleBorder(
                                                                side: BorderSide(
                                                                  width: 1.27,
                                                                  color: const Color(0xFFE5E7EB),
                                                                ),
                                                                borderRadius: BorderRadius.circular(12),
                                                              ),
                                                            ),
                                                            child: Column(
                                                              mainAxisSize: MainAxisSize.min,
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              spacing: 3.98,
                                                              children: [
                                                                Container(
                                                                  width: double.infinity,
                                                                  height: 23.98,
                                                                  child: Stack(
                                                                    children: [
                                                                      Positioned(
                                                                        left: 0,
                                                                        top: -1.73,
                                                                        child: Text(
                                                                          'Original:',
                                                                          style: TextStyle(
                                                                            color: const Color(0xFF697282),
                                                                            fontSize: 16,
                                                                            fontFamily: 'Inter',
                                                                            fontWeight: FontWeight.w400,
                                                                            height: 1.50,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: double.infinity,
                                                                  height: 47.96,
                                                                  child: Stack(
                                                                    children: [
                                                                      Positioned(
                                                                        left: 0,
                                                                        top: -1.73,
                                                                        child: SizedBox(
                                                                          width: 239,
                                                                          child: Text(
                                                                            "She doesn't like coffee, but she enjoys tea",
                                                                            style: TextStyle(
                                                                              color: const Color(0xFF354152),
                                                                              fontSize: 16,
                                                                              fontFamily: 'Inter',
                                                                              fontWeight: FontWeight.w400,
                                                                              height: 1.50,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Container(
                                                            width: double.infinity,
                                                            height: 102.45,
                                                            padding: const EdgeInsets.only(
                                                              top: 13.26,
                                                              left: 13.26,
                                                              right: 13.26,
                                                              bottom: 1.27,
                                                            ),
                                                            decoration: ShapeDecoration(
                                                              color: Colors.white.withValues(alpha: 0.60),
                                                              shape: RoundedRectangleBorder(
                                                                side: BorderSide(
                                                                  width: 1.27,
                                                                  color: const Color(0xFFE5E7EB),
                                                                ),
                                                                borderRadius: BorderRadius.circular(12),
                                                              ),
                                                            ),
                                                            child: Column(
                                                              mainAxisSize: MainAxisSize.min,
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              spacing: 3.98,
                                                              children: [
                                                                Container(
                                                                  width: double.infinity,
                                                                  height: 23.98,
                                                                  child: Stack(
                                                                    children: [
                                                                      Positioned(
                                                                        left: 0,
                                                                        top: -1.73,
                                                                        child: Text(
                                                                          'Suggested:',
                                                                          style: TextStyle(
                                                                            color: const Color(0xFF697282),
                                                                            fontSize: 16,
                                                                            fontFamily: 'Inter',
                                                                            fontWeight: FontWeight.w400,
                                                                            height: 1.50,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: double.infinity,
                                                                  height: 47.96,
                                                                  child: Stack(
                                                                    children: [
                                                                      Positioned(
                                                                        left: 0,
                                                                        top: -1.73,
                                                                        child: SizedBox(
                                                                          width: 255,
                                                                          child: Text(
                                                                            "While she doesn't like coffee, she really enjoys tea",
                                                                            style: TextStyle(
                                                                              color: const Color(0xFF10B981),
                                                                              fontSize: 16,
                                                                              fontFamily: 'Inter',
                                                                              fontWeight: FontWeight.w400,
                                                                              height: 1.50,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 0,
                                      top: 1881.79,
                                      child: Container(
                                        width: 338,
                                        height: 66,
                                        padding: const EdgeInsets.only(top: 7.99),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          spacing: 11.99,
                                          children: [
                                            Expanded(
                                              child: Container(
                                                height: 50,
                                                clipBehavior: Clip.antiAlias,
                                                decoration: ShapeDecoration(
                                                  color: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                      width: 1.27,
                                                      color: const Color(0xFF0B5394),
                                                    ),
                                                    borderRadius: BorderRadius.circular(16),
                                                  ),
                                                ),
                                                child: Stack(
                                                  children: [
                                                    Positioned(
                                                      left: 20,
                                                      top: 13.01,
                                                      child: Text(
                                                        'Check New Text',
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                          color: const Color(0xFF0B5394),
                                                          fontSize: 16,
                                                          fontFamily: 'Inter',
                                                          fontWeight: FontWeight.w400,
                                                          height: 1.50,
                                                        ),
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.pop(
                                                          context,
                                                            MaterialPageRoute(builder: (context) => const GrammarScreen()),
                                                          );
                                                        }
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                height: 50,
                                                decoration: ShapeDecoration(
                                                  color: const Color(0xFF0B5394),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(16),
                                                  ),
                                                ),
                                                child: Stack(
                                                  children: [
                                                    Positioned(
                                                      left: 48.01,
                                                      top: 13.01,
                                                      child: Text(
                                                        'Apply All',
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16,
                                                          fontFamily: 'Inter',
                                                          fontWeight: FontWeight.w400,
                                                          height: 1.50,
                                                        ),
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.pop(
                                                          context,
                                                            MaterialPageRoute(builder: (context) => const GrammarScreen()),
                                                          );
                                                        }
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}