import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';

class PDFClass
{
  Future<void> quarterly()
  async {
    final pdf = pw.Document();

    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text("Hello World"),
          );
        }
        )
    );
    var dir = await getExternalStorageDirectory();
    if(!Directory("${dir?.path}").existsSync()){
      Directory("${dir?.path}").createSync(recursive: true);
    }

    String dir1 = dir.toString();
    dir1 = dir1.split(' ')[1];
    dir1 = dir1.split('\'')[1];

    final file = File("$dir/example.pdf");
    await file.writeAsBytes(await pdf.save());
    PDFDocument doc = await PDFDocument.fromFile(file);
  }
}