<?php
/**
 * Esta clase fue y será generada automáticamente. NO EDITAR A MANO.
 * @ignore
 */
class apunam_autoload 
{
	static function existe_clase($nombre)
	{
		return isset(self::$clases[$nombre]);
	}

	static function cargar($nombre)
	{
		if (self::existe_clase($nombre)) { 
			 require_once(dirname(__FILE__) .'/'. self::$clases[$nombre]); 
		}
	}

	static protected $clases = array(
		'apunam_comando' => 'extension_toba/apunam_comando.php',
		'apunam_modelo' => 'extension_toba/apunam_modelo.php',
		'apunam_ci' => 'extension_toba/componentes/apunam_ci.php',
		'apunam_cn' => 'extension_toba/componentes/apunam_cn.php',
		'apunam_datos_relacion' => 'extension_toba/componentes/apunam_datos_relacion.php',
		'apunam_datos_tabla' => 'extension_toba/componentes/apunam_datos_tabla.php',
		'apunam_ei_arbol' => 'extension_toba/componentes/apunam_ei_arbol.php',
		'apunam_ei_archivos' => 'extension_toba/componentes/apunam_ei_archivos.php',
		'apunam_ei_calendario' => 'extension_toba/componentes/apunam_ei_calendario.php',
		'apunam_ei_codigo' => 'extension_toba/componentes/apunam_ei_codigo.php',
		'apunam_ei_cuadro' => 'extension_toba/componentes/apunam_ei_cuadro.php',
		'apunam_ei_esquema' => 'extension_toba/componentes/apunam_ei_esquema.php',
		'apunam_ei_filtro' => 'extension_toba/componentes/apunam_ei_filtro.php',
		'apunam_ei_firma' => 'extension_toba/componentes/apunam_ei_firma.php',
		'apunam_ei_formulario' => 'extension_toba/componentes/apunam_ei_formulario.php',
		'apunam_ei_formulario_ml' => 'extension_toba/componentes/apunam_ei_formulario_ml.php',
		'apunam_ei_grafico' => 'extension_toba/componentes/apunam_ei_grafico.php',
		'apunam_ei_mapa' => 'extension_toba/componentes/apunam_ei_mapa.php',
		'apunam_servicio_web' => 'extension_toba/componentes/apunam_servicio_web.php',
	);
}
?>