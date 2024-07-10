import 'package:automatize_app/common_libs.dart';
import 'package:data_table_2/data_table_2.dart';

const _radius = Radius.circular(16);

class PaginatedTable extends StatefulWidget {
  final Widget? header;
  final List<Widget>? actions;

  const PaginatedTable({
    super.key,
    this.header,
    this.actions,
  });

  @override
  State<PaginatedTable> createState() => _PaginatedTableState();
}

class _PaginatedTableState extends State<PaginatedTable> {
  late final PaginatorController _controller = PaginatorController();
  int _rowsPerPage = 10;

  @override
  Widget build(BuildContext context) {
    return AsyncPaginatedDataTable2(
      controller: _controller,
      wrapInCard: false,
      header: widget.header,
      actions: widget.actions,
      horizontalMargin: 16,
      columnSpacing: 16,
      headingRowHeight: 56,
      rowsPerPage: _rowsPerPage,
      showFirstLastButtons: true,
      onRowsPerPageChanged: (value) => _rowsPerPage = value!,
      border: TableBorder(
        horizontalInside: BorderSide(
          width: 1,
          color: context.colorScheme.outline.withOpacity(.2),
        ),
        borderRadius:
            const BorderRadius.only(bottomRight: _radius, bottomLeft: _radius),
        top: BorderSide.none,
        bottom: BorderSide.none,
      ),
      headingRowDecoration: BoxDecoration(
        color: context.colorScheme.primary,
        borderRadius:
            const BorderRadius.only(topRight: _radius, topLeft: _radius),
      ),
      headingTextStyle: context.textTheme.titleMedium
          ?.copyWith(color: context.colorScheme.onPrimary),
      columns: const [
        DataColumn2(label: CircleAvatar(radius: 12), fixedWidth: 50),
        DataColumn2(label: Text('Cliente'), size: ColumnSize.M),
        DataColumn2(label: Text('Endereço'), size: ColumnSize.M),
        DataColumn2(label: Text('Itens'), size: ColumnSize.L),
        DataColumn2(label: Text('Total'), fixedWidth: 125),
      ],
      source: MyDataTableSource(_fetchData),
    );
  }

  Future<List<DataRow>> _fetchData(int pageIndex, int pageSize) async {
    List<DataRow> rows = List.generate(pageSize, (index) {
      final isRounded =
          index == pageSize - 1 ? _radius : const Radius.circular(0);
      return DataRow2(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: isRounded,
            bottomRight: isRounded,
          ),
        ),
        onTap: () {
          print('data row click');
        },
        cells: [
          DataCell(
            GestureDetector(
                onTap: () {
                  print('estou clicando no icone');
                },
                child: const CircleAvatar(radius: 12)),
          ),
          const DataCell(Text('asdasdadadad')),
          const DataCell(Text('asdasdadadadasd')),
          const DataCell(Text('asdasdadadaddhajshdj')),
          const DataCell(Text('RS 99.999.999,99')),
        ],
      );
    });

    return rows;
  }
}

class MyDataTableSource extends AsyncDataTableSource {
  final Future<List<DataRow>> Function(int pageIndex, int pageSize) fetchData;

  MyDataTableSource(this.fetchData);

  @override
  Future<AsyncRowsResponse> getRows(int startIndex, int count) async {
    List<DataRow> rows = await fetchData(startIndex, count);
    return AsyncRowsResponse(100, rows);
  }
}
