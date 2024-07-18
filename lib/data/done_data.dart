List<Map<String, dynamic>> doneData = [
  // {
  //   'id_orderan': 'ORD001',
  //   'queue': 001,
  //   'time': '14:00',
  //   'status': 'Order',
  //   'table': 'Table 1',
  //   'name': 'John Doe',
  //   'items': [
  //     {'quantity': 2, 'item': 'Lumpia', 'description': 'Vegetarian', 'type': 'Snack'},
  //     {'quantity': 1, 'item': 'Ayam Kung Pao', 'description': 'Pedas', 'type': 'Makanan'},
  //     {'quantity': 2, 'item': 'Teh Oolong', 'description': 'Panas', 'type': 'Minuman'},
  //     {'quantity': 3, 'item': 'Nasi Putih', 'description': '', 'type': 'Item'},

  //   ]
  // },
  // {
  //   'id_orderan': 'ORD002',
  //   'queue': 002,
  //   'time': '14:05',
  //   'status': 'Order',
  //   'table': 'Table 2',
  //   'name': 'Jane Smith',
  //   'items': [
  //     {'quantity': 1, 'item': 'Babi Asam Manis', 'description': 'Pedas Sedang', 'type': 'Makanan'},
  //     {'quantity': 3, 'item': 'Dim Sum', 'description': 'Beraneka Rasa', 'type': 'Snack'},
  //     {'quantity': 2, 'item': 'Teh Melati', 'description': 'Dingin', 'type': 'Minuman'},
  //     {'quantity': 3, 'item': 'Nasi Putih', 'description': '', 'type': 'Item'},

  //   ]
  // },
  // {
  //   'id_orderan': 'ORD003',
  //   'queue': 003,
  //   'time': '14:10',
  //   'status': 'Order',
  //   'table': 'Table 3',
  //   'name': 'Alice Johnson',
  //   'items': [
  //     {'quantity': 1, 'item': 'Mie Goreng Sapi', 'description': 'Dengan sayuran ekstra', 'type': 'Makanan'},
  //     {'quantity': 1, 'item': 'Lumpia', 'description': 'Ayam', 'type': 'Snack'},
  //     {'quantity': 1, 'item': 'Jus Leci', 'description': 'Dingin', 'type': 'Minuman'},
  //   ]
  // },
  // {
  //   'id_orderan': 'ORD004',
  //   'queue': 004,
  //   'time': '14:30',
  //   'status': 'Order',
  //   'table': 'Table 4',
  //   'name': 'Bob Lee',
  //   'items': [
  //     {'quantity': 2, 'item': 'Ayam Jenderal Tso', 'description': 'Pedas', 'type': 'Makanan'},
  //     {'quantity': 2, 'item': 'Pangsit Goreng', 'description': 'Dengan saus manis', 'type': 'Snack'},
  //     {'quantity': 1, 'item': 'Teh Hijau', 'description': 'Panas', 'type': 'Minuman'},
  //   ]
  // },
  // {
  //   'id_orderan': 'ORD005',
  //   'queue': 005,
  //   'time': '14:40',
  //   'status': 'Order',
  //   'table': 'Table 5',
  //   'name': 'Charlie Brown',
  //   'items': [
  //     {'quantity': 1, 'item': 'Bebek Peking', 'description': 'Dengan saus hoisin', 'type': 'Makanan'},
  //     {'quantity': 1, 'item': 'Pangsit Udang', 'description': 'Dikukus', 'type': 'Snack'},
  //     {'quantity': 2, 'item': 'Anggur Plum', 'description': 'Dingin', 'type': 'Minuman'},
  //   ]
  // },
  // {
  //   'id_orderan': 'ORD006',
  //   'queue': 006,
  //   'time': '15:10',
  //   'status': 'Order',
  //   'table': 'Table 6',
  //   'name': 'Diana Prince',
  //   'items': [
  //     {'quantity': 2, 'item': 'Mapo Tofu', 'description': 'Pedas', 'type': 'Makanan'},
  //     {'quantity': 1, 'item': 'Bakpao', 'description': 'Babi', 'type': 'Snack'},
  //     {'quantity': 1, 'item': 'Teh Krisan', 'description': 'Panas', 'type': 'Minuman'},
  //   ]
  // },
  // {
  //   'id_orderan': 'ORD007',
  //   'queue': 007,
  //   'time': '15:20',
  //   'status': 'Order',
  //   'table': 'Table 7',
  //   'name': 'Eddie Murphy',
  //   'items': [
  //     {'quantity': 3, 'item': 'Daging Sapi Szechuan', 'description': 'Sangat Pedas', 'type': 'Makanan'},
  //     {'quantity': 2, 'item': 'Rangoon Kepiting', 'description': 'Dengan keju', 'type': 'Snack'},
  //     {'quantity': 2, 'item': 'Teh Bubble', 'description': 'Rasa Taro', 'type': 'Minuman'},
  //   ]
  // },
  // {
  //   'id_orderan': 'ORD008',
  //   'queue': 008,
  //   'time': '15:40',
  //   'status': 'Order',
  //   'table': 'Table 8',
  //   'name': 'Frank White',
  //   'items': [
  //     {'quantity': 1, 'item': 'Ayam Wijen', 'description': 'Dengan biji wijen', 'type': 'Makanan'},
  //     {'quantity': 1, 'item': 'Lumpia', 'description': 'Udang', 'type': 'Snack'},
  //     {'quantity': 1, 'item': 'Smoothie Mangga', 'description': 'Dingin', 'type': 'Minuman'},
  //   ]
  // },
  // {
  //   'id_orderan': 'ORD009',
  //   'queue': 009,
  //   'time': '15:40',
  //   'status': 'Order',
  //   'table': 'Table 9',
  //   'name': 'George Martin',
  //   'items': [
  //     {'quantity': 2, 'item': 'Sup Pedas Asam', 'description': 'Pedas Sedang', 'type': 'Makanan'},
  //     {'quantity': 2, 'item': 'Bola Udang Goreng', 'description': 'Dengan saus celup', 'type': 'Snack'},
  //     {'quantity': 1, 'item': 'Air Kelapa', 'description': 'Dingin', 'type': 'Minuman'},
  //   ]
  // },
  // {
  //   'id_orderan': 'ORD010',
  //   'queue': 010,
  //   'time': '16:00',
  //   'status': 'Order',
  //   'table': 'Table 10',
  //   'name': 'Hannah Green',
  //   'items': [
  //     {'quantity': 1, 'item': 'Ayam Jeruk', 'description': 'Manis dan asam', 'type': 'Makanan'},
  //     {'quantity': 1, 'item': 'Pangsit Babi', 'description': 'Dikukus', 'type': 'Snack'},
  //     {'quantity': 2, 'item': 'Teh Lemon', 'description': 'Es', 'type': 'Minuman'},
  //   ]
  // },
  // {
  //   'id_orderan': 'ORD011',
  //   'queue': 011,
  //   'time': '16:30',
  //   'status': 'Order',
  //   'table': 'Table 11',
  //   'name': 'Ivan Tan',
  //   'items': [
  //     {'quantity': 1, 'item': 'Nasi Goreng Yangzhou', 'description': 'Dengan telur dan udang', 'type': 'Makanan'},
  //     {'quantity': 2, 'item': 'Teh Hijau', 'description': 'Dingin', 'type': 'Minuman'},
  //     {'quantity': 1, 'item': 'Sup Wonton', 'description': 'Dengan sayuran', 'type': 'Makanan'},
  //     {'quantity': 1, 'item': 'Jus Jeruk', 'description': 'Segar', 'type': 'Minuman'},
  //   ]
  // },
  // {
  //   'id_orderan': 'ORD012',
  //   'queue': 012,
  //   'time': '19:00',
  //   'status': 'Order',
  //   'table': 'Table 12',
  //   'name': 'Lucy Liu',
  //   'items': [
  //     {'quantity': 1, 'item': 'Sapi Lada Hitam', 'description': 'Pedas', 'type': 'Makanan'},
  //     {'quantity': 2, 'item': 'Udang Goreng Tepung', 'description': 'Renyah', 'type': 'Snack'},
  //     {'quantity': 2, 'item': 'Teh Melati', 'description': 'Dingin', 'type': 'Minuman'},
  //     {'quantity': 1, 'item': 'Roti Canai', 'description': 'Dengan kari', 'type': 'Snack'},
  //     {'quantity': 1, 'item': 'Dimsum', 'description': 'Beraneka rasa', 'type': 'Snack'},
  //     {'quantity': 1, 'item': 'Jus Semangka', 'description': 'Segar', 'type': 'Minuman'},
  //   ]
  // },
];
