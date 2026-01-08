import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../view_models/statistic_view_model.dart';

class  StatisticScreen extends StatefulWidget {
  final StatisticsViewModel viewModel;
  const StatisticScreen({super.key, required this.viewModel});

  @override
  State<StatisticScreen> createState() => _StatisticScreenState();
  
}

class _StatisticScreenState extends State<StatisticScreen> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.loadStats();
  }
  
  @override
  Widget build(BuildContext context) {
    final stats = widget.viewModel.stats;

    if (stats == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: const Color(0xFFF9FAFB)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(color: const Color(0xFFF9FAFB)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 93.25,
                      padding: const EdgeInsets.only(
                        top: 31.99,
                        left: 24,
                        right: 24,
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
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 35.99,
                            child: Stack(
                              children: [
                                Positioned(
                                  child: Text(
                                    'My Progress',
                                    style: TextStyle(
                                      color: const Color(0xFF101727),
                                      fontSize: 24,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,
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
                      height: 2056.97,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 24,
                            top: 23.75,
                            child: Container(
                              width: 340,
                              height: 216,
                              decoration: ShapeDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment(0.50, 0.00),
                                  end: Alignment(0.50, 1.00),
                                  colors: [const Color(0xFF0B5394), const Color(0xFF084275)],
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                shadows: [
                                  BoxShadow(
                                    color: Color(0x19000000),
                                    blurRadius: 6,
                                    offset: Offset(0, 4),
                                    spreadRadius: -4,
                                  ),
                                  BoxShadow(
                                    color: Color(0x19000000),
                                    blurRadius: 15,
                                    offset: Offset(0, 10),
                                    spreadRadius: -3,
                                  )
                                ],
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 132,
                                    top: 31.99,
                                    child: Container(
                                      width: 79.99,
                                      height: 79.99,
                                      padding: const EdgeInsets.only(top: 15.99, left: 15.99, right: 15.99),
                                      decoration: ShapeDecoration(
                                        color: Colors.white.withValues(alpha: 0.20),
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
                                            width: double.infinity,
                                            height: 48,
                                            clipBehavior: Clip.antiAlias,
                                            decoration: BoxDecoration(),
                                            child: SvgPicture.asset(
                                              'assets/icons/fire.svg',
                                              fit: BoxFit.contain
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 44,
                                    top: 127.96,
                                    child: Container(
                                      width: 256.41,
                                      height: 23.98,
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            left: 97.95,
                                            top: -1.73,
                                            child: Text(
                                              '${widget.viewModel.stats?.streak ?? 0} Days',
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
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 44,
                                    top: 159.93,
                                    child: Container(
                                      width: 256.41,
                                      height: 23.98,
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            left: 50.06,
                                            top: -1.73,
                                            child: Text(
                                              'Keep the flame lit! 🔥',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: const Color(0xFFDAEAFE),
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
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            left: 24,
                            top: 263.75,
                            child: Container(
                              width: 340,
                              height: 433,
                              padding: const EdgeInsets.only(
                                top: 25.27,
                                left: 25.27,
                                right: 25.27,
                                bottom: 1.27,
                              ),
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
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 24,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: 29.99,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          left: 0,
                                          top: -0.45,
                                          child: Text(
                                            'Word Distribution',
                                            style: TextStyle(
                                              color: const Color(0xFF101727),
                                              fontSize: 20,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w500,
                                              height: 1.50,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: 327.87,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          left: 0,
                                          top: 0,
                                          child: Container(
                                            width: 269.83,
                                            height: 199.98,
                                            child: Stack(
                                              children: [
                                                Align(
                                                  alignment: Alignment.center,
                                                  child: SizedBox(
                                                    width: 160,
                                                    height: 160,
                                                    child: KindPieChart(data: stats.posCounts),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 0,
                                          top: 215.98,
                                          child: Container(
                                            width: 269.83,
                                            height: 111.89,
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                  left: 0,
                                                  top: 0,
                                                  child: Container(
                                                    width: 122.91,
                                                    height: 23.98,
                                                    child: Row(
                                                      mainAxisSize: MainAxisSize.min,
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      spacing: 7.99,
                                                      children: [
                                                        Container(
                                                          width: 11.99,
                                                          height: 11.99,
                                                          decoration: ShapeDecoration(
                                                            color: const Color(0xFF6366F1),
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(42770700),
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 78.23,
                                                          height: 23.98,
                                                          child: Stack(
                                                            children: [
                                                              Positioned(
                                                                left: 0,
                                                                top: -1.73,
                                                                child: SizedBox(
                                                                  width: 79,
                                                                  child: Text(
                                                                    'Nouns: ${widget.viewModel.stats?.posCounts['Noun'] ?? 0}',
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
                                                ),
                                                Positioned(
                                                  left: 162,
                                                  top: 0,
                                                  child: Container(
                                                    width: 122.93,
                                                    height: 23.98,
                                                    child: Row(
                                                      mainAxisSize: MainAxisSize.min,
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      spacing: 7.99,
                                                      children: [
                                                        Container(
                                                          width: 11.99,
                                                          height: 11.99,
                                                          decoration: ShapeDecoration(
                                                            color: const Color(0xFF8B5CF6),
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(42770700),
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 72.86,
                                                          height: 23.98,
                                                          child: Stack(
                                                            children: [
                                                              Positioned(
                                                                left: 0,
                                                                top: -1.73,
                                                                child: SizedBox(
                                                                  width: 73,
                                                                  child: Text(
                                                                    'Verbs: ${widget.viewModel.stats?.posCounts['Verb'] ?? 0}',
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
                                                ),
                                                Positioned(
                                                  left: 0,
                                                  right: 0,
                                                  top: 42,
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(left: 0),
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          child: Row(
                                                            mainAxisSize: MainAxisSize.min,
                                                            children: [
                                                              Container(
                                                                width: 11.55,
                                                                height: 11.99,
                                                                decoration: ShapeDecoration(
                                                                  color: const Color(0xFFEC4899),
                                                                  shape: RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius.circular(42770700),
                                                                  ),
                                                                ),
                                                              ),
                                                              const SizedBox(width: 7),
                                                              Expanded(
                                                                child: Text(
                                                                  'Adjectives: ${widget.viewModel.stats?.posCounts['Adjective'] ?? 0}',
                                                                  maxLines: 1,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: const TextStyle(
                                                                    color: Color(0xFF354152),
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
                                                  left: 162,
                                                  top: 31.97,
                                                  child: Container(
                                                    width: 122.93,
                                                    height: 47.96,
                                                    child: Row(
                                                      mainAxisSize: MainAxisSize.min,
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      spacing: 7.99,
                                                      children: [
                                                        Container(
                                                          width: 11.99,
                                                          height: 11.99,
                                                          decoration: ShapeDecoration(
                                                            color: const Color(0xFFF59E0B),
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(42770700),
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 88.57,
                                                          height: 23.98,
                                                          child: Stack(
                                                            children: [
                                                              Positioned(
                                                                left: 0,
                                                                top: -1.73,
                                                                child: SizedBox(
                                                                  width: 89,
                                                                  child: Text(
                                                                    'Adverbs: ${widget.viewModel.stats?.posCounts['Adverb'] ?? 0}',
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
                                                ),
                                                Positioned(
                                                  left: 0,
                                                  top: 87.91,
                                                  child: Container(
                                                    width: 122.91,
                                                    height: 23.98,
                                                    child: Row(
                                                      mainAxisSize: MainAxisSize.min,
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      spacing: 7.99,
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
                                                          width: 76.46,
                                                          height: 23.98,
                                                          child: Stack(
                                                            children: [
                                                              Positioned(
                                                                left: -0.25,
                                                                top: -1.30,
                                                                child: SizedBox(
                                                                  width: 114,
                                                                  child: Text(
                                                                    'Others: ${widget.viewModel.stats?.posCounts['Other'] ?? 0}',
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
                          Positioned(
                            left: 24,
                            top: 720.75,
                            child: Container(
                              width: 340,
                              height: 388,
                              padding: const EdgeInsets.only(
                                top: 25.27,
                                left: 25.27,
                                right: 25.27,
                                bottom: 1.27,
                              ),
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
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 24,
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
                                            'CEFR Proficiency (%)',
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
                                    width: double.infinity,
                                    height: 249.99,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          left: 0,
                                          top: 0,
                                          child: Container(
                                            width: 269.83,
                                            height: 249.84,
                                            clipBehavior: Clip.antiAlias,
                                            decoration: BoxDecoration(),
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                  left: 70,
                                                  top: 218.80,
                                                  child: Text(
                                                    'A1',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: const Color(0xFF6B7280),
                                                      fontSize: 13.99,
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  left: 106,
                                                  top: 218.80,
                                                  child: Text(
                                                    'A2',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: const Color(0xFF6B7280),
                                                      fontSize: 13.99,
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  left: 142,
                                                  top: 218.80,
                                                  child: Text(
                                                    'B1',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: const Color(0xFF6B7280),
                                                      fontSize: 13.99,
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  left: 178,
                                                  top: 218.80,
                                                  child: Text(
                                                    'B2',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: const Color(0xFF6B7280),
                                                      fontSize: 13.99,
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  left: 214,
                                                  top: 218.80,
                                                  child: Text(
                                                    'C1',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: const Color(0xFF6B7280),
                                                      fontSize: 13.99,
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  left: 250,
                                                  top: 218.80,
                                                  child: Text(
                                                    'C2',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: const Color(0xFF6B7280),
                                                      fontSize: 13.99,
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  left: 0,
                                                  top: 0,
                                                  child: Container(
                                                    width: 269.83,
                                                    height: 199.98,
                                                    child: Stack(
                                                      children: [
                                                        Positioned(
                                                          left: 32,
                                                          top: 48,
                                                          child: Container(
                                                            width: 269.83,
                                                            height: 199.87,
                                                            clipBehavior: Clip.antiAlias,
                                                            decoration: BoxDecoration(),
                                                            child: CefrBarChart(viewModel: widget.viewModel)
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  left: 47.97,
                                                  top: 205.84,
                                                  child: Text(
                                                    '0',
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                      color: const Color(0xFF6B7280),
                                                      fontSize: 13.99,
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  left: 38.98,
                                                  top: 153.37,
                                                  child: Text(
                                                    '20',
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                      color: const Color(0xFF6B7280),
                                                      fontSize: 13.99,
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  left: 38.98,
                                                  top: 100.91,
                                                  child: Text(
                                                    '40',
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                      color: const Color(0xFF6B7280),
                                                      fontSize: 13.99,
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  left: 38.98,
                                                  top: 48.44,
                                                  child: Text(
                                                    '60',
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                      color: const Color(0xFF6B7280),
                                                      fontSize: 13.99,
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  left: 38.98,
                                                  top: 1.47,
                                                  child: Text(
                                                    '80',
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                      color: const Color(0xFF6B7280),
                                                      fontSize: 13.99,
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w400,
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
                                    width: double.infinity,
                                    height: 23.98,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          left: 40.77,
                                          top: -1.73,
                                          child: SizedBox(
                                            width: 189,
                                            child: Text(
                                              'Total: ${widget.viewModel.stats?.totalWords ?? 0} words learned',
                                              textAlign: TextAlign.center,
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
                          ),
                          Positioned(
                            left: 24,
                            top: 1132.75,
                            child: Container(
                              width: 340,
                              height: 766,
                              padding: const EdgeInsets.only(
                                top: 25.27,
                                left: 25.27,
                                right: 25.27,
                                bottom: 1.27,
                              ),
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
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 24,
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
                                            'Achievement Badges',
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
                                    width: double.infinity,
                                    height: 667.19,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          left: -0.27,
                                          top: -0.25,
                                          child: Container(
                                            width: 134,
                                            height: 227,
                                            decoration: ShapeDecoration(
                                              color: const Color(0xFFFFEDD4),
                                              shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                  width: 1.27,
                                                  color: const Color(0xFFFFB869),
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
                                                  left: 17.27,
                                                  top: 17.27,
                                                  child: Container(
                                                    width: 94.39,
                                                    height: 24,
                                                    padding: const EdgeInsets.only(right: 70.39),
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Container(
                                                          width: double.infinity,
                                                          height: 24,
                                                          clipBehavior: Clip.antiAlias,
                                                          decoration: BoxDecoration(),
                                                          child: SvgPicture.asset(
                                                            'assets/icons/fire.svg',
                                                            fit: BoxFit.contain,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  left: 17.27,
                                                  top: 53.26,
                                                  child: Container(
                                                    width: 94.39,
                                                    height: 47.96,
                                                    child: Stack(
                                                      children: [
                                                        Positioned(
                                                          left: 0,
                                                          top: -1.73,
                                                          child: SizedBox(
                                                            width: 49,
                                                            child: Text(
                                                              '7-Day Streak',
                                                              style: TextStyle(
                                                                color: const Color(0xFF101727),
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
                                                  left: 17.27,
                                                  top: 101.22,
                                                  child: Container(
                                                    width: 94.39,
                                                    height: 71.94,
                                                    child: Stack(
                                                      children: [
                                                        Positioned(
                                                          left: -0.27,
                                                          top: -2.22,
                                                          child: SizedBox(
                                                            width: 89,
                                                            child: Text(
                                                              'Learn 7 days in a row',
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
                                                Positioned(
                                                  left: 17.27,
                                                  top: 185.15,
                                                  child: Container(
                                                    width: 81.56,
                                                    height: 23.98,
                                                    decoration: ShapeDecoration(
                                                      color: Colors.white.withValues(alpha: 0.60),
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(42770700),
                                                      ),
                                                    ),
                                                    child: Stack(
                                                      children: [
                                                        Positioned(
                                                          left: 7.99,
                                                          top: 7.99,
                                                          child: Container(
                                                            width: 7.99,
                                                            height: 7.99,
                                                            decoration: ShapeDecoration(
                                                              color: const Color(0xFF10B981),
                                                              shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(42770700),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Positioned(
                                                          left: 19.96,
                                                          top: 3.98,
                                                          child: Container(
                                                            width: 53.62,
                                                            height: 16.01,
                                                            child: Row(
                                                              mainAxisSize: MainAxisSize.min,
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Text(
                                                                  'Unlocked',
                                                                  style: TextStyle(
                                                                    color: const Color(0xFF354152),
                                                                    fontSize: 12,
                                                                    fontFamily: 'Inter',
                                                                    fontWeight: FontWeight.w400,
                                                                    height: 1.33,
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
                                          left: 150,
                                          top: -0.25,
                                          child: Container(
                                            width: 134,
                                            height: 226,
                                            decoration: ShapeDecoration(
                                              color: const Color(0xFFFEF9C2),
                                              shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                  width: 1.27,
                                                  color: const Color(0xFFFFDF20),
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
                                                  left: 17.27,
                                                  top: 17.27,
                                                  child: Container(
                                                    width: 94.39,
                                                    height: 24,
                                                    padding: const EdgeInsets.only(right: 70.39),
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Container(
                                                          width: double.infinity,
                                                          height: 24,
                                                          clipBehavior: Clip.antiAlias,
                                                          decoration: BoxDecoration(),
                                                          child: SvgPicture.asset(
                                                            'assets/icons/winner.svg',
                                                            fit: BoxFit.contain,
                                                          )
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  left: 17.27,
                                                  top: 53.26,
                                                  child: Container(
                                                    width: 94.39,
                                                    height: 23.98,
                                                    child: Stack(
                                                      children: [
                                                        Positioned(
                                                          left: 0,
                                                          top: -1.73,
                                                          child: Text(
                                                            '100 Words',
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
                                                  left: 17.27,
                                                  top: 77.24,
                                                  child: Container(
                                                    width: 94.39,
                                                    height: 71.94,
                                                    child: Stack(
                                                      children: [
                                                        Positioned(
                                                          left: 0,
                                                          top: -1.73,
                                                          child: SizedBox(
                                                            width: 84,
                                                            child: Text(
                                                              'Learn 100 vocabulary words',
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
                                                Positioned(
                                                  left: 17.27,
                                                  top: 161.17,
                                                  child: Container(
                                                    width: 81.56,
                                                    height: 23.98,
                                                    decoration: ShapeDecoration(
                                                      color: Colors.white.withValues(alpha: 0.60),
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(42770700),
                                                      ),
                                                    ),
                                                    child: Stack(
                                                      children: [
                                                        Positioned(
                                                          left: 7.99,
                                                          top: 7.99,
                                                          child: Container(
                                                            width: 7.99,
                                                            height: 7.99,
                                                            decoration: ShapeDecoration(
                                                              color: const Color(0xFF10B981),
                                                              shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(42770700),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Positioned(
                                                          left: 19.96,
                                                          top: 3.98,
                                                          child: Container(
                                                            width: 53.62,
                                                            height: 16.01,
                                                            child: Row(
                                                              mainAxisSize: MainAxisSize.min,
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Text(
                                                                  'Unlocked',
                                                                  style: TextStyle(
                                                                    color: const Color(0xFF354152),
                                                                    fontSize: 12,
                                                                    fontFamily: 'Inter',
                                                                    fontWeight: FontWeight.w400,
                                                                    height: 1.33,
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
                                          left: -0.27,
                                          top: 238.75,
                                          child: Container(
                                            width: 134,
                                            height: 226,
                                            decoration: ShapeDecoration(
                                              color: const Color(0xFFDFE7FF),
                                              shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                  width: 1.27,
                                                  color: const Color(0xFFA2B3FF),
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
                                                  left: 17.27,
                                                  top: 17.27,
                                                  child: Container(
                                                    width: 94.39,
                                                    height: 36,
                                                    padding: const EdgeInsets.only(right: 70.39),
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Container(
                                                          width: 32,
                                                          height: 32,
                                                          clipBehavior: Clip.antiAlias,
                                                          decoration: BoxDecoration(),
                                                          child: Icon(
                                                            Icons.star_border_outlined,
                                                            color: const Color(0xAF4100FF),
                                                            size: 26,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  left: 17.73,
                                                  top: 41.36,
                                                  child: Container(
                                                    width: 196,
                                                    height: 70,
                                                    child: Stack(
                                                      children: [
                                                        Positioned(
                                                          left: 0,
                                                          top: 11,
                                                          child: SizedBox(
                                                            width: 90,
                                                            child: Text(
                                                              'Perfect Score',
                                                              style: TextStyle(
                                                                color: const Color(0xFF101727),
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
                                                  left: 17.27,
                                                  top: 101.22,
                                                  child: Container(
                                                    width: 94.39,
                                                    height: 71.94,
                                                    child: Stack(
                                                      children: [
                                                        Positioned(
                                                          left: 0,
                                                          top: -1.73,
                                                          child: SizedBox(
                                                            width: 94,
                                                            child: Text(
                                                              'Get 10/10 on grammar check',
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
                                                Positioned(
                                                  left: 17.27,
                                                  top: 185.15,
                                                  child: Container(
                                                    width: 81.56,
                                                    height: 23.98,
                                                    decoration: ShapeDecoration(
                                                      color: Colors.white.withValues(alpha: 0.60),
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(42770700),
                                                      ),
                                                    ),
                                                    child: Stack(
                                                      children: [
                                                        Positioned(
                                                          left: 7.99,
                                                          top: 7.99,
                                                          child: Container(
                                                            width: 7.99,
                                                            height: 7.99,
                                                            decoration: ShapeDecoration(
                                                              color: const Color(0xFF10B981),
                                                              shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(42770700),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Positioned(
                                                          left: 19.96,
                                                          top: 3.98,
                                                          child: Container(
                                                            width: 53.62,
                                                            height: 16.01,
                                                            child: Row(
                                                              mainAxisSize: MainAxisSize.min,
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Text(
                                                                  'Unlocked',
                                                                  style: TextStyle(
                                                                    color: const Color(0xFF354152),
                                                                    fontSize: 12,
                                                                    fontFamily: 'Inter',
                                                                    fontWeight: FontWeight.w400,
                                                                    height: 1.33,
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
                                          left: 150,
                                          top: 242.75,
                                          child: Container(
                                            width: 134,
                                            height: 226,
                                            decoration: ShapeDecoration(
                                              color: const Color(0xFFF2E7FE),
                                              shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                  width: 1.27,
                                                  color: const Color(0xFFD9B1FF),
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
                                                  left: 17.27,
                                                  top: 17.27,
                                                  child: Container(
                                                    width: 94.39,
                                                    height: 28,
                                                    padding: const EdgeInsets.only(right: 70.39),
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Container(
                                                          width: double.infinity,
                                                          height: 28,
                                                          clipBehavior: Clip.antiAlias,
                                                          decoration: BoxDecoration(),
                                                          child: Icon(
                                                            Icons.bolt_outlined,
                                                            color: Color(0xFFDFB0FF),
                                                            size: 28,
                                                            )
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  left: 17.27,
                                                  top: 53.26,
                                                  child: Container(
                                                    width: 94.39,
                                                    height: 47.96,
                                                    child: Stack(
                                                      children: [
                                                        Positioned(
                                                          left: 0,
                                                          top: -1.73,
                                                          child: SizedBox(
                                                            width: 59,
                                                            child: Text(
                                                              'Quick Learner',
                                                              style: TextStyle(
                                                                color: const Color(0xFF101727),
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
                                                  left: 17.27,
                                                  top: 101.22,
                                                  child: Container(
                                                    width: 94.39,
                                                    height: 71.94,
                                                    child: Stack(
                                                      children: [
                                                        Positioned(
                                                          left: 0,
                                                          top: -1.73,
                                                          child: SizedBox(
                                                            width: 68,
                                                            child: Text(
                                                              'Learn 20 words in one day',
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
                                                Positioned(
                                                  left: 17.27,
                                                  top: 185.15,
                                                  child: Container(
                                                    width: 81.56,
                                                    height: 23.98,
                                                    decoration: ShapeDecoration(
                                                      color: Colors.white.withValues(alpha: 0.60),
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(42770700),
                                                      ),
                                                    ),
                                                    child: Stack(
                                                      children: [
                                                        Positioned(
                                                          left: 7.99,
                                                          top: 7.99,
                                                          child: Container(
                                                            width: 7.99,
                                                            height: 7.99,
                                                            decoration: ShapeDecoration(
                                                              color: const Color(0xFF10B981),
                                                              shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(42770700),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Positioned(
                                                          left: 19.96,
                                                          top: 3.98,
                                                          child: Container(
                                                            width: 53.62,
                                                            height: 16.01,
                                                            child: Row(
                                                              mainAxisSize: MainAxisSize.min,
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Text(
                                                                  'Unlocked',
                                                                  style: TextStyle(
                                                                    color: const Color(0xFF354152),
                                                                    fontSize: 12,
                                                                    fontFamily: 'Inter',
                                                                    fontWeight: FontWeight.w400,
                                                                    height: 1.33,
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
                                          left: -0.27,
                                          top: 476.75,
                                          child: Container(
                                            width: 134,
                                            height: 190,
                                            decoration: ShapeDecoration(
                                              color: const Color(0xFFD0FAE5),
                                              shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                  width: 1.27,
                                                  color: const Color(0xFF5EE9B4),
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
                                                  left: 17.27,
                                                  top: 17.27,
                                                  child: Container(
                                                    width: 94.39,
                                                    height: 24,
                                                    padding: const EdgeInsets.only(right: 70.39),
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Container(
                                                          width: double.infinity,
                                                          height: 24,
                                                          clipBehavior: Clip.antiAlias,
                                                          decoration: BoxDecoration(),
                                                          child: SvgPicture.asset(
                                                            'assets/icons/reward_green.svg',
                                                            fit: BoxFit.contain,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  left: 17.27,
                                                  top: 53.26,
                                                  child: Container(
                                                    width: 94.39,
                                                    height: 23.98,
                                                    child: Stack(
                                                      children: [
                                                        Positioned(
                                                          left: 0,
                                                          top: -1.73,
                                                          child: Text(
                                                            'C1 Master',
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
                                                  left: 17.27,
                                                  top: 77.24,
                                                  child: Container(
                                                    width: 94.39,
                                                    height: 47.96,
                                                    child: Stack(
                                                      children: [
                                                        Positioned(
                                                          left: 0,
                                                          top: -1.73,
                                                          child: SizedBox(
                                                            width: 91,
                                                            child: Text(
                                                              'Learn 20 C1 level words',
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
                                                Positioned(
                                                  left: 17.27,
                                                  top: 137.19,
                                                  child: Container(
                                                    width: 81.56,
                                                    height: 23.98,
                                                    decoration: ShapeDecoration(
                                                      color: Colors.white.withValues(alpha: 0.60),
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(42770700),
                                                      ),
                                                    ),
                                                    child: Stack(
                                                      children: [
                                                        Positioned(
                                                          left: 7.99,
                                                          top: 7.99,
                                                          child: Container(
                                                            width: 7.99,
                                                            height: 7.99,
                                                            decoration: ShapeDecoration(
                                                              color: const Color(0xFF10B981),
                                                              shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(42770700),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Positioned(
                                                          left: 19.96,
                                                          top: 3.98,
                                                          child: Container(
                                                            width: 53.62,
                                                            height: 16.01,
                                                            child: Row(
                                                              mainAxisSize: MainAxisSize.min,
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Text(
                                                                  'Unlocked',
                                                                  style: TextStyle(
                                                                    color: const Color(0xFF354152),
                                                                    fontSize: 12,
                                                                    fontFamily: 'Inter',
                                                                    fontWeight: FontWeight.w400,
                                                                    height: 1.33,
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
                                          left: 150,
                                          top: 476.75,
                                          child: Opacity(
                                            opacity: 0.60,
                                            child: Container(
                                              width: 134,
                                              height: 190,
                                              padding: const EdgeInsets.only(
                                                top: 17.27,
                                                left: 17.27,
                                                right: 17.27,
                                                bottom: 1.27,
                                              ),
                                              decoration: ShapeDecoration(
                                                color: const Color(0xFFF9FAFB),
                                                shape: RoundedRectangleBorder(
                                                  side: BorderSide(
                                                    width: 1.27,
                                                    color: const Color(0xFFE5E7EB),
                                                  ),
                                                  borderRadius: BorderRadius.circular(16),
                                                ),
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                spacing: 11.99,
                                                children: [
                                                  Container(
                                                    width: double.infinity,
                                                    height: 24,
                                                    padding: const EdgeInsets.only(right: 70.39),
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Container(
                                                          width: double.infinity,
                                                          height: 24,
                                                          clipBehavior: Clip.antiAlias,
                                                          decoration: BoxDecoration(),
                                                          child: SvgPicture.asset(
                                                            'assets/icons/word.svg',
                                                            color: Colors.grey,
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
                                                            width: 57,
                                                            child: Text(
                                                              '30-Day Streak',
                                                              style: TextStyle(
                                                                color: const Color(0xFF697282),
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
                                                  Container(
                                                    width: double.infinity,
                                                    height: 71.94,
                                                    child: Stack(
                                                      children: [
                                                        Positioned(
                                                          left: 0,
                                                          top: -1.73,
                                                          child: SizedBox(
                                                            width: 68,
                                                            child: Text(
                                                              'Learn 30 days in a row',
                                                              style: TextStyle(
                                                                color: const Color(0xFF6A7282),
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
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            left: 24,
                            top: 1922.75,
                            child: Container(
                              width: 340,
                              height: 110,
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 0,
                                    top: 0,
                                    child: Container(
                                      width: 98.79,
                                      height: 110.46,
                                      padding: const EdgeInsets.only(
                                        top: 17.27,
                                        left: 17.27,
                                        right: 17.27,
                                        bottom: 1.27,
                                      ),
                                      decoration: ShapeDecoration(
                                        color: const Color(0xFFECFDF5),
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            width: 1.27,
                                            color: const Color(0xFFA4F3CF),
                                          ),
                                          borderRadius: BorderRadius.circular(16),
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
                                                Container(
                                                  width: double.infinity,
                                                  height: 23.98,
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    '${widget.viewModel.stats?.totalWords ?? 0}',
                                                    textAlign: TextAlign.center,
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
                                          Container(
                                            width: double.infinity,
                                            height: 47.96,
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                  left: 5.85,
                                                  top: -1.73,
                                                  child: SizedBox(
                                                    width: 49,
                                                    child: Text(
                                                      'Total Words',
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        color: const Color(0xFF495565),
                                                        fontSize: 14,
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
                                  Positioned(
                                    left: 121,
                                    top: 0,
                                    child: Container(
                                      width: 98.81,
                                      height: 110.46,
                                      padding: const EdgeInsets.only(
                                        top: 17.27,
                                        left: 17.27,
                                        right: 17.27,
                                        bottom: 1.27,
                                      ),
                                      decoration: ShapeDecoration(
                                        color: const Color(0xFFEFF6FF),
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            width: 1.27,
                                            color: const Color(0xFFBEDBFF),
                                          ),
                                          borderRadius: BorderRadius.circular(16),
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
                                                Container(
                                                  width: double.infinity,
                                                  height: 23.98,
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    '${widget.viewModel.stats?.streak ?? 0}',
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
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: double.infinity,
                                            height: 47.96,
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                  left: 5.87,
                                                  top: -1.73,
                                                  child: SizedBox(
                                                    width: 49,
                                                    child: Text(
                                                      'Day Streak',
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        color: const Color(0xFF495565),
                                                        fontSize: 14,
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
                                  Positioned(
                                    left: 241,
                                    top: 0,
                                    child: Container(
                                      width: 98.79,
                                      height: 110.46,
                                      padding: const EdgeInsets.only(
                                        top: 17.27,
                                        left: 17.27,
                                        right: 17.27,
                                        bottom: 1.27,
                                      ),
                                      decoration: ShapeDecoration(
                                        color: const Color(0xFFFFF7ED),
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            width: 1.27,
                                            color: const Color(0xFFFFD6A7),
                                          ),
                                          borderRadius: BorderRadius.circular(16),
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
                                                Container(
                                                  width: double.infinity,
                                                  height: 23.98,
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    '${(widget.viewModel.stats?.accuracy ?? 0).round()}%',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: const Color(0xFFFF6B35),
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
                                            width: 88,
                                            height: 24,
                                            clipBehavior: Clip.antiAlias,
                                            decoration: BoxDecoration(),
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                  top: -1.73,
                                                  child: Text(
                                                    'Accuracy',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: const Color(0xFF495565),
                                                      fontSize: 14,
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
    );
  }
}
class CefrBarChart extends StatelessWidget {
  final StatisticsViewModel viewModel;
  const CefrBarChart({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final data = viewModel.stats?.cefrCounts ?? {};
    if (data.isEmpty) {
      return const Center(child: Text("No data"));
    }

    final maxValue = data.values.reduce((a, b) => a > b ? a : b).toDouble();
    
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: data.entries.map((e) {
        final double height = maxValue == 0 ? 0 : (e.value / maxValue) * 160;
        return Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 24,
                height: height,
                decoration: BoxDecoration(
                  color: const Color(0xFF0B5394),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              const SizedBox(height: 6),
              Text(e.key, style: const TextStyle(fontSize: 10)),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class KindPieChart extends StatelessWidget {
  final Map<String, int> data;

  const KindPieChart({super.key, required this.data});

  static const _colors = {
    'Noun': Color(0xFF6366F1),
    'Verb': Color(0xFF8B5CF6),
    'Adjective': Color(0xFFEC4899),
    'Adverb': Color(0xFFF59E0B),
    'Other': Color(0xFF10B981),
  };

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _KindPiePainter(data),
      size: Size.infinite,
    );
  }
}

class _KindPiePainter extends CustomPainter {
  final Map<String, int> data;

  _KindPiePainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    final total = data.values.fold<int>(0, (a, b) => a + b);
    if (total == 0) return;

    final center = size.center(Offset.zero);
    final radius = min(size.width, size.height) / 2;
    final innerRadius = radius * 0.55;

    var startAngle = -pi / 2;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = radius - innerRadius;

    for (final entry in data.entries) {
      final value = entry.value;
      if (value == 0) continue;

      final sweep = (value / total) * 2 * pi;
      paint.color = KindPieChart._colors[entry.key] ?? Colors.grey;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: (radius + innerRadius) / 2),
        startAngle,
        sweep,
        false,
        paint,
      );

      startAngle += sweep;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}