class Kapal {
    constructor(nama, jenis, panjang, lebar) {
      this.nama = nama;
      this.jenis = jenis;
      this.panjang = panjang;
      this.lebar = lebar;
    }
  
    infoKapal() {
      return `kapal ${this.nama} merupakan jenis ${this.jenis} yang berukuran ${this.panjang} M x ${this.lebar}m.`;
    }
  
    berlayar() {
      return `Kapal ${this.nama} sedang berlayar...`;
    }
  
    docking() {
      return `Kapal ${this.nama} sedang docking...`;
    }
  }
  
  class Kapalehey extends Kapal {
    constructor(nama, jenis, panjang, lebar, kapasitas) {
      super(nama, jenis, panjang, lebar);
      this.kapasitaspenumpang = kapasitas;
    }
  
    infoKapal() {
      return `${super.infoKapal()} kapal ini memiliki kapasitas ${this.kapasitaspenumpang} orang`;
    }
  }
  
  class KapalTanker extends Kapal {
    constructor(nama, jenis, panjang, lebar, kapasitasTanker) {
      super(nama, jenis, panjang, lebar);
      this.kapasitasTanker = kapasitasTanker;
    }
  
    infoKapal() {
      return `${super.infoKapal()} kapal ini memiliki kapasitas tanker ${this.kapasitasTanker} liter`;
    }
  }
  
  class KapalPesiarMewah extends Kapal {
    constructor(nama, jenis, panjang, lebar, jumlahKabin) {
      super(nama, jenis, panjang, lebar);
      this.jumlahKabin = jumlahKabin;
    }
  
    infoKapal() {
      return `${super.infoKapal()} kapal ini memiliki ${this.jumlahKabin} kabin mewah`;
    }
  }
  
  // **Kelas Baru: Pelabuhan**
  class Pelabuhan {
    constructor(nama, lokasi) {
      this.nama = nama;
      this.lokasi = lokasi;
    }
  
    infoPelabuhan() {
      return `Pelabuhan ${this.nama} terletak di ${this.lokasi}`;
    }
  
    // **Implementasi Polymorphism: menerimaKapal()**
    menerimaKapal(kapal) {
      return `Pelabuhan ${this.nama} menerima kapal ${kapal.nama}`;
    }
  }
  
  // **Kelas Baru: Perusahaan Pelayaran**
  class PerusahaanPelayaran {
    constructor(nama, alamat) {
      this.nama = nama;
      this.alamat = alamat;
    }
  
    infoPerusahaan() {
      return `Perusahaan ${this.nama} berlokasi di ${this.alamat}`;
    }
  
    // **Implementasi Polymorphism: mengoperasikanKapal()**
    mengoperasikanKapal(kapal) {
      return `Perusahaan ${this.nama} mengoperasikan kapal ${kapal.nama}`;
    }
  }
  
  // **Kelas Baru: Asuransi Kapal**
  class AsuransiKapal {
    constructor(nama, alamat) {
      this.nama = nama;
      this.alamat = alamat;
    }
  
    infoAsuransi() {
      return `Asuransi ${this.nama} berlokasi di ${this.alamat}`;
    }
  
    // **Implementasi Polymorphism: mengasuransikanKapal()**
    mengasuransikanKapal(kapal) {
      return `Asuransi ${this.nama} mengasuransikan kapal ${kapal.nama}`;
    }
  }
  
  // **Kelas Baru: Galangan Kapal**
  class GalanganKapal {
    constructor(nama, lokasi) {
      this.nama = nama;
      this.lokasi = lokasi;
    }
  
    infoGalangan() {
      return `Galangan ${this.nama} terletak di ${this.lokasi}`;
    }
  
    // **Implementasi Polymorphism: memperbaikiKapal()**
    memperbaikiKapal(kapal) {
      return `Galangan ${this.nama} memperbaiki kapal ${kapal.nama}`;
    }
  }
  
  const kapalferry = new Kapalehey("budiyono", "ferry", 200, 100, 600);
  const kapalpenumpang = new Kapal("budiyono siregar", "ferry", 200, 100);
  const kapalpesiar = new Kapal("titanic", "kapal pesiar", 300, 150);
  const kapaltanker = new KapalTanker("tanker1", "tanker", 250, 120, 100000);
  const kapalpesiarmewah = new KapalPesiarMewah("queen mary", "kapal pesiar mewah", 350, 180, 50);
  const pelabuhan = new Pelabuhan("Pelabuhan Tanjung Priok", "Jakarta");
  const perusahaanPelayaran = new PerusahaanPelayaran("PT. Pelayaran Indonesia", "Jakarta");
  const asuransiKapal = new AsuransiKapal("Asuransi Kapal Indonesia", "Jakarta");
  const galanganKapal = new GalanganKapal("Galangan Kapal Jakarta", "Jakarta");
  
  console.log(kapalferry.infoKapal());
  console.log(kapalpesiar.infoKapal());
  console.log(kapaltanker.infoKapal());
  console.log(kapalpesiarmewah.infoKapal());
  
  console.log(pelabuhan.infoPelabuhan());
  console.log(perusahaanPelayaran.infoPerusahaan());
  console.log(asuransiKapal.infoAsuransi());
  console.log(galanganKapal.infoGalangan());
  
  console.log(pelabuhan.infoPelabuhan());
  console.log(perusahaanPelayaran.infoPerusahaan());
  console.log(asuransiKapal.infoAsuransi());
  console.log(galanganKapal.infoGalangan());
  
  console.log(kapalferry.berlayar());
  console.log(kapalpesiarmewah.berlayar());
  console.log(kapalferry.berlayar());
  console.log(kapalpesiarmewah.berlayar());
  
  console.log(kapalferry.docking());
  console.log(kapalpesiar.docking());
  console.log(kapaltanker.docking());
  console.log(kapalpesiarmewah.docking());
  
  console.log(pelabuhan.infoPelabuhan());
  console.log(pelabuhan.menerimaKapal(kapalferry));