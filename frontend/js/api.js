/**
 * ARCHIVO: api.js
 * Creado para simular la Base de Datos.
 * TODOS deben usar esto para no chocar.
 */

// Simulación de respuesta de la base de datos basada en nuestro diccionario
const datosFalsos = {
    productos: [
        {
            id_producto: 101,
            nombreProducto: "Cámara IP Exterior 360",
            descripcion: "Cámara resistente al agua con visión nocturna de 30m.",
            precio: 1250.50,
            stockDisponible: 15,
            urlImagen: "https://via.placeholder.com/300x200?text=Camara+Exterior"
        },
        {
            id_producto: 102,
            nombreProducto: "Cámara Domo Interior",
            descripcion: "Ideal para oficinas, micrófono integrado.",
            precio: 850.00,
            stockDisponible: 25,
            urlImagen: "https://via.placeholder.com/300x200?text=Camara+Interior"
        }
    ],
    camaras: [
        {
            idCamara: 301,
            idUbicacion: 5,
            modelo: "Hikvision 4K",
            direccionIp: "192.168.1.50",
            urlTransmision: "https://stream.g4s.com/cam301",
            estadoConexion: "Online"
        }
    ]
};

// Hacemos que los datos estén disponibles para cualquier archivo JS que los necesite
window.G4S_API = datosFalsos;

console.log("✅ Diccionario de API cargado correctamente.");
