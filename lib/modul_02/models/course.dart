class Course {
  final String code;
  final String name;
  final String lecturer;
  final int sks;

  final String time;
  final String room;
  final String status;
  final String description;
  final String category;

  const Course({
    required this.code,
    required this.name,
    required this.lecturer,
    required this.sks,
    this.time = '',
    this.room = '',
    this.status = '',
    this.description = '',
    this.category = 'Teori',
  });

  static List<Course> getSampleCourses() {
    return const [
      Course(
        code: 'TRPL501',
        name: 'Mobile Programming',
        lecturer: 'Dosen Mobile Programming',
        sks: 3,
        time: '08.00 – 10.00',
        room: 'Lab 1',
        status: 'Berlangsung',
        description: 'Sedang digunakan oleh praktikan',
        category: 'Praktikum',
      ),
      Course(
        code: 'TRPL502',
        name: 'Rekayasa Perangkat Lunak',
        lecturer: 'Dosen Rekayasa Perangkat Lunak',
        sks: 3,
        time: '10.00 – 12.00',
        room: 'Lab 2',
        status: 'Akan datang',
        description: 'Sesi akan dimulai sebentar lagi',
        category: 'Teori',
      ),
      Course(
        code: 'TRPL503',
        name: 'Basis Data',
        lecturer: 'Dosen Basis Data',
        sks: 3,
        time: '13.00 – 15.00',
        room: 'Lab 3',
        status: 'Selesai',
        description: 'Sesi telah selesai',
        category: 'Teori',
      ),
      Course(
        code: 'LAB002',
        name: 'Lab 2',
        lecturer: 'Laboratorium TRPL',
        sks: 2,
        time: 'Di luar jadwal sesi',
        room: 'Lab 2',
        status: 'Tersedia',
        description: 'Siap digunakan untuk praktikum lain',
        category: 'Praktikum',
      ),
      Course(
        code: 'TRPL504',
        name: 'Pemrograman Web',
        lecturer: 'Dosen Pemrograman Web',
        sks: 3,
        time: '15.00 – 17.00',
        room: 'Lab 4',
        status: 'Akan datang',
        description: 'Sesi akan dimulai sebentar lagi',
        category: 'Praktikum',
      ),
    ];
  }
}