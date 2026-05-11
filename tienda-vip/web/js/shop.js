let allItems = [];
let currentCoins = 0;
let currentFilter = 'all';

// Abrir tienda
function openShop(data) {
    debugLog('Abriendo tienda...');
    
    allItems = data.items || [];
    const container = document.getElementById('shop-container');
    container.classList.remove('shop-hidden');
    
    // Generar categorías
    renderCategories(data.categories);
    
    // Mostrar items
    renderItems(allItems);
    
    document.addEventListener('keydown', handleKeyDown);
}

// Cerrar tienda
function closeShop() {
    debugLog('Cerrando tienda...');
    
    const container = document.getElementById('shop-container');
    container.classList.add('shop-hidden');
    
    sendNui('shop:close', {});
    document.removeEventListener('keydown', handleKeyDown);
}

// Manejar tecla ESC
function handleKeyDown(event) {
    if (event.key === 'Escape') {
        closeShop();
    }
}

// Renderizar categorías
function renderCategories(categories) {
    const container = document.getElementById('categoriesContainer');
    container.innerHTML = '';
    
    categories.forEach(cat => {
        const btn = document.createElement('button');
        btn.className = `category-btn ${cat.value === 'all' ? 'active' : ''}`;
        btn.innerHTML = `${cat.icon} ${cat.name}`;
        btn.onclick = () => filterByCategory(cat.value);
        container.appendChild(btn);
    });
}

// Renderizar items
function renderItems(items) {
    const container = document.getElementById('itemsContainer');
    container.innerHTML = '';
    
    if (items.length === 0) {
        container.innerHTML = '<p style="grid-column: 1/-1; text-align: center; color: #95a5a6; padding: 40px;">No hay items disponibles</p>';
        return;
    }
    
    items.forEach(item => {
        const card = document.createElement('div');
        const isOffer = item.price < item.originalPrice;
        const discount = isOffer ? Math.round(((item.originalPrice - item.price) / item.originalPrice) * 100) : 0;
        
        card.className = `item-card ${isOffer ? 'offer' : ''}`;
        card.innerHTML = `
            <div class="item-icon">${item.icon}</div>
            <div class="item-name">${item.name}</div>
            <div class="item-description">${item.description}</div>
            <div class="item-price">
                ${isOffer ? `<div class="price-original">♥ ${item.originalPrice}</div>` : ''}
                <div class="price-current">💎 ${item.price}</div>
                ${isOffer ? `<div class="price-discount">-${discount}%</div>` : ''}
            </div>
            <button class="buy-btn" onclick="buyItem(${item.id}, ${item.price})" ${currentCoins < item.price ? 'disabled' : ''}>
                ${currentCoins < item.price ? 'SIN COINS' : 'COMPRAR'}
            </button>
        `;
        container.appendChild(card);
    });
}

// Filtrar por categoría
function filterByCategory(category) {
    currentFilter = category;
    
    // Actualizar botones activos
    document.querySelectorAll('.category-btn').forEach(btn => btn.classList.remove('active'));
    event.target.classList.add('active');
    
    // Filtrar items
    let filtered = allItems;
    if (category !== 'all') {
        filtered = allItems.filter(item => item.category === category);
    }
    renderItems(filtered);
}

// Filtrar items por búsqueda
function filterItems() {
    const searchTerm = document.getElementById('searchInput').value.toLowerCase();
    let filtered = allItems;
    
    if (currentFilter !== 'all') {
        filtered = filtered.filter(item => item.category === currentFilter);
    }
    
    if (searchTerm) {
        filtered = filtered.filter(item => 
            item.name.toLowerCase().includes(searchTerm) || 
            item.description.toLowerCase().includes(searchTerm)
        );
    }
    
    renderItems(filtered);
}

// Comprar item
function buyItem(itemId, price) {
    if (currentCoins < price) {
        showNotification('No tienes suficientes VIP Coins', 'error');
        return;
    }
    
    debugLog('Comprando item: ' + itemId);
    sendNui('shop:buyItem', {itemId: itemId, price: price});
}

// Actualizar coins
function updateCoins(coins) {
    currentCoins = coins;
    document.getElementById('coinsAmount').textContent = coins;
    
    // Actualizar botones
    document.querySelectorAll('.buy-btn').forEach(btn => {
        const price = parseInt(btn.parentElement.querySelector('.price-current').textContent.split(' ')[1]);
        if (coins < price) {
            btn.disabled = true;
            btn.textContent = 'SIN COINS';
        } else {
            btn.disabled = false;
            btn.textContent = 'COMPRAR';
        }
    });
}

// Compra exitosa
function buySuccess(data) {
    showNotification(`✓ Compraste: ${data.itemName}`, 'success');
    updateCoins(data.newCoins);
    
    // Renderizar items nuevamente para actualizar botones
    let filtered = allItems;
    if (currentFilter !== 'all') {
        filtered = allItems.filter(item => item.category === currentFilter);
    }
    renderItems(filtered);
}

// Error en compra
function buyError(message) {
    showNotification(`✕ ${message}`, 'error');
}

// Inicializar cuando se carga
document.addEventListener('DOMContentLoaded', () => {
    debugLog('Tienda VIP cargada');
});

debugLog('Shop.js cargado');