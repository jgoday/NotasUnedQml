# Resumen
Pequeña aplicación en qml + qt para acceder directamente a las notas de grado UNED
publicadas en la secretaría virtual : https://serviweb.uned.es/sec-virtual/calificaciones/grados.asp

Se utiliza el control webview para simular el acceso al servicio, dado que no existe una api de acceso.

# Almacenaje de credenciales
Si se marca la opción 'Recordar usuario', se guardará el nombre de usuario + clave ( encriptada )
usando QSettings.

En windows se guardarán en el registro.

La encriptación de la clave se realiza utilizando la clase SimpleCrypt
de Andre Somers: https://qt-project.org/wiki/Simple_encryption

# Deploy en windows :
 Para copiar las librerias de Qt en el directorio del ejecutable
 ´windeployqt.exe .\notas-uned.exe´

# Qt
Versión: Qt 5.2.1
