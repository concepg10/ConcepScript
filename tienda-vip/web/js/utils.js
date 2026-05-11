// Comunicación con FiveM
function sendNui(event, data) {
    fetch(`https://${GetParentResourceName()}/` + event, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify(data || {})
    }).then(r => r.json()).catch((e) => {
        console.error('Error enviando evento NUI:', e);
    });
}

// Recibir datos de FiveM
window.addEventListener('message', function(event) {
    const data = event.data;
    
    if (data.type === 'shop:open') {
        openShop(data);
    } else if (data.type === 'shop:close') {
        closeShop();
    } else if (data.type === 'shop:updateCoins') {
        updateCoins(data.coins);
    } else if (data.type === 'shop:buySuccess') {
        buySuccess(data);
    } else if (data.type === 'shop:buyError') {
        buyError(data.message);
    }
});

// Mostrar notificación
function showNotification(message, type = 'success', duration = 3000) {
    const container = document.getElementById('notifications-container');
    const notification = document.createElement('div');
    notification.className = `notification ${type}`;
    notification.innerHTML = `
        <span>${getNotificationIcon(type)}</span>
        <span>${message}</span>
    `;
    
    container.appendChild(notification);
    
    setTimeout(() => {
        notification.classList.add('fadeOut');
        setTimeout(() => notification.remove(), 300);
    }, duration);
}

function getNotificationIcon(type) {
    const icons = {
        'success': '✓',
        'error': '✕',
        'warning': '⚠',
        'info': 'ⓘ'
    };
    return icons[type] || icons['info'];
}

// Debug log
function debugLog(message, data = null) {
    const timestamp = new Date().toLocaleTimeString();
    console.log(`%c[${timestamp}] [ConcepShop] %c${message}`, 'color: #FFD700; font-weight: bold;', 'color: #ecf0f1;', data || '');
}

debugLog('Utils.js cargado');