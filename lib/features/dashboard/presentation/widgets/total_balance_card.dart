import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wallet_wise/core/theme/app_colors.dart';

class TotalBalanceCard extends StatefulWidget {
  const TotalBalanceCard({
    required this.totalBalance,
    required this.currencyCode,
    required this.isLoading,
    super.key,
  });

  final double totalBalance;
  final String currencyCode;
  final bool isLoading;

  @override
  State<TotalBalanceCard> createState() => _TotalBalanceCardState();
}

class _TotalBalanceCardState extends State<TotalBalanceCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _balanceAnimation;
  double _displayBalance = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _balanceAnimation = Tween<double>(
      begin: 0,
      end: widget.totalBalance,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    )..addListener(() {
        setState(() => _displayBalance = _balanceAnimation.value);
      });
  }

  @override
  void didUpdateWidget(covariant TotalBalanceCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!widget.isLoading &&
        oldWidget.totalBalance != widget.totalBalance) {
      _balanceAnimation = Tween<double>(
        begin: _displayBalance,
        end: widget.totalBalance,
      ).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
      );
      _controller
        ..reset()
        ..forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading) {
      return _buildShimmer(context);
    }

    if (_controller.status == AnimationStatus.dismissed) {
      _controller.forward();
    }

    final String formatted = NumberFormat.currency(
      symbol: '',
      decimalDigits: 2,
    ).format(_displayBalance);

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            AppColors.primary,
            AppColors.primaryDark,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.25),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Total Balance',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.textPrimaryDark.withValues(alpha: 0.8),
                ),
          ),
          const SizedBox(height: 8),
          Text(
            '$formatted ${widget.currencyCode}',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: AppColors.textPrimaryDark,
                  fontWeight: FontWeight.bold,
                ),
          )
              .animate()
              .fadeIn(duration: 300.ms)
              .slideY(begin: 0.1, end: 0, duration: 300.ms),
        ],
      ),
    );
  }

  Widget _buildShimmer(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.borderLight,
      highlightColor: AppColors.surfaceLight,
      child: Container(
        width: double.infinity,
        height: 120,
        margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
        decoration: BoxDecoration(
          color: AppColors.surfaceLight,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
