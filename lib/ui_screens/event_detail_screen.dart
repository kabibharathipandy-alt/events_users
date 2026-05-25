import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:async';
import '../widgets/responsive_layout.dart';
import '../widgets/color.dart';

class EventDetailScreen extends StatefulWidget {
  final String eventId;
  final bool isPastEvent;

  const EventDetailScreen({
    super.key,
    required this.eventId,
    this.isPastEvent = false,
  });

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  Timer? _timer;
  Duration _timeLeft = const Duration();
  final DateTime _eventStartTime = DateTime.now().add(
    const Duration(days: 7, hours: 19, minutes: 48, seconds: 18),
  ); // Mock

  @override
  void initState() {
    super.initState();
    if (!widget.isPastEvent) {
      _startCountdown();
    }
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final now = DateTime.now();
      if (_eventStartTime.isAfter(now)) {
        setState(() {
          _timeLeft = _eventStartTime.difference(now);
        });
      } else {
        _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _showSignInModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Sign In',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(),
              const SizedBox(height: 16),
              const Text(
                'Email Address or Ticket ID',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Checkbox(value: false, onChanged: (v) {}),
                  const Text('Remember Me'),
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6200EA), // Deep purple
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: const Text(
                    'GET SIGN-IN EMAIL',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          _buildTopNav(),
          SliverToBoxAdapter(
            child: ResponsiveLayout(
              mobile: _buildMobileLayout(context),
              desktop: _buildDesktopLayout(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopNav() {
    return SliverAppBar(
      pinned: true,
      backgroundColor: AppColor.primary,
      elevation: 1,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo placeholder
          InkWell(
            onTap: () => context.go('/'),
            child: const Row(
              children: [
                Icon(Icons.arrow_back, color: Colors.black54),
                SizedBox(width: 8),
                Text(
                  'Kumudam Events',
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          // Links
          if (ResponsiveLayout.isDesktop(context))
            Row(
              children: [
                _navLink(
                  'HOME',
                  isSelected: true,
                  onTap: () => context.go('/'),
                ),
                const SizedBox(width: 24),
                _navLink(
                  'REGISTER HERE',
                  onTap: () => context.go('/events/${widget.eventId}/register'),
                ),
                const SizedBox(width: 24),
                _navLink('VENUE', onTap: () {}),
                const SizedBox(width: 24),
                _navLink('SIGN IN', onTap: () => _showSignInModal(context)),
              ],
            )
          else
            IconButton(
              icon: const Icon(Icons.login, color: Colors.black),
              onPressed: () => _showSignInModal(context),
            ),
        ],
      ),
    );
  }

  Widget _navLink(
    String title, {
    bool isSelected = false,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? AppColor.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(children: [_buildHero(), _buildVenueSection()]);
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Column(
      children: [
        _buildHero(),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 48.0,
            horizontal: 128.0,
          ),
          child: _buildVenueSection(),
        ),
      ],
    );
  }

  Widget _buildHero() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFE3F2FD), // Light blue
            Color(0xFFF3E5F5), // Light purple
            Color(0xFFFFFFFF),
          ],
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 24),
      child: Column(
        children: [
          // Banner Image
          Container(
            constraints: const BoxConstraints(maxWidth: 600),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/images/events (1).jpg',
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 200,
                  color: Colors.grey.shade300,
                  alignment: Alignment.center,
                  child: const Icon(Icons.image, size: 64, color: Colors.grey),
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),
          // Title
          const Text(
            'Magalir Thiruvizha - Cuddalore Event 2026',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          // Date & Time
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.calendar_today, size: 16, color: Colors.black54),
              SizedBox(width: 8),
              Text(
                'May 30, 2026',
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              SizedBox(width: 24),
              Icon(Icons.access_time, size: 16, color: Colors.black54),
              SizedBox(width: 8),
              Text(
                '08:00 AM',
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Location
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.location_on, size: 16, color: Colors.black54),
              SizedBox(width: 8),
              Text(
                'Cuddalore, Tamil Nadu - India',
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
            ],
          ),
          const SizedBox(height: 32),
          // Register Button
          if (widget.isPastEvent)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'REGISTRATION CLOSED',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
            )
          else
            ElevatedButton(
              onPressed: () => context.go('/events/${widget.eventId}/register'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.secondary, // Deep purple
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 48,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: const Text(
                'REGISTER NOW',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          const SizedBox(height: 32),
          // Countdown Timer (Only if live)
          if (!widget.isPastEvent) _buildCountdownTimer(),
        ],
      ),
    );
  }

  Widget _buildCountdownTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildTimeBox(_timeLeft.inDays.toString().padLeft(2, '0')),
        const SizedBox(width: 8),
        _buildTimeBox((_timeLeft.inHours % 24).toString().padLeft(2, '0')),
        const SizedBox(width: 8),
        _buildTimeBox((_timeLeft.inMinutes % 60).toString().padLeft(2, '0')),
        const SizedBox(width: 8),
        _buildTimeBox((_timeLeft.inSeconds % 60).toString().padLeft(2, '0')),
      ],
    );
  }

  Widget _buildTimeBox(String time) {
    return Container(
      width: 60,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: Colors.black87),
        borderRadius: BorderRadius.circular(4),
      ),
      alignment: Alignment.center,
      child: Text(
        time,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildVenueSection() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Venue',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: AppColor.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Our location and how you can get here',
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
          const SizedBox(height: 32),
          ResponsiveLayout.isMobile(context)
              ? Column(
                  children: [
                    _buildVenueDetails(),
                    const SizedBox(height: 32),
                    _buildMapPlaceholder(),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 1, child: _buildVenueDetails()),
                    const SizedBox(width: 48),
                    Expanded(flex: 2, child: _buildMapPlaceholder()),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildVenueDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            'assets/images/events (4).jpg',
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Address',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text('KSR Mahal', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        const Text(
          'QQ67+JJ7, Nethaji Rd (Pondy, North Venugopalapuram, Manjakuppam, Cuddalore, Tamil Nadu - 607001\nIndia',
          style: TextStyle(height: 1.5, color: Colors.black87),
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.primary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          child: const Text(
            'GET DIRECTIONS',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildMapPlaceholder() {
    return Container(
      height: 450,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.map, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'Interactive Map Placeholder',
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '(Requires Google Maps API Key)',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
