import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../theme.dart';

class ReservationScreen extends StatefulWidget {
  const ReservationScreen({super.key});

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  DateTime _selectedDate = DateTime.now().add(const Duration(days: 1));
  TimeOfDay _selectedTime = const TimeOfDay(hour: 19, minute: 00);
  int _guestCount = 2;
  bool _isReserving = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Book a Table')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Reserve your spot for an authentic Sri Lankan dining experience.',
              style: context.textStyles.bodyLarge?.withColor(Colors.grey[700]!),
            ),
            const SizedBox(height: 32),

            Text('Date', style: context.textStyles.titleMedium?.bold),
            const SizedBox(height: 8),
            InkWell(
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 30)),
                );
                if (date != null) setState(() => _selectedDate = date);
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.outline),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today, color: AppColors.primary),
                    const SizedBox(width: 16),
                    Text(
                      DateFormat('EEEE, d MMMM y').format(_selectedDate),
                      style: context.textStyles.bodyLarge,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            Text('Time', style: context.textStyles.titleMedium?.bold),
            const SizedBox(height: 8),
            InkWell(
              onTap: () async {
                final time = await showTimePicker(
                  context: context,
                  initialTime: _selectedTime,
                );
                if (time != null) setState(() => _selectedTime = time);
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.outline),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.access_time, color: AppColors.primary),
                    const SizedBox(width: 16),
                    Text(
                      _selectedTime.format(context),
                      style: context.textStyles.bodyLarge,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),


            Text('Number of Guests', style: context.textStyles.titleMedium?.bold),
            const SizedBox(height: 8),
            Row(
              children: [
                IconButton.filledTonal(
                  onPressed: () => setState(() => _guestCount = _guestCount > 1 ? _guestCount - 1 : 1),
                  icon: const Icon(Icons.remove),
                ),
                const SizedBox(width: 24),
                Text('$_guestCount Guests', style: context.textStyles.titleLarge?.bold),
                const SizedBox(width: 24),
                IconButton.filledTonal(
                  onPressed: () => setState(() => _guestCount++),
                  icon: const Icon(Icons.add),
                ),
              ],
            ),

            const SizedBox(height: 48),

            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _isReserving ? null : () {
                  setState(() => _isReserving = true);
                  Future.delayed(const Duration(seconds: 2), () {
                    if (mounted) {
                      setState(() => _isReserving = false);
                      showDialog(
                        context: context,
                        builder: (c) => AlertDialog(
                          icon: const Icon(Icons.check_circle, color: Colors.green, size: 48),
                          title: const Text('Reservation Confirmed!'),
                          content: const Text('We have booked your table. See you soon!'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(c);
                                context.pop();
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
                  });
                },
                child: _isReserving 
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Confirm Reservation'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
