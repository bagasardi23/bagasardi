class SensorLaut {
    constructor(nama, lokasi) {
        this.nama = nama;
        this.lokasi = lokasi;
        this._status = "mati";
        this.dataTerkirim = false; 
    }

    aktifkan() {
        this._status = "aktif";
        console.log(`Sensor ${this.nama} di lokasi ${this.lokasi} telah diaktifkan.`);
        this.kirimData(); 
    }

    nonaktifkan() {
        this._status = "mati";
        this.dataTerkirim = false; 
        console.log(`Sensor ${this.nama} di lokasi ${this.lokasi} telah dinonaktifkan.`);
    }

    getStatus() {
        return `Sensor ${this.nama} di lokasi ${this.lokasi} sedang dalam kondisi ${this._status}`;
    }

    kirimData() {
        if (this._status === "aktif") {
            const dataSuhu = this.ambilDataSuhu();
            console.log(`Mengirim data dari sensor ${this.nama}: Suhu air laut saat ini di ${this.lokasi} adalah ${dataSuhu}C`);
            this.dataTerkirim = true;
        } else {
            console.log(`Sensor ${this.nama} tidak aktif. Data tidak dapat dikirim.`);
        }
    }

    ambilDataSuhu() {
        return (Math.random() * 10 + 20).toFixed(2);
    }
}

const sensorLaut = new SensorLaut("Sensor Laut", "Samudera Hindia");
sensorLaut.aktifkan();
console.log(sensorLaut.getStatus());
sensorLaut.nonaktifkan();