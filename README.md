register.sh
============

Script en bash que genera registros para [OpenDKIM](http://www.opendkim.org "OpenDKIM")

Dependencias
============

- [opendkim-genkey](http://www.opendkim.org/opendkim-genkey.8.html "opendkim-genkey")
- [awk](https://www.gnu.org/software/gawk/ "awk")
- [sed](https://www.gnu.org/software/sed/ "sed")


Uso
===

Desde la carpeta donde están los registros y archivos KeyTable, SigningTable, TrustedHosts

$./register.sh 

El script pregunta por un dominio - lo que se escribiría después de la @ en la dirección de correo.
Tal vez necesitas tener permisos de administrador en esa carpeta. 


Ajustes
===========
Los siguientes valores se pueden ajustar si es necesario:

La ruta donde están los archivos de opendkim es: 
opendkimpath="/etc/opendkim/"

Utiliza el comodín para hablitar OpenDKIM en todas las direcciones de el dominio.
Si únicamente se quiere user@example.com sustituir * por user:

address="*@"$domain

Después se tiene que crear un registro TXT en donde registrate el nombre de dominio.

El valor para asignar en Host es *: example.com._domainkey
El valor para asignar en Answer es comienza con *: v=DKIM

* Los valores se muestran al concluir el script

Finalmente reinicia OpenDKIM para ver los cambios