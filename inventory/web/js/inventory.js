/* ╔═══════════════════════════════════════════════════════════════╗
   ║     LÓGICA DEL INVENTARIO - INVENTARIO PREMIUM                ║
   ╚═══════════════════════════════════════════════════════════════╝ */

let inventoryData = {};
let draggedItem = null;
let selectedItem = null;

// Inicializar inventario
function initializeInventory() {
    debugLog('Inicializando inventario...');
    
    // Event listeners
    document.addEventListener('keydown', handleKeyDown);
    document.addEventListener('contextmenu', handleContextMenu);
    
    // Solicitar items del servidor
    sendNui('inventory:ready', {});
}

// Manejar teclas
function handleKeyDown(event) {
    if (event.key.toLowerCase() === 'escape') {
        if (InventoryState.isOpen) {
            closeInventory();
        }
    }
}

// Abrir inventario
function openInventory(container = 'player') {
    debugLog('Abriendo inventario...');
    InventoryState.isOpen = true;
    
    const inventoryContainer = document.getElementById('inventory-container');
    inventoryContainer.classList.remove('inventory-hidden');
    
    // Solicitar items
    sendNui('inventory:getItems', { container: container });
}

// Cerrar inventario
function closeInventory() {
    debugLog('Cerrando inventario...');
    InventoryState.isOpen = false;
    
    const inventoryContainer = document.getElementById('inventory-container');
    inventoryContainer.classList.add('inventory-hidden');
    
    sendNui('inventory:close', {});
}

// Actualizar display del inventario
function updateInventoryDisplay(items) {
    debugLog('Actualizando items del inventario', items);
    inventoryData = items || {};
    
    const slotsContainer = document.querySelector('.inventory-slots');
    slotsContainer.innerHTML = '';
    
    // Crear slots para cada item
    let usedSlots = 0;
    for (let item in inventoryData) {
        const quantity = inventoryData[item];
        const itemInfo = getItemInfo(item);
        
        const slot = document.createElement('div');
        slot.className = 'item-slot';
        slot.draggable = true;
        slot.innerHTML = `
            <div class="item-rarity"></div>
            <div class="item-icon">${itemInfo.icon}</div>
            <div class="item-label">${itemInfo.label}</div>
            <div class="item-quantity">${quantity}</div>
        `;
        
        slot.addEventListener('dragstart', (e) => startDrag(e, item));
        slot.addEventListener('dragend', endDrag);
        slot.addEventListener('dragover', handleDragOver);
        slot.addEventListener('drop', (e) => handleDrop(e, item));
        slot.addEventListener('contextmenu', (e) => showContextMenu(e, item));
        
        slotsContainer.appendChild(slot);
        usedSlots++;
    }
    
    // Llenar slots vacíos
    const maxSlots = InventoryConfig.maxSlots;
    for (let i = usedSlots; i < maxSlots; i++) {
        const emptySlot = document.createElement('div');
        emptySlot.className = 'item-slot empty';
        emptySlot.innerHTML = '<span class="empty-text">Vacío</span>';
        emptySlot.addEventListener('dragover', handleDragOver);
        emptySlot.addEventListener('drop', handleDrop);
        slotsContainer.appendChild(emptySlot);
    }
    
    // Actualizar información de peso y slots
    updateInventoryInfo(items);
}

// Actualizar información del inventario
function updateInventoryInfo(items) {
    const totalWeight = calculateTotalWeight(items);
    const usedSlots = calculateUsedSlots(items);
    const maxSlots = InventoryConfig.maxSlots;
    const maxWeight = InventoryConfig.maxWeight;
    
    // Actualizar UI
    document.querySelector('.weight-current').textContent = totalWeight;
    document.querySelector('.weight-max').textContent = maxWeight;
    document.querySelector('.slots-current').textContent = usedSlots;
    document.querySelector('.slots-max').textContent = maxSlots;
    
    // Actualizar barra de peso
    const weightPercentage = (totalWeight / maxWeight) * 100;
    document.querySelector('.weight-fill').style.width = weightPercentage + '%';
}

// Iniciar drag
function startDrag(event, item) {
    draggedItem = item;
    event.dataTransfer.effectAllowed = 'move';
    event.target.closest('.item-slot').classList.add('dragging');
}

// Terminar drag
function endDrag(event) {
    event.target.closest('.item-slot').classList.remove('dragging');
}

// Manejar dragover
function handleDragOver(event) {
    event.preventDefault();
    event.dataTransfer.dropEffect = 'move';
    event.target.closest('.item-slot').classList.add('dragover');
}

// Manejar drop
function handleDrop(event, targetItem) {
    event.preventDefault();
    event.target.closest('.item-slot').classList.remove('dragover');
    
    if (draggedItem && draggedItem !== targetItem) {
        sendNui('inventory:moveItem', {
            from: 'player',
            to: 'player',
            item: draggedItem,
            quantity: 1
        });
        showNotification(`${getItemInfo(draggedItem).label} movido`, 'success');
    }
}

// Filtrar items por búsqueda
function filterItems() {
    const searchTerm = document.getElementById('search-input').value.toLowerCase();
    const slots = document.querySelectorAll('.item-slot:not(.empty)');
    
    slots.forEach(slot => {
        const label = slot.querySelector('.item-label').textContent.toLowerCase();
        if (label.includes(searchTerm)) {
            slot.style.display = 'flex';
        } else {
            slot.style.display = 'none';
        }
    });
}

// Filtrar items por tipo
function filterByType(type) {
    // Actualizar botones activos
    document.querySelectorAll('.filter-btn').forEach(btn => btn.classList.remove('active'));
    event.target.classList.add('active');
    
    // Filtrar items
    const slots = document.querySelectorAll('.item-slot');
    slots.forEach(slot => {
        if (type === 'all') {
            slot.style.display = 'flex';
        } else {
            // Implementar filtrado por tipo
            slot.style.display = 'flex';
        }
    });
}

// Menú contextual
function showContextMenu(event, item) {
    event.preventDefault();
    selectedItem = item;
    
    const contextMenu = document.getElementById('context-menu');
    contextMenu.classList.remove('hidden');
    contextMenu.style.left = event.clientX + 'px';
    contextMenu.style.top = event.clientY + 'px';
}

// Usar item
function useItem() {
    if (selectedItem) {
        sendNui('inventory:useItem', { item: selectedItem });
        showNotification(`Usando ${getItemInfo(selectedItem).label}...`, 'info');
        document.getElementById('context-menu').classList.add('hidden');
    }
}

// Dropear item
function dropItem() {
    if (selectedItem) {
        sendNui('inventory:dropItem', { item: selectedItem, quantity: 1 });
        showNotification(`${getItemInfo(selectedItem).label} dropeado`, 'success');
        document.getElementById('context-menu').classList.add('hidden');
    }
}

// Información del item
function itemInfo() {
    if (selectedItem) {
        const info = getItemInfo(selectedItem);
        showNotification(`${info.label} - Peso: ${info.weight}kg - Tipo: ${info.type}`, 'info');
        document.getElementById('context-menu').classList.add('hidden');
    }
}

// Dividir stack
function splitStack() {
    showNotification('Función de dividir stack', 'info');
    document.getElementById('context-menu').classList.add('hidden');
}

// Cerrar menú contextual
document.addEventListener('click', () => {
    document.getElementById('context-menu').classList.add('hidden');
});

debugLog('Inventory.js cargado');