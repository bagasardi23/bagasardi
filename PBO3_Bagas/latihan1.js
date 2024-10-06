const orang = {
    nama: 'fadli',
    alamat : 'sukabumi',
    usia : '19',
    jk : 'laki-laki',
    kendaraan : {
        mobil : 'pajero',
        motor : 'vixion',
        pesawat : 'boing',
    }
}

console.log(orang.nama)
console.log(orang.alamat)
console.log(orang.usia)
console.log(orang.jk)

console.log(`nama saya ${orang.nama}, saya berasal dari ${orang.alamat}, berumur ${orang.usia} dan berjenis kelamin ${orang.jk}`)

console.log(orang.kendaraan.mobil)
console.log(orang.kendaraan.motor)
console.log(orang.kendaraan.pesawat)

const mahasiswa = {
    namadepan : 'fadli',
    namabelakang : 'kurnia',
    namalengkap : function(){
        return this.namadepan + ' ' + this.namabelakang
    }
}
console.log(mahasiswa.namalengkap())

function mahasiswaSIK(nama, kelas, angkatan){
    this.nama = nama,
    this.kelas = kelas,
    this.angkatan = angkatan
}

const fadli = new mahasiswaSIK("fadli kurnia", "B", 2023)
const nabil = new mahasiswaSIK("nabil razqa", "A", 2023)

console.log(nabil.nama)
console.log(nabil.kelas)
console.log(nabil.angkatan)
