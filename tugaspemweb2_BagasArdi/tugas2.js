document.addEventListener("DOMContentLoaded", function() {
    // Ambil elemen input dan display area
    const namaInput = document.getElementById('nama');
    const nimInput = document.getElementById('nim');
    const kelasInput = document.getElementById('kelas');
    const prodiInput = document.getElementById('prodi');
    const registrationForm = document.getElementById('registrationForm');
    const dataTable = document.getElementById('dataTable');

    // Event 1: Submit form and append data to table
    registrationForm.addEventListener('submit', function(event) {
        event.preventDefault(); // Prevent default form submission

        const namaValue = namaInput.value;
        const nimValue = nimInput.value;
        const kelasValue = kelasInput.value;
        const prodiValue = prodiInput.value;

        const newRow = document.createElement('tr');
        newRow.innerHTML = `
            <td>${namaValue}</td>
            <td>${nimValue}</td>
            <td>${kelasValue}</td>
            <td>${prodiValue}</td>
        `;
        dataTable.appendChild(newRow);

        // Reset input fields
        namaInput.value = '';
        nimInput.value = '';
        kelasInput.value = '';
        prodiInput.value = '';
    });
});