/* Esta query devuelve el inmediatamente anterior más pequeño que cumple con la cadena */

select
keyvalue, Longitud, Partida, Nombre,
(SELECT TOP 1 b.keyvalue
  FROm parentandchild b
   where substring(a.partida,1,
       (select TOP 1 MAX(c.longitud) from parentandchild c where substring(c.Partida,1,1) = substring(a.partida,1,1) and c.longitud < a.longitud and c.keyvalue = a.keyvalue and CHARINDEX(c.Partida, a.Partida) > 0) 
   )= b.Partida and a.partida != b.partida and a.keyvalue = b.keyvalue)
as Padre
from parentandchild a

