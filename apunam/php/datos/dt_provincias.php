<?php
class dt_provincias extends apunam_datos_tabla
{
	function get_descripciones()
	{
		$sql = "SELECT id, nombre  FROM provincias ORDER BY nombre";
		return toba::db('apunam')->consultar($sql);
	}
}
?>