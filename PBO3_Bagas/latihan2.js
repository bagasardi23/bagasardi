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
  
    // MethodBaru: berlayar()
    berlayar() {
      return `Kapal ${this.nama} sedang berlayar...`;
    }
  
    // MethodBaru: docking()
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
  
  // SubsclassBaru: KapalTanker
  class KapalTanker extends Kapal {
    constructor(nama, jenis, panjang, lebar, kapasitasTanker) {
      super(nama, jenis, panjang, lebar);
      this.kapasitasTanker = kapasitasTanker;
    }
  
    infoKapal() {
      return `${super.infoKapal()} kapal ini memiliki kapasitas tanker ${this.kapasitasTanker} liter`;
    }
  }
  
  // SubclassBaru: KapalPesiarMewah
  class KapalPesiarMewah extends Kapal {
    constructor(nama, jenis, panjang, lebar, jumlahKabin) {
      super(nama, jenis, panjang, lebar);
      this.jumlahKabin = jumlahKabin;
    }
  
    infoKapal() {
      return `${super.infoKapal()} kapal ini memiliki ${this.jumlahKabin} kabin mewah`;
    }
  }
  
  const kapalferry = new Kapalehey("budiyono", "ferry", 200, 100, 600);
  const kapalpenumpang = new Kapal("budiyono siregar", "ferry", 200, 100);
  const kapalpesiar = new Kapal("titanic", "kapal pesiar", 300, 150);
  const kapaltanker = new KapalTanker("tanker1", "tanker", 250, 120, 100000);
  const kapalpesiarmewah = new KapalPesiarMewah("queen mary", "kapal pesiar mewah", 350, 180, 50);
  
  console.log(kapalferry.infoKapal());
  console.log(kapalpesiar.infoKapal());
  console.log(kapaltanker.infoKapal());
  console.log(kapalpesiarmewah.infoKapal());
  
  console.log(kapalferry.berlayar());
  console.log(kapalpesiarmewah.berlayar());
  console.log(kapalferry.docking());
  console.log(kapalpesiarmewah.docking());

  console.log(kapalferry.docking());
  console.log(kapalpesiar.docking());
  console.log(kapaltanker.docking());
  console.log(kapalpesiarmewah.docking());