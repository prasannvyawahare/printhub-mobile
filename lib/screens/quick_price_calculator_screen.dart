import 'package:flutter/material.dart';
import '../common_widget/print_hub_gradient_button.dart';
import '../common_widget/print_hub_app_bar.dart';

class QuickPriceCalculatorScreen extends StatefulWidget {
  const QuickPriceCalculatorScreen({super.key});

  @override
  State<QuickPriceCalculatorScreen> createState() => _QuickPriceCalculatorScreenState();
}

class _QuickPriceCalculatorScreenState extends State<QuickPriceCalculatorScreen> {
  final ScrollController _scrollController = ScrollController();

  String selectedDocumentType = 'PDF';
  String selectedPaperSize = 'A4';
  String selectedColorOption = 'Black & White';
  String selectedPrintSide = 'Single Side';
  int numberOfPages = 1;
  int numberOfCopies = 1;

  double basePrice = 0.0;
  double priceOfOneCopy = 0.0;
  double estimatedTotal = 0.0;
  bool isPriceCalculated = false;

  final documentTypes = ['PDF', 'DOCX', 'Images'];
  final paperSizes = ['A4', 'A3', 'Letter'];
  final colorOptions = ['Black & White', 'Color'];
  final printSides = ['Single Side', 'Double Side'];

  Map<String, Map<String, Map<String, double>>> priceStructure = {
    'Black & White': {
      'A4': {'PDF': 0.10, 'DOCX': 0.12, 'Images': 0.15},
      'A3': {'PDF': 0.20, 'DOCX': 0.22, 'Images': 0.25},
      'Letter': {'PDF': 0.15, 'DOCX': 0.18, 'Images': 0.20},
    },
    'Color': {
      'A4': {'PDF': 0.25, 'DOCX': 0.30, 'Images': 0.35},
      'A3': {'PDF': 0.50, 'DOCX': 0.55, 'Images': 0.60},
      'Letter': {'PDF': 0.40, 'DOCX': 0.45, 'Images': 0.50},
    },
  };

  void calculatePrice() {
    double documentPrice = priceStructure[selectedColorOption]?[selectedPaperSize]?[selectedDocumentType] ?? 0.10;
    double adjustedPages = selectedPrintSide == 'Double Side' ? (numberOfPages / 2).ceilToDouble() : numberOfPages.toDouble();

    basePrice = documentPrice * adjustedPages;
    priceOfOneCopy = basePrice;
    estimatedTotal = priceOfOneCopy * numberOfCopies;

    setState(() {
      isPriceCalculated = true;
    });

    // Scroll to bottom after small delay
    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FBFB),
      appBar: const PrintHubAppBar(),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Card(
                  color: Colors.white,
                  elevation: 6,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            "Quick Price Calculator",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'poppins',
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        buildDropdown("Document Type", documentTypes, selectedDocumentType, (value) {
                          selectedDocumentType = value!;
                        }),
                        buildDropdown("Paper Size", paperSizes, selectedPaperSize, (value) {
                          selectedPaperSize = value!;
                        }),
                        buildDropdown("Color Option", colorOptions, selectedColorOption, (value) {
                          selectedColorOption = value!;
                        }),
                        buildDropdown("Print Side", printSides, selectedPrintSide, (value) {
                          selectedPrintSide = value!;
                        }),
                        const SizedBox(height: 10),
                        buildNumberInput("Number of Pages", numberOfPages, (value) {
                          numberOfPages = int.tryParse(value) ?? 1;
                          if (numberOfPages <= 0) numberOfPages = 1;
                        }),
                        buildNumberInput("Number of Copies", numberOfCopies, (value) {
                          numberOfCopies = int.tryParse(value) ?? 1;
                          if (numberOfCopies <= 0) numberOfCopies = 1;
                        }),
                        const SizedBox(height: 20),
                        Center(
                          child: GradientButton(
                            text: "Get Quick Price",
                            onPressed: () {
                              calculatePrice();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (isPriceCalculated) buildReceiptStyleSummary(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDropdown(String label, List<String> items, String selectedValue, Function(String?) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          dropdownColor: Colors.white,
          borderRadius: BorderRadius.circular(10),
          elevation: 4,
          value: selectedValue,
          items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: (value) => setState(() => onChanged(value)),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget buildNumberInput(String label, int value, Function(String) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextField(
          keyboardType: TextInputType.number,
          onChanged: (value) => setState(() => onChanged(value)),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            hintText: 'Enter $label',
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget buildReceiptStyleSummary() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      width: double.infinity,
      child: Card(
        color: Colors.white,
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Price Summary",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'poppins',
                  ),
                ),
              ),
              const SizedBox(height: 20),
              buildReceiptRow("Price of 1 Copy", "Rs. ${priceOfOneCopy.toStringAsFixed(2)}"),
              buildReceiptRow("No. of Copies", "$numberOfCopies"),
              const Divider(thickness: 1.5),
              buildReceiptRow(
                "Estimated Total",
                "Rs. ${estimatedTotal.toStringAsFixed(2)}",
                isBold: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildReceiptRow(String title, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
