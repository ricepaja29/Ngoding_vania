import 'package:vania/vania.dart';

class CreateProductsTable extends Migration {
  @override
  Future<void> up() async {
    super.up();
    await createTableNotExists('products', (t) {
      // Primary key
      t.bigIncrements('prod_id'); // Auto-increment dan primary key

      // Foreign key to vendors table
      t.bigInt('vend_id', unsigned: true)
          .references('vend_id') // Merujuk kolom vend_id di tabel vendors
          .on('vendors')
          .onDelete('cascade'); // Hapus produk jika vendor dihapus

      // Other columns
      t.string('prod_name', length: 25).notNull(); // Nama produk
      t.integer('prod_price').notNull(); // Harga produk
      t.text('prod_desc').nullable(); // Deskripsi produk
      t.timeStamps(); // Kolom created_at dan updated_at
    });
  }

  @override
  Future<void> down() async {
    super.down();
    await dropIfExists('products');
  }
}
