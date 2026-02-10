// ==========================================
// CONFIGURACIÓN (EL CEREBRO DE GRACEPRINT)
// ==========================================

// ID de la carpeta ESPECÍFICA de GracePrint
// Ahora solo mirará aquí:
const FOLDER_ID = "15CzvYFhm3xKFw-HbCEhDqaIxs6ItQfQc"; 

function doGet() {
  return HtmlService.createHtmlOutputFromFile('Index')
    .setTitle('GracePrint Kids')
    .setXFrameOptionsMode(HtmlService.XFrameOptionsMode.ALLOWALL)
    .addMetaTag('viewport', 'width=device-width, initial-scale=1');
}

/* FUNCIÓN PARA SUBIR ARCHIVOS (Soporta PDF y EPUB)
   Se guardarán obligatoriamente en la carpeta definida arriba.
*/
function uploadFile(data, name, user) {
  try {
    var contentType = data.substring(5, data.indexOf(';'));
    var bytes = Utilities.base64Decode(data.substr(data.indexOf('base64,') + 7));
    var blob = Utilities.newBlob(bytes, contentType, name);
    
    // Usamos la carpeta específica
    var folder = DriveApp.getFolderById(FOLDER_ID);
    
    // Crear el archivo
    var file = folder.createFile(blob);
    
    // Permiso público para que se pueda ver en la web
    file.setSharing(DriveApp.Access.ANYONE_WITH_LINK, DriveApp.Permission.VIEW);
    
    return { success: true, url: file.getUrl() };
    
  } catch (e) {
    return { success: false, error: e.toString() };
  }
}

/* FUNCIÓN PARA LISTAR LIBROS
   Solo lista lo que encuentre dentro de la carpeta FOLDER_ID
*/
function getFiles() {
  // Conectamos con la carpeta específica
  var folder = DriveApp.getFolderById(FOLDER_ID);
  
  // Buscar archivos dentro de ELLA
  var files = folder.getFiles();
  var result = [];
  
  while (files.hasNext()) {
    var file = files.next();
    var type = file.getMimeType();
    
    // Filtramos solo PDF y EPUB
    if (type === MimeType.PDF || type === "application/epub+zip") {
      result.push({
        name: file.getName(),
        url: file.getUrl(),
        thumbnail: "https://drive.google.com/thumbnail?id=" + file.getId() + "&sz=w400"
      });
    }
  }
  
  return result;
}

function registrarAcceso(user) {
  console.log("Acceso de usuario: " + user);
}
