import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/responsive_layout.dart';
import '../models/event_model.dart';
import '../widgets/color.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  
  // Filter options
  final List<String> _availableCities = ['Chennai', 'Madurai', 'Coimbatore', 'Virtual'];
  final List<String> _availableCategories = ['Tech', 'Business', 'Education', 'Lifestyle'];
  final List<String> _availableEventTypes = ['In-Person', 'Virtual', 'Hybrid'];

  // Selected filters
  String? _selectedCity;
  String? _selectedCategory;
  String? _selectedEventType;

  // Mock data
  late List<EventModel> _allEvents;
  late List<EventModel> _filteredLiveEvents;
  late List<EventModel> _filteredPastEvents;

  @override
  void initState() {
    super.initState();
    _allEvents = [
      EventModel(
        id: '1',
        title: 'An Investor Education & Awareness Initiative by Canara Robeco',
        description: 'Join us for a specialized financial awareness initiative.',
        startDate: DateTime(2026, 5, 30, 4, 0),
        endDate: DateTime(2026, 5, 30, 6, 0),
        location: 'Virtual',
        eventType: 'Virtual',
        bannerImage: 'https://via.placeholder.com/600x400?text=Kumudam+Banner', // Placeholder for kumudam.jpg banner
        status: 'Live',
        url: 'https://connect1.hindutamil.in/events/live-event',
        categoryIds: ['Education', 'Business'],
      ),
      EventModel(
        id: '2',
        title: 'Technology Summit 2026',
        description: 'Join us for the ultimate technology summit.',
        startDate: DateTime.now().subtract(const Duration(days: 10)),
        endDate: DateTime.now().subtract(const Duration(days: 8)),
        location: 'Chennai Trade Centre',
        eventType: 'In-Person',
        bannerImage: 'https://via.placeholder.com/400x200?text=Tech+Summit',
        status: 'Past',
        url: 'https://connect1.hindutamil.in/events/tech-summit',
        categoryIds: ['Tech'],
      ),
      EventModel(
        id: '3',
        title: 'Business Conclave',
        description: 'Discussing the future of business.',
        startDate: DateTime.now().subtract(const Duration(days: 20)),
        endDate: DateTime.now().subtract(const Duration(days: 19)),
        location: 'Virtual',
        eventType: 'Virtual',
        bannerImage: 'https://via.placeholder.com/400x200?text=Business',
        status: 'Past',
        url: 'https://connect1.hindutamil.in/events/business',
        categoryIds: ['Business'],
      ),
    ];
    _applyFilters();
  }

  void _applyFilters() {
    setState(() {
      final query = _searchController.text.toLowerCase();

      final filtered = _allEvents.where((event) {
        final matchesSearch = query.isEmpty || event.title.toLowerCase().contains(query) || event.description.toLowerCase().contains(query);
        final matchesCity = _selectedCity == null || _selectedCity == 'All Cities' || _selectedCity == event.location;
        final matchesCategory = _selectedCategory == null || _selectedCategory == 'All Categories' || event.categoryIds.contains(_selectedCategory);
        final matchesEventType = _selectedEventType == null || _selectedEventType == 'All Types' || _selectedEventType == event.eventType;

        return matchesSearch && matchesCity && matchesCategory && matchesEventType;
      }).toList();

      _filteredLiveEvents = filtered.where((e) => e.status == 'Live').toList();
      _filteredPastEvents = filtered.where((e) => e.status == 'Past').toList();
    });
  }

  void _clearFilters() {
    setState(() {
      _searchController.clear();
      _selectedCity = null;
      _selectedCategory = null;
      _selectedEventType = null;
      _applyFilters();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: _buildLayout(crossAxisCount: 1),
      tablet: _buildLayout(crossAxisCount: 2),
      desktop: _buildLayout(crossAxisCount: 3),
    );
  }

  Widget _buildLayout({required int crossAxisCount}) {
    return Column(
      children: [
        _buildTopFilters(),
        Expanded(child: _buildContent(crossAxisCount: crossAxisCount)),
      ],
    );
  }

  Widget _buildTopFilters() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Wrap(
        spacing: 16,
        runSpacing: 16,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          // Search Field
          SizedBox(
            width: 250,
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search Events...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
              ),
              onSubmitted: (_) => _applyFilters(),
            ),
          ),
          
          // Dropdowns
          _buildDropdown('City', _availableCities, _selectedCity, (val) => setState(() => _selectedCity = val)),
          _buildDropdown('Category', _availableCategories, _selectedCategory, (val) => setState(() => _selectedCategory = val)),
          _buildDropdown('Event Type', _availableEventTypes, _selectedEventType, (val) => setState(() => _selectedEventType = val)),
          
          // Actions
          ElevatedButton(
            onPressed: _applyFilters,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            ),
            child: const Text('Apply'),
          ),
          TextButton(
            onPressed: _clearFilters,
            child: const Text('Clear', style: TextStyle(color: AppColor.textSecondary)),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(String hint, List<String> options, String? selectedValue, ValueChanged<String?> onChanged) {
    final allOptions = ['All $hint', ...options];
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: Text(hint),
          value: selectedValue,
          items: allOptions.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildContent({required int crossAxisCount}) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_filteredLiveEvents.isNotEmpty) ...[
            Text('Live Events (${_filteredLiveEvents.length})', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ..._filteredLiveEvents.map((event) => _buildLiveEventCard(event)),
            const SizedBox(height: 48),
          ],
          if (_filteredPastEvents.isNotEmpty) ...[
            Text('Past Events (${_filteredPastEvents.length})', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.8,
              ),
              itemCount: _filteredPastEvents.length,
              itemBuilder: (context, index) {
                return _buildPastEventCard(_filteredPastEvents[index]);
              },
            ),
          ],
          if (_filteredLiveEvents.isEmpty && _filteredPastEvents.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(48.0),
                child: Text('No events found', style: TextStyle(fontSize: 18, color: Colors.grey)),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildLiveEventCard(EventModel event) {
    return GestureDetector(
      onTap: () => context.go('/events/${event.id}', extra: false),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFF0F3A7D), // Deep blue from image
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
        child: Column(
          children: [
            // Center Image
            Container(
              constraints: const BoxConstraints(maxWidth: 500),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  event.bannerImage,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 200,
                    color: Colors.white,
                    alignment: Alignment.center,
                    child: const Text('Kumudam Banner'),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              event.title,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.calendar_today, color: Colors.white70, size: 16),
                const SizedBox(width: 8),
                Text(
                  '${event.startDate.toLocal()}'.split('.')[0], // Simplistic format
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => context.go('/events/${event.id}/register'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              ),
              child: const Text('REGISTER NOW', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPastEventCard(EventModel event) {
    return GestureDetector(
      onTap: () => context.go('/events/${event.id}', extra: true),
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 4,
        color: AppColor.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Image.network(
                event.bannerImage,
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey.shade300),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.title,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColor.textPrimary),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 16, color: AppColor.textSecondary),
                      const SizedBox(width: 6),
                      Text('${event.startDate.toLocal()}'.split(' ')[0], style: const TextStyle(color: AppColor.textSecondary)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 16, color: AppColor.textSecondary),
                      const SizedBox(width: 6),
                      Expanded(child: Text(event.location, style: const TextStyle(color: AppColor.textSecondary), maxLines: 1, overflow: TextOverflow.ellipsis)),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
