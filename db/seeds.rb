# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Lembaga.destroy_all
Anggaran.destroy_all
Pajak.destroy_all
User.destroy_all
Opd.destroy_all

lembaga = Lembaga.create(nama_lembaga: 'Kota Madiun', tahun: '2022')
Pajak.create(tahun: '2022', tipe: 'Tanpa Pajak', potongan: 0)
Pajak.create(tahun: '2022', tipe: 'PPN', potongan: 0.1)
opd = Opd.create(nama_opd: 'Super Admin', kode_opd: '123456890', lembaga_id: lembaga.id)
Opd.create(nama_opd: 'Badan Perencanaan, Penelitian dan Pengembangan Daerah',
           kode_opd: '1275',
           id_opd_skp: 481,
           kode_unik_opd: '5.01.5.05.0.00.02.0000',
           id_daerah: '109',
           lembaga_id: lembaga.id)
user = User.create(nama: 'Super Admin', nik: 'super_admin', kode_opd: opd.kode_opd, email: 'admin@test.com',
                   password: '123456')
%w[admin asn reviewer non_aktif super_admin].each do |role_name|
  Role.create! name: role_name
end
user.add_role :super_admin
user.add_role :asn
user.add_role :admin
user.add_role :reviewer
user.remove_role :non_aktif
# Sample seed for anggaran
# Root category
# root = Category.create name: 'sport'
# # Sport subcategories
# basketball_cat = root.children.create name: 'basketball'
# fitness_cat = root.children.create name: 'fitness'
# # Basketball categories
# basketball_cat.children.create name: 'clothing'
# basketball_cat.children.create name: 'basketballs'
# basketball_cat.children.create name: 'footwear'
# # Fitness subcategories
# fitness_cat.children.create name: 'dumbbells'
# fitness_cat.children.create name: 'benches'
# fitness_cat.children.create name: 'kettlebells'
