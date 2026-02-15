import 'package:flutter/material.dart';
import '../utils/one_time_setup.dart';

/// Setup Screen - Run this once to initialize Firebase collections
class SetupScreen extends StatefulWidget {
  const SetupScreen({super.key});

  @override
  State<SetupScreen> createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  bool _isLoading = false;
  bool _isComplete = false;
  String _statusMessage = '';
  Map<String, bool> _results = {};

  Future<void> _setupCollections() async {
    setState(() {
      _isLoading = true;
      _statusMessage = 'Setting up collections...';
      _isComplete = false;
    });

    try {
      final results = await OneTimeSetup.setupCollections();
      
      setState(() {
        _results = results;
        _isLoading = false;
        _isComplete = true;
        _statusMessage = 'Setup completed successfully!';
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ Collections setup complete!'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _statusMessage = 'Error: $e';
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('❌ Error: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 5),
          ),
        );
      }
    }
  }

  Future<void> _cleanupSamples() async {
    setState(() {
      _isLoading = true;
      _statusMessage = 'Cleaning up sample documents...';
    });

    try {
      await OneTimeSetup.cleanupSamples();
      
      setState(() {
        _isLoading = false;
        _statusMessage = 'Cleanup complete!';
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ Sample documents removed!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _statusMessage = 'Error: $e';
      });
    }
  }

  Future<void> _cleanupAllMockData() async {
    setState(() {
      _isLoading = true;
      _statusMessage = 'Cleaning up all mock data...';
    });

    try {
      final result = await OneTimeSetup.cleanupAllMockData();
      final mockCount = result['mockBeneficiaries'] as int? ?? 0;
      final sampleCount = result['sampleDocs'] as int? ?? 0;
      final total = mockCount + sampleCount;

      setState(() {
        _isLoading = false;
        _statusMessage = total > 0
            ? 'Removed $mockCount mock beneficiary(ies), $sampleCount sample doc(s).'
            : 'No mock data found (already clean).';
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(total > 0
                ? '✅ Mock data cleaned: $mockCount beneficiaries, $sampleCount sample docs.'
                : '✅ No mock data to remove.'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _statusMessage = 'Error: $e';
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('❌ Error: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  Future<void> _clearServingAndQueueHistory() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear serving & queue history?'),
        content: const Text(
          'This will permanently delete ALL documents in:\n\n'
          '• servingTransactions\n'
          '• queueHistory\n\n'
          'Issued queue numbers and serving records will be lost. Continue?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Clear all'),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;

    setState(() {
      _isLoading = true;
      _statusMessage = 'Clearing servingTransactions and queueHistory...';
    });

    try {
      final result = await OneTimeSetup.clearServingAndQueueHistory();
      final servingCount = result['servingTransactions'] ?? 0;
      final queueCount = result['queueHistory'] ?? 0;

      setState(() {
        _isLoading = false;
        _statusMessage = 'Cleared: $servingCount servingTransactions, $queueCount queueHistory.';
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('✅ Cleared $servingCount servingTransactions, $queueCount queueHistory.'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _statusMessage = 'Error: $e';
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('❌ Error: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 5),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Setup'),
        backgroundColor: const Color(0xFF81CF01),
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFE8F5E9), Colors.white],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
              const Text(
                'Firebase Collections Setup',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A237E),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Project: et3am-ca94c',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 32),
              
              if (_statusMessage.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: _isComplete ? Colors.green.shade50 : Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: _isComplete ? Colors.green : Colors.blue,
                    ),
                  ),
                  child: Text(
                    _statusMessage,
                    style: TextStyle(
                      color: _isComplete ? Colors.green.shade900 : Colors.blue.shade900,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              
              const SizedBox(height: 24),
              
              ElevatedButton.icon(
                onPressed: _isLoading ? null : _setupCollections,
                icon: _isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.cloud_upload),
                label: Text(_isLoading ? 'Setting up...' : 'Setup Collections'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF81CF01),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: _isLoading ? null : _cleanupAllMockData,
                icon: const Icon(Icons.cleaning_services),
                label: const Text('Clean Up All Mock Data'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.deepOrange,
                  side: const BorderSide(color: Colors.deepOrange),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: _isLoading ? null : _clearServingAndQueueHistory,
                icon: const Icon(Icons.history),
                label: const Text('Clear servingTransactions & queueHistory'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                  side: const BorderSide(color: Colors.red),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              if (_isComplete) ...[
                const SizedBox(height: 8),
                OutlinedButton.icon(
                  onPressed: _isLoading ? null : _cleanupSamples,
                  icon: const Icon(Icons.delete_outline),
                  label: const Text('Remove Sample Documents Only'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.orange,
                    side: const BorderSide(color: Colors.orange),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
              
              const SizedBox(height: 32),
              
              const Text(
                'Collections to be created:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              
              ...['distributionAreas', 'queues', 'beneficiaries', 'admins', 
                  'volunteers', 'entities', 'queueHistory', 'reports']
                  .map((name) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          children: [
                            Icon(
                              _isComplete ? Icons.check_circle : Icons.radio_button_unchecked,
                              color: _isComplete ? Colors.green : Colors.grey,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(name),
                          ],
                        ),
                      )),
              
              const SizedBox(height: 32),
              const Text(
                'Note: This will create sample documents in each collection.\n'
                'You can remove them after verification.',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
        ),
      ),
    );
  }
}

