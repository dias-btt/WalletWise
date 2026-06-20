import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:wallet_wise/core/network/network_info.dart';
import 'package:wallet_wise/core/theme/app_colors.dart';
import 'package:wallet_wise/injection_container.dart';

class OfflineBanner extends StatefulWidget {
  const OfflineBanner({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  State<OfflineBanner> createState() => _OfflineBannerState();
}

class _OfflineBannerState extends State<OfflineBanner> {
  late final NetworkInfo _networkInfo;
  StreamSubscription<List<ConnectivityResult>>? _subscription;
  bool _isOffline = false;

  @override
  void initState() {
    super.initState();
    _networkInfo = getIt<NetworkInfo>();
    _checkInitialConnectivity();
    _subscription = _networkInfo.onConnectivityChanged.listen(
      _handleConnectivityChange,
    );
  }

  Future<void> _checkInitialConnectivity() async {
    final bool connected = await _networkInfo.isConnected;
    if (mounted) {
      setState(() => _isOffline = !connected);
    }
  }

  void _handleConnectivityChange(List<ConnectivityResult> results) {
    final bool connected =
        results.any((ConnectivityResult r) => r != ConnectivityResult.none);
    if (mounted) {
      setState(() => _isOffline = !connected);
    }
  }

  @override
  void dispose() {
    unawaited(_subscription?.cancel());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AnimatedSlide(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          offset: _isOffline ? Offset.zero : const Offset(0, -1),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: _isOffline ? 1 : 0,
            child: Material(
              color: AppColors.warningAmber,
              child: SafeArea(
                bottom: false,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  child: Row(
                    children: <Widget>[
                      const Icon(
                        Icons.wifi_off,
                        color: AppColors.textPrimaryLight,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'No internet — showing cached data',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppColors.textPrimaryLight,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(child: widget.child),
      ],
    );
  }
}
