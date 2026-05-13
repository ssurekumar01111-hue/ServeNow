import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:handyman/core/theme/app_colors.dart';
import 'package:handyman/features/jobs/domain/entities/job_entity.dart';
import 'package:handyman/features/jobs/presentation/providers/jobs_providers.dart';

class OTPVerifyScreen extends ConsumerStatefulWidget {
  const OTPVerifyScreen({required this.jobId, super.key});
  final String jobId;

  @override
  ConsumerState<OTPVerifyScreen> createState() => _OTPVerifyScreenState();
}

class _OTPVerifyScreenState extends ConsumerState<OTPVerifyScreen> {
  final List<TextEditingController> _controllers = List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());
  bool _isLoading = false;

  @override
  void dispose() {
    for (var c in _controllers) {
      c.dispose();
    }
    for (var f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  String get _otp => _controllers.map((c) => c.text).join();

  void _onVerify() async {
    if (_otp.length < 4) return;

    final jobsAsync = ref.read(jobsProvider);
    final job = jobsAsync.value?.where((j) => j.id == widget.jobId).firstOrNull;

    if (job != null && _otp == job.otp) {
      setState(() => _isLoading = true);
      try {
        // Update status to in_progress
        await ref.read(jobStatusProvider.notifier).updateStatus(widget.jobId, JobStatus.inProgress);
        if (mounted) context.pop();
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
        }
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Incorrect OTP. Ask the customer to check their app.'),
        backgroundColor: AppColors.error,
      ));
      // Clear and focus first
      for (var c in _controllers) {
        c.clear();
      }
      _focusNodes[0].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Verify Job Start'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              FadeInDown(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.vpn_key_rounded, size: 48, color: AppColors.primary),
                ),
              ),
              const SizedBox(height: 32),
              FadeInUp(
                child: const Text(
                  'OTP Verification',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
              const SizedBox(height: 12),
              FadeInUp(
                delay: const Duration(milliseconds: 100),
                child: const Text(
                  'Ask the customer for their 4-digit booking OTP to start the service.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    height: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 48),
              FadeInUp(
                delay: const Duration(milliseconds: 200),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(4, (index) => _buildOTPBox(index)),
                ),
              ),
              const SizedBox(height: 60),
              FadeInUp(
                delay: const Duration(milliseconds: 300),
                child: Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: const LinearGradient(
                      colors: AppColors.primaryGradient,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _onVerify,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                          )
                        : const Text(
                            'Verify & Start Job',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOTPBox(int index) {
    return Container(
      width: 64,
      height: 72,
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _focusNodes[index].hasFocus ? AppColors.primary : Colors.grey.shade200,
          width: 2,
        ),
      ),
      child: Center(
        child: TextField(
          controller: _controllers[index],
          focusNode: _focusNodes[index],
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          maxLength: 1,
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
          decoration: const InputDecoration(
            counterText: '',
            border: InputBorder.none,
          ),
          onChanged: (value) {
            if (value.isNotEmpty && index < 3) {
              _focusNodes[index + 1].requestFocus();
            } else if (value.isEmpty && index > 0) {
              _focusNodes[index - 1].requestFocus();
            }
            if (_otp.length == 4) {
              FocusScope.of(context).unfocus();
            }
            setState(() {});
          },
        ),
      ),
    );
  }
}
