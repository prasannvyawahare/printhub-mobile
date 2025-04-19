import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:widgets_easier/widgets_easier.dart';
import '../common_widget/print_hub_gradient_button.dart';
import '../common_widget/print_hub_app_bar.dart';
import 'delivery_screen.dart';

// Model Class
class PrintFile {
  final PlatformFile file;
  String? paperType;
  String? size;
  String? color;
  String? finish;
  int quantity;

  PrintFile({
    required this.file,
    this.paperType,
    this.size,
    this.color,
    this.finish,
    this.quantity = 1,
  });
}

class HomeDetailsScreen extends StatefulWidget {
  const HomeDetailsScreen({super.key});

  @override
  _HomeDetailsScreenState createState() => _HomeDetailsScreenState();
}

class _HomeDetailsScreenState extends State<HomeDetailsScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _printOptionsFormKey = GlobalKey<FormState>();

  final double basePrice = 12.00;
  final double optionsPrice = 3.50;
  List<PrintFile> uploadedFiles = [];

  @override
  Widget build(BuildContext context) {
    double totalPrice = _calculateTotalPrice();

    return Scaffold(
      appBar: const PrintHubAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildUploadFilesCard(),
              const SizedBox(height: 16),
              _buildPriceSummaryCard(totalPrice),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GradientButton(
          text: "Proceed to Checkout",
          onPressed: () {
            bool allValid = uploadedFiles.every((file) =>
                file.paperType != null &&
                file.size != null &&
                file.color != null &&
                file.finish != null &&
                file.quantity > 0);

            if (_formKey.currentState!.validate() &&
                uploadedFiles.isNotEmpty &&
                allValid) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DeliveryScreen()),
              );
            } else if (uploadedFiles.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Please upload at least one file.')),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Please complete all print options.')),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildUploadFilesCard() {
    return Card(
      elevation: 6,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Upload Files",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            InkWell(
              onTap: _pickFiles,
              child: Container(
                decoration: ShapeDecoration(
                 // shape: DashedBorder(borderRadius: BorderRadius.circular(10)),
                      shape: DashedBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  child: Center(
                    child: Column(
                      children: [
                        Icon(Icons.cloud_upload_rounded, size: 50),
                        SizedBox(height: 10),
                        Text(
                          "Click to select files\nSupported formats: PDF, JPG, PNG",
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ...uploadedFiles.map((file) => _buildFileItem(file)),
          ],
        ),
      ),
    );
  }

  void _pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'png'],
    );
    if (result != null) {
      setState(() {
        uploadedFiles.addAll(result.files.map((f) => PrintFile(file: f)));
      });
    }
  }

  void _removeFile(PrintFile printFile) {
    setState(() {
      uploadedFiles.remove(printFile);
    });
  }

  void _previewFile(PlatformFile file) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(file.name),
        content: (file.extension == 'jpg' || file.extension == 'png')
            ? Image.file(File(file.path!))
            : const Text("Preview not available for this file type."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }

  String _formatFileSize(int bytes) {
    if (bytes >= 1048576) {
      return "${(bytes / 1048576).toStringAsFixed(1)} MB";
    } else if (bytes >= 1024) {
      return "${(bytes / 1024).toStringAsFixed(1)} KB";
    } else {
      return "$bytes B";
    }
  }

  Widget _buildFileItem(PrintFile printFile) {
    PlatformFile file = printFile.file;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: GestureDetector(
        onTap: () => _previewFile(file),
        child: const Icon(Icons.insert_drive_file, color: Colors.blue),
      ),
      title: Text(file.name),
      subtitle: Text(_formatFileSize(file.size)),
      trailing: PopupMenuButton<String>(
        icon: const Icon(Icons.more_vert),
        color: Colors.white,
        itemBuilder: (context) => [
          const PopupMenuItem(value: 'printOptions', child: Text('Print Options')),
          const PopupMenuItem(value: 'preview', child: Text('Preview')),
          const PopupMenuItem(value: 'remove', child: Text('Remove')),
        ],
        onSelected: (value) {
          if (value == 'preview') {
            _previewFile(file);
          } else if (value == 'remove') {
            _removeFile(printFile);
          } else if (value == 'printOptions') {
            _showPrintOptionsModal(printFile);
          }
        },
      ),
    );
  }

  void _showPrintOptionsModal(PrintFile printFile) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) {
          return Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: MediaQuery.of(context).viewInsets.bottom + 16,
              top: 16,
            ),
            child: Form(
              key: _printOptionsFormKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Print Options", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  _buildValidatedDropdown("Paper Type", printFile.paperType, [
                    'Standard White (80gsm)',
                    'Glossy (100gsm)',
                    'Recycled (90gsm)',
                  ], (val) {
                    setModalState(() => printFile.paperType = val);
                    setState(() {});
                  }),
                  _buildValidatedDropdown("Size", printFile.size, [
                    'A4 (210 × 297mm)',
                    'Letter (8.5 × 11 in)',
                    'A5 (148 × 210mm)',
                  ], (val) {
                    setModalState(() => printFile.size = val);
                    setState(() {});
                  }),
                  _buildValidatedDropdown("Color", printFile.color, [
                    'Full Color',
                    'Black & White',
                  ], (val) {
                    setModalState(() => printFile.color = val);
                    setState(() {});
                  }),
                  _buildValidatedDropdown("Finish", printFile.finish, [
                    'Standard',
                    'Glossy',
                    'Matte',
                  ], (val) {
                    setModalState(() => printFile.finish = val);
                    setState(() {});
                  }),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Quantity"),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              if (printFile.quantity > 1) {
                                setModalState(() => printFile.quantity--);
                                setState(() {});
                              }
                            },
                            icon: const Icon(Icons.remove),
                          ),
                          Text(printFile.quantity.toString(), style: const TextStyle(fontSize: 16)),
                          IconButton(
                            onPressed: () {
                              setModalState(() => printFile.quantity++);
                              setState(() {});
                            },
                            icon: const Icon(Icons.add),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  GradientButton(
                    text: "Submit",
                    onPressed: () {
                      if (_printOptionsFormKey.currentState!.validate()) {
                        Navigator.pop(context);
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildValidatedDropdown(
    String label,
    String? currentValue,
    List<String> items,
    Function(String) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: currentValue,
          isExpanded: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            contentPadding: const EdgeInsets.all(12),
          ),
          items: items.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
          onChanged: (val) => onChanged(val!),
          validator: (val) => val == null || val.isEmpty ? 'Please select $label' : null,
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  double _calculateTotalPrice() {
    double total = 0;
    for (var file in uploadedFiles) {
      total += (basePrice + optionsPrice) * file.quantity;
    }
    return total;
  }

  Widget _buildPriceSummaryCard(double total) {
    return Card(
      elevation: 6,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Price Summary",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            _buildPriceRow("Base Price", basePrice),
            _buildPriceRow("Options", optionsPrice),
            _buildPriceRow("Total Quantity", uploadedFiles.fold<int>(0, (sum, f) => sum + f.quantity).toDouble()),
            const Divider(),
            _buildPriceRow("Total", total, isBold: true),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceRow(String label, double amount, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: isBold ? const TextStyle(fontWeight: FontWeight.bold) : null),
          Text("\$${amount.toStringAsFixed(2)}",
              style: isBold ? const TextStyle(fontWeight: FontWeight.bold) : null),
        ],
      ),
    );
  }
}
