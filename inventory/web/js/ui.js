/* ╔═══════════════════════════════════════════════════════════════╗
   ║     INTERFAZ DE USUARIO - INVENTARIO PREMIUM                  ║
   ╚═══════════════════════════════════════════════════════════════╝ */

// Inicializar UI cuando se carga la página
document.addEventListener('DOMContentLoaded', () => {
    debugLog('Inicializando interfaz de usuario...');
    setupEventListeners();
    applyTheme();
});

// Configurar event listeners
function setupEventListeners() {
    const closeBtn = document.querySelector('.close-btn');
    if (closeBtn) {
        closeBtn.addEventListener('click', closeInventory);
    }
    
    const searchInput = document.getElementById('search-input');
    if (searchInput) {
        searchInput.addEventListener('input', filterItems);
    }
}

// Aplicar tema
function applyTheme() {
    const root = document.documentElement;
    
    // Variables CSS personalizables
    root.style.setProperty('--primary-color', '#2980b9');
    root.style.setProperty('--secondary-color', '#34495e');
    root.style.setProperty('--success-color', '#27ae60');
    root.style.setProperty('--danger-color', '#e74c3c');
    root.style.setProperty('--warning-color', '#f39c12');
    root.style.setProperty('--info-color', '#3498db');
}

// Función para cambiar tema
function setTheme(theme) {
    const root = document.documentElement;
    
    const themes = {
        dark: {
            '--primary-color': '#2980b9',
            '--secondary-color': '#34495e',
            '--bg-color': '#1a1a2e'
        },
        light: {
            '--primary-color': '#3498db',
            '--secondary-color': '#95a5a6',
            '--bg-color': '#ecf0f1'
        }
    };
    
    const selectedTheme = themes[theme] || themes.dark;
    for (let [key, value] of Object.entries(selectedTheme)) {
        root.style.setProperty(key, value);
    }
}

// Actualizar información en tiempo real
function updateRealtimeInfo() {
    setInterval(() => {
        const items = inventoryData;
        if (items && InventoryState.isOpen) {
            updateInventoryInfo(items);
        }
    }, 500);
}

// Agregar animación a elemento
function addAnimation(element, animation) {
    element.classList.add(animation);
    setTimeout(() => {
        element.classList.remove(animation);
    }, 600);
}

// Pulso visual
function pulse(element) {
    addAnimation(element, 'pulse');
}

// Bounce visual
function bounce(element) {
    addAnimation(element, 'bounce');
}

// Glow visual
function glow(element) {
    element.classList.add('glow');
    setTimeout(() => {
        element.classList.remove('glow');
    }, 2000);
}

// Shake visual (error)
function shake(element) {
    addAnimation(element, 'shake');
}

// Fade out
function fadeOut(element) {
    element.classList.add('fadeOut');
    setTimeout(() => {
        element.remove();
    }, 300);
}

// Iniciar actualización en tiempo real
updateRealtimeInfo();

debugLog('UI.js cargado');