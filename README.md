# 🎮 ConcepScripts - Inventario Premium

## 📦 Sistema de Inventario Único y Original para FiveM

Un script profesional, moderno y totalmente funcional de inventario para servidores FiveM compatible con **ESX**, **QBCore** y **QBox**.

---

## ✨ Características Principales

✅ **Diseño Moderno y Responsivo**
- Interfaz moderna con gradientes y efectos visuales
- Adaptable a cualquier resolución de pantalla
- Animaciones fluidas y profesionales

✅ **Sistema de Slots y Peso**
- Máximo de 50 slots configurables
- Sistema de peso con límite de 150 kg
- Visualización en tiempo real

✅ **Drag & Drop Funcional**
- Arrastra items entre slots
- Reordenamiento libre
- Visual feedback en tiempo real

✅ **Múltiples Contenedores**
- Inventario Personal
- Maletero del Vehículo
- Almacenamiento de Casa
- Tienda/Comercio

✅ **Búsqueda y Filtrado**
- Búsqueda por nombre en tiempo real
- Filtros por tipo de item
- Búsqueda instantánea

✅ **Menú Contextual**
- Clic derecho para opciones
- Usar item
- Dropear
- Ver información
- Dividir cantidad

✅ **Notificaciones**
- Sistema de notificaciones avanzado
- Diferentes tipos (éxito, error, advertencia, info)
- Auto-cierre automático

✅ **Compatibilidad Multi-Framework**
- ESX (Primario)
- QBCore
- QBox
- Detección automática

---

## 🚀 Instalación

### Paso 1: Descargar
```bash
cd resources
git clone https://github.com/concepg10/ConcepScript inventory
```

### Paso 2: Agregar a server.cfg
```cfg
ensure inventory
```

### Paso 3: Reiniciar Servidor
```bash
restart inventory
```

---

## 📖 Uso

### Abrir Inventario
```lua
-- Con tecla
Presiona 'I'

-- Con comando
/inventario

-- Con exportación
exports['inventory']:openInventory('player')
```

### Cerrar Inventario
```lua
-- Con tecla
Presiona 'ESC'

-- Con exportación
exports['inventory']:closeInventory()
```

---

## 💻 Exportaciones

### Cliente

```lua
-- Abrir inventario
exports['inventory']:openInventory(container)
-- Contenedores: 'player', 'trunk', 'stash', 'shop'

-- Cerrar inventario
exports['inventory']:closeInventory()

-- Obtener inventario actual
local inventory = exports['inventory']:getInventory()
```

### Servidor

```lua
-- Agregar item a jugador
exports['inventory']:addItem(playerId, 'water', 10)

-- Remover item de jugador
exports['inventory']:removeItem(playerId, 'bread', 5)
```

---

## ⚙️ Configuración

Edita `inventory/config.lua` para personalizar:

```lua
-- Máximo de slots
Config.MaxSlots = 50

-- Peso máximo
Config.MaxWeight = 150

-- Tecla para abrir
Config.OpenInventoryKey = 'I'

-- Tecla para cerrar
Config.CloseInventoryKey = 'ESC'
```

---

## 📸 Visualización

### Interfaz Principal
```
┌─────────────────────────────────────────────────────────────────┐
│ 🎒 Inventario Personal    Peso: 45/150 kg  Slots: 12/50     ✕   │
├─────────────────────────────────────────────────────────────────┤
│ 🔍 Buscar items...  [Todo] [Consumibles] [Armas] [Valiosos]     │
├─────────────────────────────────────────────────────────────────┤
│                                                                   │
│  ┌──────┐  ┌──────┐  ┌──────┐  ┌──────┐  ┌──────┐  ┌──────┐   │
│  │  💧  │  │  🍞  │  │  💵  │  │  📱  │  │  🏆  │  │      │   │
│  │Water │  │Bread │  │Money │  │Phone │  │Gold  │  │Empty │   │
│  │ x50  │  │ x30  │  │x999k │  │ x1   │  │ x5   │  │      │   │
│  └──────┘  └──────┘  └──────┘  └──────┘  └──────┘  └──────┘   │
│                                                                   │
├─────────────────────────────────────────────────────────────────┤
│ 💡 Arrastra para mover • Clic derecho para opciones • ESC      │
└─────────────────────────────────────────────────────────────────┘
```

---

## 🎨 Personalización de Items

Edita `inventory/config.lua`:

```lua
Config.DefaultItems = {
    {
        name = 'custom_item',
        label = 'Mi Item Personalizado',
        weight = 0.5,
        stackable = true,
        icon = '🎁',
        type = 'consumible',
        description = 'Descripción del item'
    }
}
```

---

## 🐛 Solución de Problemas

### El inventario no abre
- Verifica que el framework esté correctamente instalado
- Revisa la consola del servidor para errores
- Asegúrate de que el recurso está iniciado

### Items no se guardan
- Revisa la base de datos
- Comprueba permisos del servidor
- Reinicia el servidor

### UI se ve rota
- Limpia el cache del navegador (Ctrl+Shift+Del)
- Actualiza la página (F5)
- Revisa la resolución de pantalla

---

## 📋 Requisitos

- **FiveM** instalado en el servidor
- **Framework**: ESX, QBCore o QBox
- **Lua** 5.4+
- **JavaScript** ES6+

---

## 📄 Licencia

Este script es **completamente original** y está bajo licencia Creative Commons.

**Uso comercial permitido** con atribución.

---

## 💬 Soporte

**Discord**: [Tu Discord]
**Email**: [Tu Email]

---

## 👨‍💻 Autor

**ConcepScripts** - Scripts Profesionales para FiveM

---

## 🎉 Agradecimientos

Gracias por usar nuestro script. ¡Disfruta!

**Última actualización**: 2026-05-10
**Versión**: 1.0.0