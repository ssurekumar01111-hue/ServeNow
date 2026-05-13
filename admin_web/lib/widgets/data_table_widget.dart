import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:admin_web/app/utils/app_colors.dart';

class DataTableWidget extends StatelessWidget {
  final List<DataColumn> columns;
  final List<DataRow> rows;
  final bool isLoading;
  final String emptyMessage;
  final Widget? header;
  final VoidCallback? onExport;

  const DataTableWidget({
    super.key,
    required this.columns,
    required this.rows,
    this.isLoading = false,
    this.emptyMessage = 'No data found',
    this.header,
    this.onExport,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (header != null)
            Padding(
              padding: const EdgeInsets.all(24),
              child: header!,
            ),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : rows.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.inbox_outlined, size: 48, color: AppColors.textHint),
                            const SizedBox(height: 16),
                            Text(emptyMessage, style: const TextStyle(color: AppColors.textSecondary)),
                          ],
                        ),
                      )
                    : DataTable2(
                        columnSpacing: 12,
                        horizontalMargin: 24,
                        minWidth: 600,
                        headingRowColor: MaterialStateProperty.all(AppColors.background),
                        columns: columns,
                        rows: rows,
                      ),
          ),
        ],
      ),
    );
  }
}
