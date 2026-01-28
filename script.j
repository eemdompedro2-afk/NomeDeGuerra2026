// Base de dados de estudantes (em produção, viria de um servidor)
const estudantes = [
    { nome: "Ana Carolina Silva", serie: "6º Ano A", escola: "E.E. Militar", turno: "Matutino", matricula: "2026001" },
    { nome: "Bruno Henrique Santos", serie: "6º Ano B", escola: "E.E. Militar", turno: "Vespertino", matricula: "2026002" },
    { nome: "Carla Fernandes", serie: "7º Ano A", escola: "E.E. Central", turno: "Matutino", matricula: "2026003" },
    { nome: "Daniel Costa", serie: "7º Ano B", escola: "E.E. Central", turno: "Vespertino", matricula: "2026004" },
    { nome: "Eduarda Oliveira", serie: "6º Ano C", escola: "E.E. Progresso", turno: "Matutino", matricula: "2026005" },
    { nome: "Felipe Rodrigues", serie: "7º Ano C", escola: "E.E. Progresso", turno: "Integral", matricula: "2026006" },
    { nome: "Gabriela Martins", serie: "6º Ano A", escola: "E.E. Esperança", turno: "Matutino", matricula: "2026007" },
    { nome: "Henrique Alves", serie: "7º Ano A", escola: "E.E. Esperança", turno: "Vespertino", matricula: "2026008" },
    // Adicione mais estudantes aqui
];

const searchInput = document.getElementById('searchInput');
const searchBtn = document.getElementById('searchBtn');
const resultadosDiv = document.getElementById('resultados');
const loadingDiv = document.getElementById('loading');
const counterDiv = document.getElementById('searchCounter');

// Função de busca
function buscarEstudante() {
    const termo = searchInput.value.trim().toLowerCase();

    if (!termo) {
        mostrarMensagem('Digite um nome para buscar', 'warning');
        return;
    }

    // Mostrar loading
    loadingDiv.style.display = 'block';
    resultadosDiv.innerHTML = '';
    counterDiv.textContent = '';

    // Simular delay de busca (remover em produção)
    setTimeout(() => {
        const encontrados = estudantes.filter(est => 
            est.nome.toLowerCase().includes(termo) ||
            est.matricula.includes(termo)
        );

        loadingDiv.style.display = 'none';
        mostrarResultados(encontrados, termo);
    }, 500);
}

// Mostrar resultados
function mostrarResultados(estudantes, termo) {
    if (estudantes.length === 0) {
        resultadosDiv.innerHTML = `
            <div class="no-results">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor">
                    <circle cx="11" cy="11" r="8"></circle>
                    <path d="m21 21-4.35-4.35"></path>
                </svg>
                <h3>Nenhum estudante encontrado</h3>
                <p>Tente buscar por outro nome ou matrícula</p>
            </div>
        `;
        return;
    }

    counterDiv.textContent = `${estudantes.length} estudante${estudantes.length > 1 ? 's' : ''} encontrado${estudantes.length > 1 ? 's' : ''}`;

    let html = '';
    estudantes.forEach((est, index) => {
        html += `
            <div class="card-estudante" style="animation-delay: ${index * 0.1}s">
                <h3>${destacarTexto(est.nome, termo)}</h3>
                <p><strong>Matrícula:</strong> ${est.matricula}</p>
                <p><strong>Série:</strong> ${est.serie}</p>
                <p><strong>Escola:</strong> ${est.escola}</p>
                <p><strong>Turno:</strong> ${est.turno}</p>
            </div>
        `;
    });

    resultadosDiv.innerHTML = html;
}

// Destacar termo buscado
function destacarTexto(texto, termo) {
    const regex = new RegExp(`(${termo})`, 'gi');
    return texto.replace(regex, '<mark style="background: #fef08a; padding: 2px 4px; border-radius: 3px;">$1</mark>');
}

// Mensagem de aviso
function mostrarMensagem(msg, tipo) {
    resultadosDiv.innerHTML = `
        <div class="no-results">
            <p style="color: ${tipo === 'warning' ? '#f59e0b' : '#64748b'};">${msg}</p>
        </div>
    `;
}

// Event Listeners
searchBtn.addEventListener('click', buscarEstudante);

searchInput.addEventListener('keypress', (e) => {
    if (e.key === 'Enter') {
        buscarEstudante();
    }
});

// Busca em tempo real (opcional)
searchInput.addEventListener('input', () => {
    if (searchInput.value.length >= 3) {
        buscarEstudante();
    }
});
