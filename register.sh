# The MIT License (MIT)
# 
# Copyright (c) 2015 eamexicano
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

#!/bin/bash

echo "Escribe el dominio para incorporar a DKIM."
echo "En específico el texto que va después de la arroba - @ - en las direcciones de correo: "
read domain

opendkimpath="/etc/opendkim/"
address="*@"$domain
server=$(echo $domain | awk -F\. '{print $1}')

echo "Generando la clave para $domain "
opendkim-genkey -t -s $server -d $domain

echo "Anexando la clave a KeyTable"
echo "$server._domainkey $domain:$server:$opendkimpath$server.private" | cat >> KeyTable

echo "Anexando la dirección $address al archivo SigningTable"
echo "$address" | cat >> SigningTable

echo "Anexando el dominio $domain al archivo TrustedHosts"
echo "$domain" | cat >> TrustedHosts


echo "Agregar un registro TXT con los siguientes valores: "
echo "El valor para asignar en Host es: $server._domainkey"
echo "El valor para asignar en Answer es (sin espacios ni saltos de línea): "
sed 's/^[^"]*"\([^"]*\)".*/\1/' "$server.txt"

echo "Una vez hecho esto reiniciar opendkim: "
echo "sudo service opendkim reload"