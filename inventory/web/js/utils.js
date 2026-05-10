/* ╔═══════════════════════════════════════════════════════════════╗
   ║     FUNCIONES UTILITARIAS - INVENTARIO PREMIUM                ║
   ╚═══════════════════════════════════════════════════════════════╝ */

// Comunicación con FiveM
function sendNui(event, data) {
    fetch(`https://${GetParentResourceName()}/` + event, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify(data || {})
    }).then(r => r.json()).catch((e) => {
        debugLog('Error enviando evento NUI:', e);
    });
}

// Recibir datos de FiveM
window.addEventListener('message', function(event) {
    const data = event.data;
    
    if (data.type === 'inventory:open') {
        openInventory(data.container);
    } else if (data.type === 'inventory:close') {
        closeInventory();
    } else if (data.type === 'inventory:updateItems') {
        updateInventoryDisplay(data.items);
    }
});

// Función para mostrar notificaciones
function showNotification(message, type = 'success', duration = 3000) {
    const container = document.getElementById('notifications-container');
    const notification = document.createElement('div');
    notification.className = `notification ${type}`;
    notification.innerHTML = `
        <span class="notification-icon">${getNotificationIcon(type)}</span>
        <span class="notification-text">${message}</span>
    `;
    
    container.appendChild(notification);
    
    setTimeout(() => {
        notification.classList.add('fadeOut');
        setTimeout(() => notification.remove(), 300);
    }, duration);
}

// Obtener icono de notificación
function getNotificationIcon(type) {
    const icons = {
        'success': '✓',
        'error': '✕',
        'warning': '⚠',
        'info': 'ⓘ'
    };
    return icons[type] || icons['info'];
}

// Convertir nombre a formato legible
function formatItemName(name) {
    return name
        .replace(/_/g, ' ')
        .split(' ')
        .map(word => word.charAt(0).toUpperCase() + word.slice(1))
        .join(' ');
}

// Obtener información del item
function getItemInfo(itemName) {
    const items = {
        'water': { label: 'Agua', weight: 0.5, type: 'consumible', icon: '💧' },
        'bread': { label: 'Pan', weight: 0.3, type: 'consumible', icon: '🍞' },
        'money': { label: 'Dinero', weight: 0.1, type: 'currency', icon: '💵' },
        'gold_bar': { label: 'Barra de Oro', weight: 1.0, type: 'valuable', icon: '🏆' },
        'phone': { label: 'Teléfono', weight: 0.2, type: 'electronic', icon: '📱' }
    };
    return items[itemName] || { label: formatItemName(itemName), weight: 0, type: 'generic', icon: '📦' };
}

// Calcular peso total
function calculateTotalWeight(inventory) {
    let totalWeight = 0;
    for (let item in inventory) {
        const itemInfo = getItemInfo(item);
        totalWeight += itemInfo.weight * (inventory[item] || 1);
    }
    return totalWeight.toFixed(2);
}

// Calcular slots usados
function calculateUsedSlots(inventory) {
    return Object.keys(inventory).length;
}

// Formatear número con separadores
function formatNumber(num) {
    return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
}

// Debug log
function debugLog(message, data = null) {
    const timestamp = new Date().toLocaleTimeString();
    console.log(`%c[${timestamp}] [ConcepInventory] %c${message}`, 'color: #2ecc71; font-weight: bold;', 'color: #ecf0f1;', data || '');
}

// Esperar promesa
function wait(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
}

// Validar si es número
function isNumber(value) {
    return !isNaN(parseFloat(value)) && isFinite(value);
}

// Copiar al portapapeles
function copyToClipboard(text) {
    navigator.clipboard.writeText(text).then(() => {
        showNotification('Copiado al portapapeles', 'success');
    }).catch(() => {
        showNotification('Error al copiar', 'error');
    });
}

// Obtener color por raridad
function getRarityColor(rarity) {
    const colors = {
        'common': '#95a5a6',
        'uncommon': '#2ecc71',
        'rare': '#3498db',
        'epic': '#9b59b6',
        'legendary': '#f39c12'
    };
    return colors[rarity] || colors['common'];
}

debugLog('Utils.js cargado');