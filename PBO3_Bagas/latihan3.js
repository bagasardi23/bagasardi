class sensor{
    constructor(nama, lokasi){
        this.nama = nama,
        this.lokasi = lokasi,
        this_status = "Mati"
    }

    aktifkan(){
        this_status = "Aktif"
        return `sensor ${this.nama} di lokasi ${this.lokasi} telah di aktifkan`
    }

    nonaktifkan(){
        this_status = "Mati"
        return `sensor ${this.nama} di lokasi ${this.lokasi} telah di nonaktifkan`
    }

    getstatus(){
        return `sensor ${this.nama} di lokasi ${this.lokasi} sedang dalam kondisi ${this_status}`
    }
}

const sensorPasut = new sensor("Pasut Merak", "Merak");

console.log(sensorPasut.aktifkan());
console.log(sensorPasut.getstatus());