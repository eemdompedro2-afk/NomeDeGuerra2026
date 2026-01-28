// Lista de estudantes de exemplo
// Depois você pode trocar ou aumentar essa lista
const estudantes = [
    {
        nome: "João da Silva",
        serie: "6º Ano",
        escola: "E.E. Exemplo 1",
        turno: "Matutino"
    },
    {
        nome: "Maria Souza",
        serie: "7º Ano",
        escola: "E.E. Exemplo 2",
        turno: "Vespertino"
    },
    {
        nome: "Pedro Santos",
        serie: "9º Ano",
        escola: "E.E. Modelo",
        turno: "Noturno"
    }
];

function buscarEstudante() {
    const termo = document.getElementById('searchInput').value.toLowerCase();
    const resultadosDiv = document.getElementById('resultados');

    // Se o campo estiver vazio:
    if (!termo) {
        resultadosDiv.innerHTML = '<p style="color: red;">Digite um nome para buscar.</p>';
        return;
    }

    // Filtrar estudantes pelo nome
    const encontrados = estudantes.filter(est => 
        est.nome.toLowerCase().includes(termo)
    );

    // Se não achou ninguém:
    if (encontrados.length === 0) {
        resultadosDiv.innerHTML = '<p>Nenhum estudante encontrado.</p>';
        return;
    }

    // Montar o HTML de resultado:
    let html = '';
    encontrados.forEach(est => {
        html += `
            <div class="card-estudante">
                <h3>${est.nome}</h3>
                <p><strong>Série:</strong> ${est.serie}</p>
                <p><strong>Escola:</strong> ${est.escola}</p>
                <p><strong>Turno:</strong> ${est.turno}</p>
            </div>
        `;
    });

    resultadosDiv.innerHTML = html;
}

// Permitir buscar apertando a tecla Enter
document.addEventListener('DOMContentLoaded', () => {
    const input = document.getElementById('searchInput');
    if (input) {
        input.addEventListener('keypress', (e) => {
            if (e.key === 'Enter') {
                buscarEstudante();
            }
        });
    }
});
