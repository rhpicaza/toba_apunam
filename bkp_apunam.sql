--
-- PostgreSQL database dump
--

-- Dumped from database version 8.4.19
-- Dumped by pg_dump version 9.3.1
-- Started on 2014-03-20 18:21:24

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'SQL_ASCII';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- TOC entry 22 (class 2615 OID 20195)
-- Name: apunam; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA apunam;


ALTER SCHEMA apunam OWNER TO postgres;

--
-- TOC entry 3 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- TOC entry 2276 (class 0 OID 0)
-- Dependencies: 3
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET search_path = public, pg_catalog;

--
-- TOC entry 245 (class 1255 OID 18804)
-- Name: recuperar_schema_temp(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION recuperar_schema_temp() RETURNS character varying
    LANGUAGE plpgsql
    AS $$
			DECLARE
			   schemas varchar;
			   pos_inicial int4;
			   pos_final int4;
			   schema_temp varchar;
			BEGIN
			   schema_temp := '';
			   SELECT INTO schemas current_schemas(true);
			   SELECT INTO pos_inicial strpos(schemas, 'pg_temp');
			   IF (pos_inicial > 0) THEN
			      SELECT INTO pos_final strpos(schemas, ',');
			      SELECT INTO schema_temp substr(schemas, pos_inicial, pos_final - pos_inicial);
			   END IF;
			   RETURN schema_temp;
			END;
			$$;


ALTER FUNCTION public.recuperar_schema_temp() OWNER TO postgres;

SET search_path = apunam, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 225 (class 1259 OID 20302)
-- Name: personas; Type: TABLE; Schema: apunam; Owner: postgres; Tablespace: 
--

CREATE TABLE personas (
    id integer NOT NULL,
    legajo integer,
    t_doc smallint,
    num_doc integer,
    e_civil smallint,
    domicilio character varying,
    cp smallint,
    provincia integer,
    localidad integer,
    tel_num integer,
    tel_area smallint,
    cel_num integer,
    cel_area smallint,
    sexo smallint,
    estado boolean DEFAULT true
);


ALTER TABLE apunam.personas OWNER TO postgres;

--
-- TOC entry 195 (class 1259 OID 20196)
-- Name: afiliado_id_seq; Type: SEQUENCE; Schema: apunam; Owner: postgres
--

CREATE SEQUENCE afiliado_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE apunam.afiliado_id_seq OWNER TO postgres;

--
-- TOC entry 2278 (class 0 OID 0)
-- Dependencies: 195
-- Name: afiliado_id_seq; Type: SEQUENCE OWNED BY; Schema: apunam; Owner: postgres
--

ALTER SEQUENCE afiliado_id_seq OWNED BY personas.id;


--
-- TOC entry 214 (class 1259 OID 20234)
-- Name: afiliado_perfil; Type: TABLE; Schema: apunam; Owner: postgres; Tablespace: 
--

CREATE TABLE afiliado_perfil (
    id integer NOT NULL,
    id_persona integer,
    cargo_gremial boolean,
    inhibido boolean,
    jubilado boolean,
    no_apunam boolean,
    f_ingreso date,
    f_egreso date,
    afiliado boolean,
    id_sede integer
);


ALTER TABLE apunam.afiliado_perfil OWNER TO postgres;

--
-- TOC entry 196 (class 1259 OID 20198)
-- Name: afiliado_perfil_id_seq; Type: SEQUENCE; Schema: apunam; Owner: postgres
--

CREATE SEQUENCE afiliado_perfil_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE apunam.afiliado_perfil_id_seq OWNER TO postgres;

--
-- TOC entry 2279 (class 0 OID 0)
-- Dependencies: 196
-- Name: afiliado_perfil_id_seq; Type: SEQUENCE OWNED BY; Schema: apunam; Owner: postgres
--

ALTER SEQUENCE afiliado_perfil_id_seq OWNED BY afiliado_perfil.id;


--
-- TOC entry 216 (class 1259 OID 20245)
-- Name: cheques_afiliado; Type: TABLE; Schema: apunam; Owner: postgres; Tablespace: 
--

CREATE TABLE cheques_afiliado (
    id integer NOT NULL,
    id_afiliado integer NOT NULL,
    id_cheque integer NOT NULL
);


ALTER TABLE apunam.cheques_afiliado OWNER TO postgres;

--
-- TOC entry 197 (class 1259 OID 20200)
-- Name: cheque_afiliado_id_seq; Type: SEQUENCE; Schema: apunam; Owner: postgres
--

CREATE SEQUENCE cheque_afiliado_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE apunam.cheque_afiliado_id_seq OWNER TO postgres;

--
-- TOC entry 2280 (class 0 OID 0)
-- Dependencies: 197
-- Name: cheque_afiliado_id_seq; Type: SEQUENCE OWNED BY; Schema: apunam; Owner: postgres
--

ALTER SEQUENCE cheque_afiliado_id_seq OWNED BY cheques_afiliado.id;


--
-- TOC entry 217 (class 1259 OID 20249)
-- Name: cheques_proveedor; Type: TABLE; Schema: apunam; Owner: postgres; Tablespace: 
--

CREATE TABLE cheques_proveedor (
    id integer NOT NULL,
    id_proveedor integer NOT NULL,
    id_cheque integer NOT NULL
);


ALTER TABLE apunam.cheques_proveedor OWNER TO postgres;

--
-- TOC entry 198 (class 1259 OID 20202)
-- Name: cheque_proveedor_id_seq; Type: SEQUENCE; Schema: apunam; Owner: postgres
--

CREATE SEQUENCE cheque_proveedor_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE apunam.cheque_proveedor_id_seq OWNER TO postgres;

--
-- TOC entry 2281 (class 0 OID 0)
-- Dependencies: 198
-- Name: cheque_proveedor_id_seq; Type: SEQUENCE OWNED BY; Schema: apunam; Owner: postgres
--

ALTER SEQUENCE cheque_proveedor_id_seq OWNED BY cheques_proveedor.id;


--
-- TOC entry 215 (class 1259 OID 20238)
-- Name: cheques; Type: TABLE; Schema: apunam; Owner: postgres; Tablespace: 
--

CREATE TABLE cheques (
    id integer NOT NULL,
    nro character varying,
    banco character varying,
    observacion character varying,
    monto integer,
    f_emision date,
    f_cobro date
);


ALTER TABLE apunam.cheques OWNER TO postgres;

--
-- TOC entry 199 (class 1259 OID 20204)
-- Name: cheques_id_seq; Type: SEQUENCE; Schema: apunam; Owner: postgres
--

CREATE SEQUENCE cheques_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE apunam.cheques_id_seq OWNER TO postgres;

--
-- TOC entry 2282 (class 0 OID 0)
-- Dependencies: 199
-- Name: cheques_id_seq; Type: SEQUENCE OWNED BY; Schema: apunam; Owner: postgres
--

ALTER SEQUENCE cheques_id_seq OWNED BY cheques.id;


--
-- TOC entry 218 (class 1259 OID 20253)
-- Name: conciliacion; Type: TABLE; Schema: apunam; Owner: postgres; Tablespace: 
--

CREATE TABLE conciliacion (
    id bigint NOT NULL,
    id_periodo smallint,
    num_legajo integer,
    num_liquidacion integer,
    apellido character varying,
    nombre character varying,
    tipo_doc character varying,
    num_doc integer,
    monto numeric(9,2),
    concepto smallint,
    id_afiliado integer
);


ALTER TABLE apunam.conciliacion OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 20206)
-- Name: conciliacion_id_seq; Type: SEQUENCE; Schema: apunam; Owner: postgres
--

CREATE SEQUENCE conciliacion_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE apunam.conciliacion_id_seq OWNER TO postgres;

--
-- TOC entry 2283 (class 0 OID 0)
-- Dependencies: 200
-- Name: conciliacion_id_seq; Type: SEQUENCE OWNED BY; Schema: apunam; Owner: postgres
--

ALTER SEQUENCE conciliacion_id_seq OWNED BY conciliacion.id;


--
-- TOC entry 219 (class 1259 OID 20260)
-- Name: conv_proveedor; Type: TABLE; Schema: apunam; Owner: postgres; Tablespace: 
--

CREATE TABLE conv_proveedor (
    id integer NOT NULL,
    id_conveniio integer,
    id_proveedor integer,
    f_vigencia date,
    f_baja date,
    documento character varying
);


ALTER TABLE apunam.conv_proveedor OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 20208)
-- Name: conv_proveedor_id_seq; Type: SEQUENCE; Schema: apunam; Owner: postgres
--

CREATE SEQUENCE conv_proveedor_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE apunam.conv_proveedor_id_seq OWNER TO postgres;

--
-- TOC entry 2284 (class 0 OID 0)
-- Dependencies: 201
-- Name: conv_proveedor_id_seq; Type: SEQUENCE OWNED BY; Schema: apunam; Owner: postgres
--

ALTER SEQUENCE conv_proveedor_id_seq OWNED BY conv_proveedor.id;


--
-- TOC entry 220 (class 1259 OID 20267)
-- Name: convenios; Type: TABLE; Schema: apunam; Owner: postgres; Tablespace: 
--

CREATE TABLE convenios (
    id integer NOT NULL,
    titulo character varying,
    observacion character varying,
    estado boolean,
    desc_porc numeric(24,2),
    desc_fijo numeric(24,2),
    es_desc_porc boolean
);


ALTER TABLE apunam.convenios OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 20210)
-- Name: convenios_id_seq; Type: SEQUENCE; Schema: apunam; Owner: postgres
--

CREATE SEQUENCE convenios_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE apunam.convenios_id_seq OWNER TO postgres;

--
-- TOC entry 2285 (class 0 OID 0)
-- Dependencies: 202
-- Name: convenios_id_seq; Type: SEQUENCE OWNED BY; Schema: apunam; Owner: postgres
--

ALTER SEQUENCE convenios_id_seq OWNED BY convenios.id;


--
-- TOC entry 221 (class 1259 OID 20274)
-- Name: cuenta; Type: TABLE; Schema: apunam; Owner: postgres; Tablespace: 
--

CREATE TABLE cuenta (
    id integer NOT NULL,
    id_proveedor integer NOT NULL,
    tipo character varying NOT NULL,
    nro character varying NOT NULL,
    cbu integer,
    banco character varying NOT NULL
);


ALTER TABLE apunam.cuenta OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 20212)
-- Name: cuenta_id_seq; Type: SEQUENCE; Schema: apunam; Owner: postgres
--

CREATE SEQUENCE cuenta_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE apunam.cuenta_id_seq OWNER TO postgres;

--
-- TOC entry 2286 (class 0 OID 0)
-- Dependencies: 203
-- Name: cuenta_id_seq; Type: SEQUENCE OWNED BY; Schema: apunam; Owner: postgres
--

ALTER SEQUENCE cuenta_id_seq OWNED BY cuenta.id;


--
-- TOC entry 222 (class 1259 OID 20281)
-- Name: cuentas; Type: TABLE; Schema: apunam; Owner: postgres; Tablespace: 
--

CREATE TABLE cuentas (
    id integer NOT NULL,
    nombre character varying,
    descripcion character varying,
    fecha_saldo date,
    saldo numeric(18,2)
);


ALTER TABLE apunam.cuentas OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 20214)
-- Name: cuentas_id_seq; Type: SEQUENCE; Schema: apunam; Owner: postgres
--

CREATE SEQUENCE cuentas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE apunam.cuentas_id_seq OWNER TO postgres;

--
-- TOC entry 2287 (class 0 OID 0)
-- Dependencies: 204
-- Name: cuentas_id_seq; Type: SEQUENCE OWNED BY; Schema: apunam; Owner: postgres
--

ALTER SEQUENCE cuentas_id_seq OWNED BY cuentas.id;


--
-- TOC entry 223 (class 1259 OID 20288)
-- Name: localidades; Type: TABLE; Schema: apunam; Owner: postgres; Tablespace: 
--

CREATE TABLE localidades (
    id integer NOT NULL,
    nombre character varying,
    id_provincia integer
);


ALTER TABLE apunam.localidades OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 20216)
-- Name: localidad_id_seq; Type: SEQUENCE; Schema: apunam; Owner: postgres
--

CREATE SEQUENCE localidad_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE apunam.localidad_id_seq OWNER TO postgres;

--
-- TOC entry 2288 (class 0 OID 0)
-- Dependencies: 205
-- Name: localidad_id_seq; Type: SEQUENCE OWNED BY; Schema: apunam; Owner: postgres
--

ALTER SEQUENCE localidad_id_seq OWNED BY localidades.id;


--
-- TOC entry 224 (class 1259 OID 20295)
-- Name: periodo; Type: TABLE; Schema: apunam; Owner: postgres; Tablespace: 
--

CREATE TABLE periodo (
    id integer NOT NULL,
    periodo date,
    descripcion character varying,
    observacion character varying
);


ALTER TABLE apunam.periodo OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 20218)
-- Name: periodo_id_seq; Type: SEQUENCE; Schema: apunam; Owner: postgres
--

CREATE SEQUENCE periodo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE apunam.periodo_id_seq OWNER TO postgres;

--
-- TOC entry 2289 (class 0 OID 0)
-- Dependencies: 206
-- Name: periodo_id_seq; Type: SEQUENCE OWNED BY; Schema: apunam; Owner: postgres
--

ALTER SEQUENCE periodo_id_seq OWNED BY periodo.id;


--
-- TOC entry 226 (class 1259 OID 20309)
-- Name: planes_emision; Type: TABLE; Schema: apunam; Owner: postgres; Tablespace: 
--

CREATE TABLE planes_emision (
    id integer NOT NULL,
    id_afiliado integer NOT NULL,
    id_proveedor integer,
    tipo smallint,
    i_total numeric(10,2),
    cuotas smallint,
    cant_vales smallint,
    f_descuento date,
    activo boolean,
    observacion character varying,
    id_tipo_plan smallint
);


ALTER TABLE apunam.planes_emision OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 20220)
-- Name: planes_emision_id_seq; Type: SEQUENCE; Schema: apunam; Owner: postgres
--

CREATE SEQUENCE planes_emision_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE apunam.planes_emision_id_seq OWNER TO postgres;

--
-- TOC entry 2290 (class 0 OID 0)
-- Dependencies: 207
-- Name: planes_emision_id_seq; Type: SEQUENCE OWNED BY; Schema: apunam; Owner: postgres
--

ALTER SEQUENCE planes_emision_id_seq OWNED BY planes_emision.id;


--
-- TOC entry 227 (class 1259 OID 20316)
-- Name: proveedores; Type: TABLE; Schema: apunam; Owner: postgres; Tablespace: 
--

CREATE TABLE proveedores (
    id integer NOT NULL,
    codigo integer,
    razon_social character varying,
    domicilio character varying,
    localidad smallint,
    provincia smallint,
    tel_num integer,
    tel_area smallint,
    cel_num integer,
    cel_area smallint,
    cuit integer,
    estado boolean
);


ALTER TABLE apunam.proveedores OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 20222)
-- Name: proveedor_id_seq; Type: SEQUENCE; Schema: apunam; Owner: postgres
--

CREATE SEQUENCE proveedor_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE apunam.proveedor_id_seq OWNER TO postgres;

--
-- TOC entry 2291 (class 0 OID 0)
-- Dependencies: 208
-- Name: proveedor_id_seq; Type: SEQUENCE OWNED BY; Schema: apunam; Owner: postgres
--

ALTER SEQUENCE proveedor_id_seq OWNED BY proveedores.id;


--
-- TOC entry 228 (class 1259 OID 20330)
-- Name: provincias; Type: TABLE; Schema: apunam; Owner: postgres; Tablespace: 
--

CREATE TABLE provincias (
    id integer NOT NULL,
    nombre character varying
);


ALTER TABLE apunam.provincias OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 20224)
-- Name: provincia_id_seq; Type: SEQUENCE; Schema: apunam; Owner: postgres
--

CREATE SEQUENCE provincia_id_seq
    START WITH 2
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE apunam.provincia_id_seq OWNER TO postgres;

--
-- TOC entry 2292 (class 0 OID 0)
-- Dependencies: 209
-- Name: provincia_id_seq; Type: SEQUENCE OWNED BY; Schema: apunam; Owner: postgres
--

ALTER SEQUENCE provincia_id_seq OWNED BY provincias.id;


--
-- TOC entry 229 (class 1259 OID 20337)
-- Name: reglas; Type: TABLE; Schema: apunam; Owner: postgres; Tablespace: 
--

CREATE TABLE reglas (
    id integer NOT NULL,
    es_funcionario boolean,
    f_vigencia date,
    f_baja date,
    regla numeric(24,2)
);


ALTER TABLE apunam.reglas OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 20226)
-- Name: reglas_id_seq; Type: SEQUENCE; Schema: apunam; Owner: postgres
--

CREATE SEQUENCE reglas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE apunam.reglas_id_seq OWNER TO postgres;

--
-- TOC entry 2293 (class 0 OID 0)
-- Dependencies: 210
-- Name: reglas_id_seq; Type: SEQUENCE OWNED BY; Schema: apunam; Owner: postgres
--

ALTER SEQUENCE reglas_id_seq OWNED BY reglas.id;


--
-- TOC entry 230 (class 1259 OID 20341)
-- Name: sedes; Type: TABLE; Schema: apunam; Owner: postgres; Tablespace: 
--

CREATE TABLE sedes (
    id integer NOT NULL,
    nombre character varying
);


ALTER TABLE apunam.sedes OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 20228)
-- Name: sede_id_seq; Type: SEQUENCE; Schema: apunam; Owner: postgres
--

CREATE SEQUENCE sede_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE apunam.sede_id_seq OWNER TO postgres;

--
-- TOC entry 2294 (class 0 OID 0)
-- Dependencies: 211
-- Name: sede_id_seq; Type: SEQUENCE OWNED BY; Schema: apunam; Owner: postgres
--

ALTER SEQUENCE sede_id_seq OWNED BY sedes.id;


--
-- TOC entry 231 (class 1259 OID 20348)
-- Name: tipo_plan; Type: TABLE; Schema: apunam; Owner: postgres; Tablespace: 
--

CREATE TABLE tipo_plan (
    id integer NOT NULL,
    tipo character varying,
    descripcion character varying
);


ALTER TABLE apunam.tipo_plan OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 20230)
-- Name: tipo_plan_id_seq; Type: SEQUENCE; Schema: apunam; Owner: postgres
--

CREATE SEQUENCE tipo_plan_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE apunam.tipo_plan_id_seq OWNER TO postgres;

--
-- TOC entry 2295 (class 0 OID 0)
-- Dependencies: 212
-- Name: tipo_plan_id_seq; Type: SEQUENCE OWNED BY; Schema: apunam; Owner: postgres
--

ALTER SEQUENCE tipo_plan_id_seq OWNED BY tipo_plan.id;


--
-- TOC entry 232 (class 1259 OID 20355)
-- Name: vales; Type: TABLE; Schema: apunam; Owner: postgres; Tablespace: 
--

CREATE TABLE vales (
    id integer NOT NULL,
    id_plan_emision integer NOT NULL,
    nro_cuota smallint,
    cant_cuota smallint,
    monto_cuota numeric(10,2),
    pagado boolean,
    f_cobro date,
    f_pago date,
    f_conciliacion date,
    id_conciliacion bigint
);


ALTER TABLE apunam.vales OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 20232)
-- Name: vales_id_seq1; Type: SEQUENCE; Schema: apunam; Owner: postgres
--

CREATE SEQUENCE vales_id_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE apunam.vales_id_seq1 OWNER TO postgres;

--
-- TOC entry 2296 (class 0 OID 0)
-- Dependencies: 213
-- Name: vales_id_seq1; Type: SEQUENCE OWNED BY; Schema: apunam; Owner: postgres
--

ALTER SEQUENCE vales_id_seq1 OWNED BY vales.id;


SET search_path = public, pg_catalog;

--
-- TOC entry 157 (class 1259 OID 18783)
-- Name: PERSONAS; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "PERSONAS" (
    "ID" integer NOT NULL,
    "LEGAJO" integer,
    "T_DOC" smallint,
    "NUM_DOC" integer,
    "E_CIVIL" smallint,
    "DOMICILIO" character varying,
    "CP" smallint,
    "PROVINCIA" integer,
    "LOCALIDAD" integer,
    "TEL_NUM" integer,
    "TEL_AREA" smallint,
    "CEL_NUM" integer,
    "CEL_AREA" smallint,
    "SEXO" smallint,
    "ESTADO" boolean DEFAULT true
);


ALTER TABLE public."PERSONAS" OWNER TO postgres;

--
-- TOC entry 156 (class 1259 OID 18781)
-- Name: AFILIADO_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "AFILIADO_ID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."AFILIADO_ID_seq" OWNER TO postgres;

--
-- TOC entry 2297 (class 0 OID 0)
-- Dependencies: 156
-- Name: AFILIADO_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "AFILIADO_ID_seq" OWNED BY "PERSONAS"."ID";


--
-- TOC entry 177 (class 1259 OID 18933)
-- Name: AFILIADO_PERFIL; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "AFILIADO_PERFIL" (
    "ID" integer NOT NULL,
    "ID_PERSONA" integer,
    "CARGO_GREMIAL" boolean,
    "INHIBIDO" boolean,
    "JUBILADO" boolean,
    "NO_APUNAM" boolean,
    "F_INGRESO" date,
    "F_EGRESO" date,
    "AFILIADO" boolean,
    "ID_SEDE" integer
);


ALTER TABLE public."AFILIADO_PERFIL" OWNER TO postgres;

--
-- TOC entry 176 (class 1259 OID 18931)
-- Name: AFILIADO_PERFIL_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "AFILIADO_PERFIL_ID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."AFILIADO_PERFIL_ID_seq" OWNER TO postgres;

--
-- TOC entry 2298 (class 0 OID 0)
-- Dependencies: 176
-- Name: AFILIADO_PERFIL_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "AFILIADO_PERFIL_ID_seq" OWNED BY "AFILIADO_PERFIL"."ID";


--
-- TOC entry 165 (class 1259 OID 18869)
-- Name: CHEQUES; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "CHEQUES" (
    "ID" integer NOT NULL,
    "NRO" character varying,
    "BANCO" character varying,
    "OBSERVACION" character varying,
    "MONTO" integer,
    "F_EMISION" date,
    "F_COBRO" date
);


ALTER TABLE public."CHEQUES" OWNER TO postgres;

--
-- TOC entry 167 (class 1259 OID 18886)
-- Name: CHEQUES_AFILIADO; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "CHEQUES_AFILIADO" (
    "ID" integer NOT NULL,
    "ID_AFILIADO" integer NOT NULL,
    "ID_CHEQUE" integer NOT NULL
);


ALTER TABLE public."CHEQUES_AFILIADO" OWNER TO postgres;

--
-- TOC entry 164 (class 1259 OID 18867)
-- Name: CHEQUES_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "CHEQUES_ID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."CHEQUES_ID_seq" OWNER TO postgres;

--
-- TOC entry 2299 (class 0 OID 0)
-- Dependencies: 164
-- Name: CHEQUES_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "CHEQUES_ID_seq" OWNED BY "CHEQUES"."ID";


--
-- TOC entry 169 (class 1259 OID 18894)
-- Name: CHEQUES_PROVEEDOR; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "CHEQUES_PROVEEDOR" (
    "ID" integer NOT NULL,
    "ID_PROVEEDOR" integer NOT NULL,
    "ID_CHEQUE" integer NOT NULL
);


ALTER TABLE public."CHEQUES_PROVEEDOR" OWNER TO postgres;

--
-- TOC entry 166 (class 1259 OID 18884)
-- Name: CHEQUE_AFILIADO_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "CHEQUE_AFILIADO_ID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."CHEQUE_AFILIADO_ID_seq" OWNER TO postgres;

--
-- TOC entry 2300 (class 0 OID 0)
-- Dependencies: 166
-- Name: CHEQUE_AFILIADO_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "CHEQUE_AFILIADO_ID_seq" OWNED BY "CHEQUES_AFILIADO"."ID";


--
-- TOC entry 168 (class 1259 OID 18892)
-- Name: CHEQUE_PROVEEDOR_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "CHEQUE_PROVEEDOR_ID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."CHEQUE_PROVEEDOR_ID_seq" OWNER TO postgres;

--
-- TOC entry 2301 (class 0 OID 0)
-- Dependencies: 168
-- Name: CHEQUE_PROVEEDOR_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "CHEQUE_PROVEEDOR_ID_seq" OWNED BY "CHEQUES_PROVEEDOR"."ID";


--
-- TOC entry 185 (class 1259 OID 19123)
-- Name: CONCILIACION; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "CONCILIACION" (
    "ID" bigint NOT NULL,
    "ID_PERIODO" smallint,
    "NUM_LEGAJO" integer,
    "NUM_LIQUIDACION" integer,
    "APELLIDO" character varying,
    "NOMBRE" character varying,
    "TIPO_DOC" character varying,
    "NUM_DOC" integer,
    "MONTO" numeric(9,2),
    "CONCEPTO" smallint,
    "ID_AFILIADO" integer
);


ALTER TABLE public."CONCILIACION" OWNER TO postgres;

--
-- TOC entry 184 (class 1259 OID 19121)
-- Name: CONCILIACION_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "CONCILIACION_ID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."CONCILIACION_ID_seq" OWNER TO postgres;

--
-- TOC entry 2302 (class 0 OID 0)
-- Dependencies: 184
-- Name: CONCILIACION_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "CONCILIACION_ID_seq" OWNED BY "CONCILIACION"."ID";


--
-- TOC entry 173 (class 1259 OID 18910)
-- Name: CONVENIOS; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "CONVENIOS" (
    "ID" integer NOT NULL,
    "TITULO" character varying,
    "OBSERVACION" character varying,
    "ESTADO" boolean,
    "DESC_PORC" numeric(24,2),
    "DESC_FIJO" numeric(24,2),
    "ES_DESC_PORC" boolean
);


ALTER TABLE public."CONVENIOS" OWNER TO postgres;

--
-- TOC entry 172 (class 1259 OID 18908)
-- Name: CONVENIOS_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "CONVENIOS_ID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."CONVENIOS_ID_seq" OWNER TO postgres;

--
-- TOC entry 2303 (class 0 OID 0)
-- Dependencies: 172
-- Name: CONVENIOS_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "CONVENIOS_ID_seq" OWNED BY "CONVENIOS"."ID";


--
-- TOC entry 191 (class 1259 OID 19172)
-- Name: CONV_PROVEEDOR; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "CONV_PROVEEDOR" (
    "ID" integer NOT NULL,
    "ID_CONVENIIO" integer,
    "ID_PROVEEDOR" integer,
    "F_VIGENCIA" date,
    "F_BAJA" date,
    "DOCUMENTO" character varying
);


ALTER TABLE public."CONV_PROVEEDOR" OWNER TO postgres;

--
-- TOC entry 190 (class 1259 OID 19170)
-- Name: CONV_PROVEEDOR_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "CONV_PROVEEDOR_ID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."CONV_PROVEEDOR_ID_seq" OWNER TO postgres;

--
-- TOC entry 2304 (class 0 OID 0)
-- Dependencies: 190
-- Name: CONV_PROVEEDOR_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "CONV_PROVEEDOR_ID_seq" OWNED BY "CONV_PROVEEDOR"."ID";


--
-- TOC entry 179 (class 1259 OID 19043)
-- Name: CUENTA; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "CUENTA" (
    "ID" integer NOT NULL,
    "ID_PROVEEDOR" integer NOT NULL,
    "TIPO" character varying NOT NULL,
    "NRO" character varying NOT NULL,
    "CBU" integer,
    "BANCO" character varying NOT NULL
);


ALTER TABLE public."CUENTA" OWNER TO postgres;

--
-- TOC entry 189 (class 1259 OID 19161)
-- Name: CUENTAS; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "CUENTAS" (
    "ID" integer NOT NULL,
    "NOMBRE" character varying,
    "DESCRIPCION" character varying,
    "FECHA_SALDO" date,
    "SALDO" numeric(18,2)
);


ALTER TABLE public."CUENTAS" OWNER TO postgres;

--
-- TOC entry 188 (class 1259 OID 19159)
-- Name: CUENTAS_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "CUENTAS_ID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."CUENTAS_ID_seq" OWNER TO postgres;

--
-- TOC entry 2305 (class 0 OID 0)
-- Dependencies: 188
-- Name: CUENTAS_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "CUENTAS_ID_seq" OWNED BY "CUENTAS"."ID";


--
-- TOC entry 178 (class 1259 OID 19041)
-- Name: CUENTA_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "CUENTA_ID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."CUENTA_ID_seq" OWNER TO postgres;

--
-- TOC entry 2306 (class 0 OID 0)
-- Dependencies: 178
-- Name: CUENTA_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "CUENTA_ID_seq" OWNED BY "CUENTA"."ID";


--
-- TOC entry 161 (class 1259 OID 18851)
-- Name: LOCALIDADES; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "LOCALIDADES" (
    "ID" integer NOT NULL,
    "NOMBRE" character varying,
    "ID_PROVINCIA" integer
);


ALTER TABLE public."LOCALIDADES" OWNER TO postgres;

--
-- TOC entry 160 (class 1259 OID 18849)
-- Name: LOCALIDAD_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "LOCALIDAD_ID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."LOCALIDAD_ID_seq" OWNER TO postgres;

--
-- TOC entry 2307 (class 0 OID 0)
-- Dependencies: 160
-- Name: LOCALIDAD_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "LOCALIDAD_ID_seq" OWNED BY "LOCALIDADES"."ID";


--
-- TOC entry 187 (class 1259 OID 19145)
-- Name: PERIODO; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "PERIODO" (
    "ID" integer NOT NULL,
    "PERIODO" date,
    "DESCRIPCION" character varying,
    "OBSERVACION" character varying
);


ALTER TABLE public."PERIODO" OWNER TO postgres;

--
-- TOC entry 186 (class 1259 OID 19143)
-- Name: PERIODO_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "PERIODO_ID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."PERIODO_ID_seq" OWNER TO postgres;

--
-- TOC entry 2308 (class 0 OID 0)
-- Dependencies: 186
-- Name: PERIODO_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "PERIODO_ID_seq" OWNED BY "PERIODO"."ID";


--
-- TOC entry 180 (class 1259 OID 19068)
-- Name: PLANES_EMISION; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "PLANES_EMISION" (
    "ID" integer NOT NULL,
    "ID_AFILIADO" integer NOT NULL,
    "ID_PROVEEDOR" integer,
    "TIPO" smallint,
    "I_TOTAL" numeric(10,2),
    "CUOTAS" smallint,
    "CANT_VALES" smallint,
    "F_DESCUENTO" date,
    "ACTIVO" boolean,
    "OBSERVACION" character varying,
    "ID_TIPO_PLAN" smallint
);


ALTER TABLE public."PLANES_EMISION" OWNER TO postgres;

--
-- TOC entry 181 (class 1259 OID 19087)
-- Name: PLANES_EMISION_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "PLANES_EMISION_ID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."PLANES_EMISION_ID_seq" OWNER TO postgres;

--
-- TOC entry 2309 (class 0 OID 0)
-- Dependencies: 181
-- Name: PLANES_EMISION_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "PLANES_EMISION_ID_seq" OWNED BY "PLANES_EMISION"."ID";


--
-- TOC entry 159 (class 1259 OID 18793)
-- Name: PROVEEDORES; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "PROVEEDORES" (
    "ID" integer NOT NULL,
    "CODIGO" integer,
    "RAZON_SOCIAL" character varying,
    "DOMICILIO" character varying,
    "LOCALIDAD" smallint,
    "PROVINCIA" smallint,
    "TEL_NUM" integer,
    "TEL_AREA" smallint,
    "CEL_NUM" integer,
    "CEL_AREA" smallint,
    "CUIT" integer,
    "ESTADO" boolean
);


ALTER TABLE public."PROVEEDORES" OWNER TO postgres;

--
-- TOC entry 158 (class 1259 OID 18791)
-- Name: PROVEEDOR_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "PROVEEDOR_ID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."PROVEEDOR_ID_seq" OWNER TO postgres;

--
-- TOC entry 2310 (class 0 OID 0)
-- Dependencies: 158
-- Name: PROVEEDOR_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "PROVEEDOR_ID_seq" OWNED BY "PROVEEDORES"."ID";


--
-- TOC entry 163 (class 1259 OID 18860)
-- Name: PROVINCIAS; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "PROVINCIAS" (
    "ID" integer NOT NULL,
    "NOMBRE" character varying
);


ALTER TABLE public."PROVINCIAS" OWNER TO postgres;

--
-- TOC entry 162 (class 1259 OID 18858)
-- Name: PROVINCIA_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "PROVINCIA_ID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."PROVINCIA_ID_seq" OWNER TO postgres;

--
-- TOC entry 2311 (class 0 OID 0)
-- Dependencies: 162
-- Name: PROVINCIA_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "PROVINCIA_ID_seq" OWNED BY "PROVINCIAS"."ID";


--
-- TOC entry 193 (class 1259 OID 19183)
-- Name: REGLAS; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "REGLAS" (
    "ID" integer NOT NULL,
    "ES_FUNCIONARIO" boolean,
    "F_VIGENCIA" date,
    "F_BAJA" date,
    "REGLA" numeric(24,2)
);


ALTER TABLE public."REGLAS" OWNER TO postgres;

--
-- TOC entry 192 (class 1259 OID 19181)
-- Name: REGLAS_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "REGLAS_ID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."REGLAS_ID_seq" OWNER TO postgres;

--
-- TOC entry 2312 (class 0 OID 0)
-- Dependencies: 192
-- Name: REGLAS_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "REGLAS_ID_seq" OWNED BY "REGLAS"."ID";


--
-- TOC entry 175 (class 1259 OID 18921)
-- Name: SEDES; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "SEDES" (
    "ID" integer NOT NULL,
    "NOMBRE" character varying
);


ALTER TABLE public."SEDES" OWNER TO postgres;

--
-- TOC entry 174 (class 1259 OID 18919)
-- Name: SEDE_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "SEDE_ID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."SEDE_ID_seq" OWNER TO postgres;

--
-- TOC entry 2313 (class 0 OID 0)
-- Dependencies: 174
-- Name: SEDE_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "SEDE_ID_seq" OWNED BY "SEDES"."ID";


--
-- TOC entry 183 (class 1259 OID 19107)
-- Name: TIPO_PLAN; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "TIPO_PLAN" (
    "ID" integer NOT NULL,
    "TIPO" character varying,
    "DESCRIPCION" character varying
);


ALTER TABLE public."TIPO_PLAN" OWNER TO postgres;

--
-- TOC entry 182 (class 1259 OID 19105)
-- Name: TIPO_PLAN_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "TIPO_PLAN_ID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."TIPO_PLAN_ID_seq" OWNER TO postgres;

--
-- TOC entry 2314 (class 0 OID 0)
-- Dependencies: 182
-- Name: TIPO_PLAN_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "TIPO_PLAN_ID_seq" OWNED BY "TIPO_PLAN"."ID";


--
-- TOC entry 171 (class 1259 OID 18900)
-- Name: VALES; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "VALES" (
    "ID" integer NOT NULL,
    "ID_PLAN_EMISION" integer NOT NULL,
    "NRO_CUOTA" smallint,
    "CANT_CUOTA" smallint,
    "MONTO_CUOTA" numeric(10,2),
    "PAGADO" boolean,
    "F_COBRO" date,
    "F_PAGO" date,
    "F_CONCILIACION" date,
    "ID_CONCILIACION" bigint
);


ALTER TABLE public."VALES" OWNER TO postgres;

--
-- TOC entry 170 (class 1259 OID 18898)
-- Name: VALES_ID_seq1; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "VALES_ID_seq1"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."VALES_ID_seq1" OWNER TO postgres;

--
-- TOC entry 2315 (class 0 OID 0)
-- Dependencies: 170
-- Name: VALES_ID_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "VALES_ID_seq1" OWNED BY "VALES"."ID";


--
-- TOC entry 194 (class 1259 OID 19925)
-- Name: provincias; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE provincias (
    id integer DEFAULT nextval('"PROVINCIA_ID_seq"'::regclass) NOT NULL,
    nombre character varying
);


ALTER TABLE public.provincias OWNER TO postgres;

SET search_path = apunam, pg_catalog;

--
-- TOC entry 1980 (class 2604 OID 20237)
-- Name: id; Type: DEFAULT; Schema: apunam; Owner: postgres
--

ALTER TABLE ONLY afiliado_perfil ALTER COLUMN id SET DEFAULT nextval('afiliado_perfil_id_seq'::regclass);


--
-- TOC entry 1981 (class 2604 OID 20241)
-- Name: id; Type: DEFAULT; Schema: apunam; Owner: postgres
--

ALTER TABLE ONLY cheques ALTER COLUMN id SET DEFAULT nextval('cheques_id_seq'::regclass);


--
-- TOC entry 1982 (class 2604 OID 20248)
-- Name: id; Type: DEFAULT; Schema: apunam; Owner: postgres
--

ALTER TABLE ONLY cheques_afiliado ALTER COLUMN id SET DEFAULT nextval('cheque_afiliado_id_seq'::regclass);


--
-- TOC entry 1983 (class 2604 OID 20252)
-- Name: id; Type: DEFAULT; Schema: apunam; Owner: postgres
--

ALTER TABLE ONLY cheques_proveedor ALTER COLUMN id SET DEFAULT nextval('cheque_proveedor_id_seq'::regclass);


--
-- TOC entry 1984 (class 2604 OID 20256)
-- Name: id; Type: DEFAULT; Schema: apunam; Owner: postgres
--

ALTER TABLE ONLY conciliacion ALTER COLUMN id SET DEFAULT nextval('conciliacion_id_seq'::regclass);


--
-- TOC entry 1985 (class 2604 OID 20263)
-- Name: id; Type: DEFAULT; Schema: apunam; Owner: postgres
--

ALTER TABLE ONLY conv_proveedor ALTER COLUMN id SET DEFAULT nextval('conv_proveedor_id_seq'::regclass);


--
-- TOC entry 1986 (class 2604 OID 20270)
-- Name: id; Type: DEFAULT; Schema: apunam; Owner: postgres
--

ALTER TABLE ONLY convenios ALTER COLUMN id SET DEFAULT nextval('convenios_id_seq'::regclass);


--
-- TOC entry 1987 (class 2604 OID 20277)
-- Name: id; Type: DEFAULT; Schema: apunam; Owner: postgres
--

ALTER TABLE ONLY cuenta ALTER COLUMN id SET DEFAULT nextval('cuenta_id_seq'::regclass);


--
-- TOC entry 1988 (class 2604 OID 20284)
-- Name: id; Type: DEFAULT; Schema: apunam; Owner: postgres
--

ALTER TABLE ONLY cuentas ALTER COLUMN id SET DEFAULT nextval('cuentas_id_seq'::regclass);


--
-- TOC entry 1989 (class 2604 OID 20291)
-- Name: id; Type: DEFAULT; Schema: apunam; Owner: postgres
--

ALTER TABLE ONLY localidades ALTER COLUMN id SET DEFAULT nextval('localidad_id_seq'::regclass);


--
-- TOC entry 1990 (class 2604 OID 20298)
-- Name: id; Type: DEFAULT; Schema: apunam; Owner: postgres
--

ALTER TABLE ONLY periodo ALTER COLUMN id SET DEFAULT nextval('periodo_id_seq'::regclass);


--
-- TOC entry 1992 (class 2604 OID 20312)
-- Name: id; Type: DEFAULT; Schema: apunam; Owner: postgres
--

ALTER TABLE ONLY planes_emision ALTER COLUMN id SET DEFAULT nextval('planes_emision_id_seq'::regclass);


--
-- TOC entry 1993 (class 2604 OID 20319)
-- Name: id; Type: DEFAULT; Schema: apunam; Owner: postgres
--

ALTER TABLE ONLY proveedores ALTER COLUMN id SET DEFAULT nextval('proveedor_id_seq'::regclass);


--
-- TOC entry 1994 (class 2604 OID 20333)
-- Name: id; Type: DEFAULT; Schema: apunam; Owner: postgres
--

ALTER TABLE ONLY provincias ALTER COLUMN id SET DEFAULT nextval('provincia_id_seq'::regclass);


--
-- TOC entry 1995 (class 2604 OID 20340)
-- Name: id; Type: DEFAULT; Schema: apunam; Owner: postgres
--

ALTER TABLE ONLY reglas ALTER COLUMN id SET DEFAULT nextval('reglas_id_seq'::regclass);


--
-- TOC entry 1996 (class 2604 OID 20344)
-- Name: id; Type: DEFAULT; Schema: apunam; Owner: postgres
--

ALTER TABLE ONLY sedes ALTER COLUMN id SET DEFAULT nextval('sede_id_seq'::regclass);


--
-- TOC entry 1997 (class 2604 OID 20351)
-- Name: id; Type: DEFAULT; Schema: apunam; Owner: postgres
--

ALTER TABLE ONLY tipo_plan ALTER COLUMN id SET DEFAULT nextval('tipo_plan_id_seq'::regclass);


--
-- TOC entry 1998 (class 2604 OID 20358)
-- Name: id; Type: DEFAULT; Schema: apunam; Owner: postgres
--

ALTER TABLE ONLY vales ALTER COLUMN id SET DEFAULT nextval('vales_id_seq1'::regclass);


SET search_path = public, pg_catalog;

--
-- TOC entry 1970 (class 2604 OID 18936)
-- Name: ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "AFILIADO_PERFIL" ALTER COLUMN "ID" SET DEFAULT nextval('"AFILIADO_PERFIL_ID_seq"'::regclass);


--
-- TOC entry 1964 (class 2604 OID 18872)
-- Name: ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "CHEQUES" ALTER COLUMN "ID" SET DEFAULT nextval('"CHEQUES_ID_seq"'::regclass);


--
-- TOC entry 1965 (class 2604 OID 18889)
-- Name: ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "CHEQUES_AFILIADO" ALTER COLUMN "ID" SET DEFAULT nextval('"CHEQUE_AFILIADO_ID_seq"'::regclass);


--
-- TOC entry 1966 (class 2604 OID 18897)
-- Name: ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "CHEQUES_PROVEEDOR" ALTER COLUMN "ID" SET DEFAULT nextval('"CHEQUE_PROVEEDOR_ID_seq"'::regclass);


--
-- TOC entry 1974 (class 2604 OID 19126)
-- Name: ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "CONCILIACION" ALTER COLUMN "ID" SET DEFAULT nextval('"CONCILIACION_ID_seq"'::regclass);


--
-- TOC entry 1968 (class 2604 OID 18913)
-- Name: ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "CONVENIOS" ALTER COLUMN "ID" SET DEFAULT nextval('"CONVENIOS_ID_seq"'::regclass);


--
-- TOC entry 1977 (class 2604 OID 19175)
-- Name: ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "CONV_PROVEEDOR" ALTER COLUMN "ID" SET DEFAULT nextval('"CONV_PROVEEDOR_ID_seq"'::regclass);


--
-- TOC entry 1971 (class 2604 OID 19046)
-- Name: ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "CUENTA" ALTER COLUMN "ID" SET DEFAULT nextval('"CUENTA_ID_seq"'::regclass);


--
-- TOC entry 1976 (class 2604 OID 19164)
-- Name: ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "CUENTAS" ALTER COLUMN "ID" SET DEFAULT nextval('"CUENTAS_ID_seq"'::regclass);


--
-- TOC entry 1962 (class 2604 OID 18854)
-- Name: ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "LOCALIDADES" ALTER COLUMN "ID" SET DEFAULT nextval('"LOCALIDAD_ID_seq"'::regclass);


--
-- TOC entry 1975 (class 2604 OID 19148)
-- Name: ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PERIODO" ALTER COLUMN "ID" SET DEFAULT nextval('"PERIODO_ID_seq"'::regclass);


--
-- TOC entry 1972 (class 2604 OID 19089)
-- Name: ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PLANES_EMISION" ALTER COLUMN "ID" SET DEFAULT nextval('"PLANES_EMISION_ID_seq"'::regclass);


--
-- TOC entry 1961 (class 2604 OID 18796)
-- Name: ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PROVEEDORES" ALTER COLUMN "ID" SET DEFAULT nextval('"PROVEEDOR_ID_seq"'::regclass);


--
-- TOC entry 1963 (class 2604 OID 18863)
-- Name: ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PROVINCIAS" ALTER COLUMN "ID" SET DEFAULT nextval('"PROVINCIA_ID_seq"'::regclass);


--
-- TOC entry 1978 (class 2604 OID 19186)
-- Name: ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "REGLAS" ALTER COLUMN "ID" SET DEFAULT nextval('"REGLAS_ID_seq"'::regclass);


--
-- TOC entry 1969 (class 2604 OID 18924)
-- Name: ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "SEDES" ALTER COLUMN "ID" SET DEFAULT nextval('"SEDE_ID_seq"'::regclass);


--
-- TOC entry 1973 (class 2604 OID 19110)
-- Name: ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "TIPO_PLAN" ALTER COLUMN "ID" SET DEFAULT nextval('"TIPO_PLAN_ID_seq"'::regclass);


--
-- TOC entry 1967 (class 2604 OID 18903)
-- Name: ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "VALES" ALTER COLUMN "ID" SET DEFAULT nextval('"VALES_ID_seq1"'::regclass);


SET search_path = apunam, pg_catalog;

--
-- TOC entry 2316 (class 0 OID 0)
-- Dependencies: 195
-- Name: afiliado_id_seq; Type: SEQUENCE SET; Schema: apunam; Owner: postgres
--

SELECT pg_catalog.setval('afiliado_id_seq', 1, false);


--
-- TOC entry 2253 (class 0 OID 20234)
-- Dependencies: 214
-- Data for Name: afiliado_perfil; Type: TABLE DATA; Schema: apunam; Owner: postgres
--



--
-- TOC entry 2317 (class 0 OID 0)
-- Dependencies: 196
-- Name: afiliado_perfil_id_seq; Type: SEQUENCE SET; Schema: apunam; Owner: postgres
--

SELECT pg_catalog.setval('afiliado_perfil_id_seq', 1, false);


--
-- TOC entry 2318 (class 0 OID 0)
-- Dependencies: 197
-- Name: cheque_afiliado_id_seq; Type: SEQUENCE SET; Schema: apunam; Owner: postgres
--

SELECT pg_catalog.setval('cheque_afiliado_id_seq', 1, false);


--
-- TOC entry 2319 (class 0 OID 0)
-- Dependencies: 198
-- Name: cheque_proveedor_id_seq; Type: SEQUENCE SET; Schema: apunam; Owner: postgres
--

SELECT pg_catalog.setval('cheque_proveedor_id_seq', 1, false);


--
-- TOC entry 2254 (class 0 OID 20238)
-- Dependencies: 215
-- Data for Name: cheques; Type: TABLE DATA; Schema: apunam; Owner: postgres
--



--
-- TOC entry 2255 (class 0 OID 20245)
-- Dependencies: 216
-- Data for Name: cheques_afiliado; Type: TABLE DATA; Schema: apunam; Owner: postgres
--



--
-- TOC entry 2320 (class 0 OID 0)
-- Dependencies: 199
-- Name: cheques_id_seq; Type: SEQUENCE SET; Schema: apunam; Owner: postgres
--

SELECT pg_catalog.setval('cheques_id_seq', 1, false);


--
-- TOC entry 2256 (class 0 OID 20249)
-- Dependencies: 217
-- Data for Name: cheques_proveedor; Type: TABLE DATA; Schema: apunam; Owner: postgres
--



--
-- TOC entry 2257 (class 0 OID 20253)
-- Dependencies: 218
-- Data for Name: conciliacion; Type: TABLE DATA; Schema: apunam; Owner: postgres
--



--
-- TOC entry 2321 (class 0 OID 0)
-- Dependencies: 200
-- Name: conciliacion_id_seq; Type: SEQUENCE SET; Schema: apunam; Owner: postgres
--

SELECT pg_catalog.setval('conciliacion_id_seq', 1, false);


--
-- TOC entry 2258 (class 0 OID 20260)
-- Dependencies: 219
-- Data for Name: conv_proveedor; Type: TABLE DATA; Schema: apunam; Owner: postgres
--



--
-- TOC entry 2322 (class 0 OID 0)
-- Dependencies: 201
-- Name: conv_proveedor_id_seq; Type: SEQUENCE SET; Schema: apunam; Owner: postgres
--

SELECT pg_catalog.setval('conv_proveedor_id_seq', 1, false);


--
-- TOC entry 2259 (class 0 OID 20267)
-- Dependencies: 220
-- Data for Name: convenios; Type: TABLE DATA; Schema: apunam; Owner: postgres
--



--
-- TOC entry 2323 (class 0 OID 0)
-- Dependencies: 202
-- Name: convenios_id_seq; Type: SEQUENCE SET; Schema: apunam; Owner: postgres
--

SELECT pg_catalog.setval('convenios_id_seq', 1, false);


--
-- TOC entry 2260 (class 0 OID 20274)
-- Dependencies: 221
-- Data for Name: cuenta; Type: TABLE DATA; Schema: apunam; Owner: postgres
--



--
-- TOC entry 2324 (class 0 OID 0)
-- Dependencies: 203
-- Name: cuenta_id_seq; Type: SEQUENCE SET; Schema: apunam; Owner: postgres
--

SELECT pg_catalog.setval('cuenta_id_seq', 1, false);


--
-- TOC entry 2261 (class 0 OID 20281)
-- Dependencies: 222
-- Data for Name: cuentas; Type: TABLE DATA; Schema: apunam; Owner: postgres
--



--
-- TOC entry 2325 (class 0 OID 0)
-- Dependencies: 204
-- Name: cuentas_id_seq; Type: SEQUENCE SET; Schema: apunam; Owner: postgres
--

SELECT pg_catalog.setval('cuentas_id_seq', 1, false);


--
-- TOC entry 2326 (class 0 OID 0)
-- Dependencies: 205
-- Name: localidad_id_seq; Type: SEQUENCE SET; Schema: apunam; Owner: postgres
--

SELECT pg_catalog.setval('localidad_id_seq', 1, false);


--
-- TOC entry 2262 (class 0 OID 20288)
-- Dependencies: 223
-- Data for Name: localidades; Type: TABLE DATA; Schema: apunam; Owner: postgres
--



--
-- TOC entry 2263 (class 0 OID 20295)
-- Dependencies: 224
-- Data for Name: periodo; Type: TABLE DATA; Schema: apunam; Owner: postgres
--



--
-- TOC entry 2327 (class 0 OID 0)
-- Dependencies: 206
-- Name: periodo_id_seq; Type: SEQUENCE SET; Schema: apunam; Owner: postgres
--

SELECT pg_catalog.setval('periodo_id_seq', 1, false);


--
-- TOC entry 2264 (class 0 OID 20302)
-- Dependencies: 225
-- Data for Name: personas; Type: TABLE DATA; Schema: apunam; Owner: postgres
--



--
-- TOC entry 2265 (class 0 OID 20309)
-- Dependencies: 226
-- Data for Name: planes_emision; Type: TABLE DATA; Schema: apunam; Owner: postgres
--



--
-- TOC entry 2328 (class 0 OID 0)
-- Dependencies: 207
-- Name: planes_emision_id_seq; Type: SEQUENCE SET; Schema: apunam; Owner: postgres
--

SELECT pg_catalog.setval('planes_emision_id_seq', 1, false);


--
-- TOC entry 2329 (class 0 OID 0)
-- Dependencies: 208
-- Name: proveedor_id_seq; Type: SEQUENCE SET; Schema: apunam; Owner: postgres
--

SELECT pg_catalog.setval('proveedor_id_seq', 1, false);


--
-- TOC entry 2266 (class 0 OID 20316)
-- Dependencies: 227
-- Data for Name: proveedores; Type: TABLE DATA; Schema: apunam; Owner: postgres
--



--
-- TOC entry 2330 (class 0 OID 0)
-- Dependencies: 209
-- Name: provincia_id_seq; Type: SEQUENCE SET; Schema: apunam; Owner: postgres
--

SELECT pg_catalog.setval('provincia_id_seq', 8, true);


--
-- TOC entry 2267 (class 0 OID 20330)
-- Dependencies: 228
-- Data for Name: provincias; Type: TABLE DATA; Schema: apunam; Owner: postgres
--

INSERT INTO provincias (id, nombre) VALUES (1, 'misiones');
INSERT INTO provincias (id, nombre) VALUES (2, 'buenos aires');
INSERT INTO provincias (id, nombre) VALUES (6, 'catamarca');
INSERT INTO provincias (id, nombre) VALUES (7, 'catamarca');
INSERT INTO provincias (id, nombre) VALUES (8, 'catamarca');


--
-- TOC entry 2268 (class 0 OID 20337)
-- Dependencies: 229
-- Data for Name: reglas; Type: TABLE DATA; Schema: apunam; Owner: postgres
--



--
-- TOC entry 2331 (class 0 OID 0)
-- Dependencies: 210
-- Name: reglas_id_seq; Type: SEQUENCE SET; Schema: apunam; Owner: postgres
--

SELECT pg_catalog.setval('reglas_id_seq', 1, false);


--
-- TOC entry 2332 (class 0 OID 0)
-- Dependencies: 211
-- Name: sede_id_seq; Type: SEQUENCE SET; Schema: apunam; Owner: postgres
--

SELECT pg_catalog.setval('sede_id_seq', 1, false);


--
-- TOC entry 2269 (class 0 OID 20341)
-- Dependencies: 230
-- Data for Name: sedes; Type: TABLE DATA; Schema: apunam; Owner: postgres
--



--
-- TOC entry 2270 (class 0 OID 20348)
-- Dependencies: 231
-- Data for Name: tipo_plan; Type: TABLE DATA; Schema: apunam; Owner: postgres
--



--
-- TOC entry 2333 (class 0 OID 0)
-- Dependencies: 212
-- Name: tipo_plan_id_seq; Type: SEQUENCE SET; Schema: apunam; Owner: postgres
--

SELECT pg_catalog.setval('tipo_plan_id_seq', 1, false);


--
-- TOC entry 2271 (class 0 OID 20355)
-- Dependencies: 232
-- Data for Name: vales; Type: TABLE DATA; Schema: apunam; Owner: postgres
--



--
-- TOC entry 2334 (class 0 OID 0)
-- Dependencies: 213
-- Name: vales_id_seq1; Type: SEQUENCE SET; Schema: apunam; Owner: postgres
--

SELECT pg_catalog.setval('vales_id_seq1', 1, false);


SET search_path = public, pg_catalog;

--
-- TOC entry 2335 (class 0 OID 0)
-- Dependencies: 156
-- Name: AFILIADO_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"AFILIADO_ID_seq"', 1, false);


--
-- TOC entry 2216 (class 0 OID 18933)
-- Dependencies: 177
-- Data for Name: AFILIADO_PERFIL; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2336 (class 0 OID 0)
-- Dependencies: 176
-- Name: AFILIADO_PERFIL_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"AFILIADO_PERFIL_ID_seq"', 1, false);


--
-- TOC entry 2204 (class 0 OID 18869)
-- Dependencies: 165
-- Data for Name: CHEQUES; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2206 (class 0 OID 18886)
-- Dependencies: 167
-- Data for Name: CHEQUES_AFILIADO; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2337 (class 0 OID 0)
-- Dependencies: 164
-- Name: CHEQUES_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"CHEQUES_ID_seq"', 1, false);


--
-- TOC entry 2208 (class 0 OID 18894)
-- Dependencies: 169
-- Data for Name: CHEQUES_PROVEEDOR; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2338 (class 0 OID 0)
-- Dependencies: 166
-- Name: CHEQUE_AFILIADO_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"CHEQUE_AFILIADO_ID_seq"', 1, false);


--
-- TOC entry 2339 (class 0 OID 0)
-- Dependencies: 168
-- Name: CHEQUE_PROVEEDOR_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"CHEQUE_PROVEEDOR_ID_seq"', 1, false);


--
-- TOC entry 2224 (class 0 OID 19123)
-- Dependencies: 185
-- Data for Name: CONCILIACION; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2340 (class 0 OID 0)
-- Dependencies: 184
-- Name: CONCILIACION_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"CONCILIACION_ID_seq"', 1, false);


--
-- TOC entry 2212 (class 0 OID 18910)
-- Dependencies: 173
-- Data for Name: CONVENIOS; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2341 (class 0 OID 0)
-- Dependencies: 172
-- Name: CONVENIOS_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"CONVENIOS_ID_seq"', 1, false);


--
-- TOC entry 2230 (class 0 OID 19172)
-- Dependencies: 191
-- Data for Name: CONV_PROVEEDOR; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2342 (class 0 OID 0)
-- Dependencies: 190
-- Name: CONV_PROVEEDOR_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"CONV_PROVEEDOR_ID_seq"', 1, false);


--
-- TOC entry 2218 (class 0 OID 19043)
-- Dependencies: 179
-- Data for Name: CUENTA; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2228 (class 0 OID 19161)
-- Dependencies: 189
-- Data for Name: CUENTAS; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2343 (class 0 OID 0)
-- Dependencies: 188
-- Name: CUENTAS_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"CUENTAS_ID_seq"', 1, false);


--
-- TOC entry 2344 (class 0 OID 0)
-- Dependencies: 178
-- Name: CUENTA_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"CUENTA_ID_seq"', 1, false);


--
-- TOC entry 2200 (class 0 OID 18851)
-- Dependencies: 161
-- Data for Name: LOCALIDADES; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2345 (class 0 OID 0)
-- Dependencies: 160
-- Name: LOCALIDAD_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"LOCALIDAD_ID_seq"', 1, false);


--
-- TOC entry 2226 (class 0 OID 19145)
-- Dependencies: 187
-- Data for Name: PERIODO; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2346 (class 0 OID 0)
-- Dependencies: 186
-- Name: PERIODO_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"PERIODO_ID_seq"', 1, false);


--
-- TOC entry 2196 (class 0 OID 18783)
-- Dependencies: 157
-- Data for Name: PERSONAS; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2219 (class 0 OID 19068)
-- Dependencies: 180
-- Data for Name: PLANES_EMISION; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2347 (class 0 OID 0)
-- Dependencies: 181
-- Name: PLANES_EMISION_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"PLANES_EMISION_ID_seq"', 1, false);


--
-- TOC entry 2198 (class 0 OID 18793)
-- Dependencies: 159
-- Data for Name: PROVEEDORES; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2348 (class 0 OID 0)
-- Dependencies: 158
-- Name: PROVEEDOR_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"PROVEEDOR_ID_seq"', 1, false);


--
-- TOC entry 2202 (class 0 OID 18860)
-- Dependencies: 163
-- Data for Name: PROVINCIAS; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "PROVINCIAS" ("ID", "NOMBRE") VALUES (1, 'Misiones');
INSERT INTO "PROVINCIAS" ("ID", "NOMBRE") VALUES (2, 'Buenos Aires');


--
-- TOC entry 2349 (class 0 OID 0)
-- Dependencies: 162
-- Name: PROVINCIA_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"PROVINCIA_ID_seq"', 2, true);


--
-- TOC entry 2232 (class 0 OID 19183)
-- Dependencies: 193
-- Data for Name: REGLAS; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2350 (class 0 OID 0)
-- Dependencies: 192
-- Name: REGLAS_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"REGLAS_ID_seq"', 1, false);


--
-- TOC entry 2214 (class 0 OID 18921)
-- Dependencies: 175
-- Data for Name: SEDES; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2351 (class 0 OID 0)
-- Dependencies: 174
-- Name: SEDE_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"SEDE_ID_seq"', 1, false);


--
-- TOC entry 2222 (class 0 OID 19107)
-- Dependencies: 183
-- Data for Name: TIPO_PLAN; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2352 (class 0 OID 0)
-- Dependencies: 182
-- Name: TIPO_PLAN_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"TIPO_PLAN_ID_seq"', 1, false);


--
-- TOC entry 2210 (class 0 OID 18900)
-- Dependencies: 171
-- Data for Name: VALES; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2353 (class 0 OID 0)
-- Dependencies: 170
-- Name: VALES_ID_seq1; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"VALES_ID_seq1"', 1, false);


--
-- TOC entry 2233 (class 0 OID 19925)
-- Dependencies: 194
-- Data for Name: provincias; Type: TABLE DATA; Schema: public; Owner: postgres
--



SET search_path = apunam, pg_catalog;

--
-- TOC entry 2040 (class 2606 OID 20360)
-- Name: afiliado_perfil_pkey; Type: CONSTRAINT; Schema: apunam; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY afiliado_perfil
    ADD CONSTRAINT afiliado_perfil_pkey PRIMARY KEY (id);


--
-- TOC entry 2044 (class 2606 OID 20364)
-- Name: cheques_afiliado_pkey; Type: CONSTRAINT; Schema: apunam; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cheques_afiliado
    ADD CONSTRAINT cheques_afiliado_pkey PRIMARY KEY (id);


--
-- TOC entry 2042 (class 2606 OID 20362)
-- Name: cheques_pkey; Type: CONSTRAINT; Schema: apunam; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cheques
    ADD CONSTRAINT cheques_pkey PRIMARY KEY (id);


--
-- TOC entry 2046 (class 2606 OID 20366)
-- Name: cheques_proveedor_pkey; Type: CONSTRAINT; Schema: apunam; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cheques_proveedor
    ADD CONSTRAINT cheques_proveedor_pkey PRIMARY KEY (id);


--
-- TOC entry 2048 (class 2606 OID 20368)
-- Name: conciliacion_pkey; Type: CONSTRAINT; Schema: apunam; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY conciliacion
    ADD CONSTRAINT conciliacion_pkey PRIMARY KEY (id);


--
-- TOC entry 2050 (class 2606 OID 20370)
-- Name: conv_proveedor_pkey; Type: CONSTRAINT; Schema: apunam; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY conv_proveedor
    ADD CONSTRAINT conv_proveedor_pkey PRIMARY KEY (id);


--
-- TOC entry 2052 (class 2606 OID 20372)
-- Name: convenios_pkey; Type: CONSTRAINT; Schema: apunam; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY convenios
    ADD CONSTRAINT convenios_pkey PRIMARY KEY (id);


--
-- TOC entry 2054 (class 2606 OID 20374)
-- Name: cuenta_pkey; Type: CONSTRAINT; Schema: apunam; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cuenta
    ADD CONSTRAINT cuenta_pkey PRIMARY KEY (id);


--
-- TOC entry 2056 (class 2606 OID 20376)
-- Name: cuentas_pkey; Type: CONSTRAINT; Schema: apunam; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cuentas
    ADD CONSTRAINT cuentas_pkey PRIMARY KEY (id);


--
-- TOC entry 2058 (class 2606 OID 20378)
-- Name: localidades_pkey; Type: CONSTRAINT; Schema: apunam; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY localidades
    ADD CONSTRAINT localidades_pkey PRIMARY KEY (id);


--
-- TOC entry 2060 (class 2606 OID 20380)
-- Name: periodo_pkey; Type: CONSTRAINT; Schema: apunam; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY periodo
    ADD CONSTRAINT periodo_pkey PRIMARY KEY (id);


--
-- TOC entry 2062 (class 2606 OID 20382)
-- Name: personas_pkey; Type: CONSTRAINT; Schema: apunam; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY personas
    ADD CONSTRAINT personas_pkey PRIMARY KEY (id);


--
-- TOC entry 2064 (class 2606 OID 20384)
-- Name: planes_emision_pkey; Type: CONSTRAINT; Schema: apunam; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY planes_emision
    ADD CONSTRAINT planes_emision_pkey PRIMARY KEY (id);


--
-- TOC entry 2066 (class 2606 OID 20386)
-- Name: proveedores_pkey; Type: CONSTRAINT; Schema: apunam; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY proveedores
    ADD CONSTRAINT proveedores_pkey PRIMARY KEY (id);


--
-- TOC entry 2068 (class 2606 OID 20388)
-- Name: provincias_pkey; Type: CONSTRAINT; Schema: apunam; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY provincias
    ADD CONSTRAINT provincias_pkey PRIMARY KEY (id);


--
-- TOC entry 2070 (class 2606 OID 20390)
-- Name: reglas_pkey; Type: CONSTRAINT; Schema: apunam; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY reglas
    ADD CONSTRAINT reglas_pkey PRIMARY KEY (id);


--
-- TOC entry 2072 (class 2606 OID 20392)
-- Name: sedes_pkey; Type: CONSTRAINT; Schema: apunam; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY sedes
    ADD CONSTRAINT sedes_pkey PRIMARY KEY (id);


--
-- TOC entry 2074 (class 2606 OID 20394)
-- Name: tipo_plan_pkey; Type: CONSTRAINT; Schema: apunam; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tipo_plan
    ADD CONSTRAINT tipo_plan_pkey PRIMARY KEY (id);


--
-- TOC entry 2076 (class 2606 OID 20396)
-- Name: vales_pkey; Type: CONSTRAINT; Schema: apunam; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY vales
    ADD CONSTRAINT vales_pkey PRIMARY KEY (id);


SET search_path = public, pg_catalog;

--
-- TOC entry 2020 (class 2606 OID 18938)
-- Name: AFILIADO_PERFIL_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "AFILIADO_PERFIL"
    ADD CONSTRAINT "AFILIADO_PERFIL_pkey" PRIMARY KEY ("ID");


--
-- TOC entry 2000 (class 2606 OID 18820)
-- Name: AFILIADO_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "PERSONAS"
    ADD CONSTRAINT "AFILIADO_pkey" PRIMARY KEY ("ID");


--
-- TOC entry 2008 (class 2606 OID 18877)
-- Name: CHEQUES_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "CHEQUES"
    ADD CONSTRAINT "CHEQUES_pkey" PRIMARY KEY ("ID");


--
-- TOC entry 2010 (class 2606 OID 18891)
-- Name: CHEQUE_AFILIADO_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "CHEQUES_AFILIADO"
    ADD CONSTRAINT "CHEQUE_AFILIADO_pkey" PRIMARY KEY ("ID");


--
-- TOC entry 2012 (class 2606 OID 18907)
-- Name: CHEQUE_PROVEEDOR_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "CHEQUES_PROVEEDOR"
    ADD CONSTRAINT "CHEQUE_PROVEEDOR_pkey" PRIMARY KEY ("ID");


--
-- TOC entry 2028 (class 2606 OID 19137)
-- Name: CONCILIACION_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "CONCILIACION"
    ADD CONSTRAINT "CONCILIACION_pkey" PRIMARY KEY ("ID");


--
-- TOC entry 2016 (class 2606 OID 18918)
-- Name: CONVENIOS_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "CONVENIOS"
    ADD CONSTRAINT "CONVENIOS_pkey" PRIMARY KEY ("ID");


--
-- TOC entry 2034 (class 2606 OID 19177)
-- Name: CONV_PROVEEDOR_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "CONV_PROVEEDOR"
    ADD CONSTRAINT "CONV_PROVEEDOR_pkey" PRIMARY KEY ("ID");


--
-- TOC entry 2032 (class 2606 OID 19169)
-- Name: CUENTAS_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "CUENTAS"
    ADD CONSTRAINT "CUENTAS_pkey" PRIMARY KEY ("ID");


--
-- TOC entry 2022 (class 2606 OID 19056)
-- Name: CUENTA_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "CUENTA"
    ADD CONSTRAINT "CUENTA_pkey" PRIMARY KEY ("ID");


--
-- TOC entry 2004 (class 2606 OID 18879)
-- Name: LOCALIDAD_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "LOCALIDADES"
    ADD CONSTRAINT "LOCALIDAD_pkey" PRIMARY KEY ("ID");


--
-- TOC entry 2030 (class 2606 OID 19153)
-- Name: PERIODO_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "PERIODO"
    ADD CONSTRAINT "PERIODO_pkey" PRIMARY KEY ("ID");


--
-- TOC entry 2024 (class 2606 OID 19076)
-- Name: PLANES_EMISION_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "PLANES_EMISION"
    ADD CONSTRAINT "PLANES_EMISION_pkey" PRIMARY KEY ("ID");


--
-- TOC entry 2002 (class 2606 OID 18822)
-- Name: PROVEEDOR_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "PROVEEDORES"
    ADD CONSTRAINT "PROVEEDOR_pkey" PRIMARY KEY ("ID");


--
-- TOC entry 2006 (class 2606 OID 18881)
-- Name: PROVINCIA_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "PROVINCIAS"
    ADD CONSTRAINT "PROVINCIA_pkey" PRIMARY KEY ("ID");


--
-- TOC entry 2036 (class 2606 OID 19188)
-- Name: REGLAS_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "REGLAS"
    ADD CONSTRAINT "REGLAS_pkey" PRIMARY KEY ("ID");


--
-- TOC entry 2018 (class 2606 OID 18929)
-- Name: SEDE_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "SEDES"
    ADD CONSTRAINT "SEDE_pkey" PRIMARY KEY ("ID");


--
-- TOC entry 2026 (class 2606 OID 19115)
-- Name: TIPO_PLAN_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "TIPO_PLAN"
    ADD CONSTRAINT "TIPO_PLAN_pkey" PRIMARY KEY ("ID");


--
-- TOC entry 2014 (class 2606 OID 18905)
-- Name: VALES_pkey1; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "VALES"
    ADD CONSTRAINT "VALES_pkey1" PRIMARY KEY ("ID");


--
-- TOC entry 2038 (class 2606 OID 19933)
-- Name: provincias_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY provincias
    ADD CONSTRAINT provincias_pkey PRIMARY KEY (id);


SET search_path = apunam, pg_catalog;

--
-- TOC entry 2093 (class 2606 OID 20397)
-- Name: afiliado_perfil_id_sede_fkey; Type: FK CONSTRAINT; Schema: apunam; Owner: postgres
--

ALTER TABLE ONLY afiliado_perfil
    ADD CONSTRAINT afiliado_perfil_id_sede_fkey FOREIGN KEY (id_sede) REFERENCES sedes(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2095 (class 2606 OID 20407)
-- Name: cheques_afiliado_id_afiliado_fkey; Type: FK CONSTRAINT; Schema: apunam; Owner: postgres
--

ALTER TABLE ONLY cheques_afiliado
    ADD CONSTRAINT cheques_afiliado_id_afiliado_fkey FOREIGN KEY (id_afiliado) REFERENCES afiliado_perfil(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2094 (class 2606 OID 20402)
-- Name: cheques_afiliado_id_cheque_fkey; Type: FK CONSTRAINT; Schema: apunam; Owner: postgres
--

ALTER TABLE ONLY cheques_afiliado
    ADD CONSTRAINT cheques_afiliado_id_cheque_fkey FOREIGN KEY (id_cheque) REFERENCES cheques(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2097 (class 2606 OID 20417)
-- Name: cheques_proveedor_id_cheque_fkey; Type: FK CONSTRAINT; Schema: apunam; Owner: postgres
--

ALTER TABLE ONLY cheques_proveedor
    ADD CONSTRAINT cheques_proveedor_id_cheque_fkey FOREIGN KEY (id_cheque) REFERENCES cheques(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2096 (class 2606 OID 20412)
-- Name: cheques_proveedor_id_proveedor_fkey; Type: FK CONSTRAINT; Schema: apunam; Owner: postgres
--

ALTER TABLE ONLY cheques_proveedor
    ADD CONSTRAINT cheques_proveedor_id_proveedor_fkey FOREIGN KEY (id_proveedor) REFERENCES proveedores(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2099 (class 2606 OID 20427)
-- Name: conciliacion_id_afiliado_fkey; Type: FK CONSTRAINT; Schema: apunam; Owner: postgres
--

ALTER TABLE ONLY conciliacion
    ADD CONSTRAINT conciliacion_id_afiliado_fkey FOREIGN KEY (id_afiliado) REFERENCES afiliado_perfil(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2098 (class 2606 OID 20422)
-- Name: conciliacion_id_periodo_fkey; Type: FK CONSTRAINT; Schema: apunam; Owner: postgres
--

ALTER TABLE ONLY conciliacion
    ADD CONSTRAINT conciliacion_id_periodo_fkey FOREIGN KEY (id_periodo) REFERENCES periodo(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2100 (class 2606 OID 20432)
-- Name: conv_proveedor_id_conveniio_fkey; Type: FK CONSTRAINT; Schema: apunam; Owner: postgres
--

ALTER TABLE ONLY conv_proveedor
    ADD CONSTRAINT conv_proveedor_id_conveniio_fkey FOREIGN KEY (id_conveniio) REFERENCES convenios(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2101 (class 2606 OID 20437)
-- Name: conv_proveedor_id_proveedor_fkey; Type: FK CONSTRAINT; Schema: apunam; Owner: postgres
--

ALTER TABLE ONLY conv_proveedor
    ADD CONSTRAINT conv_proveedor_id_proveedor_fkey FOREIGN KEY (id_proveedor) REFERENCES proveedores(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2102 (class 2606 OID 20442)
-- Name: cuenta_id_proveedor_fkey; Type: FK CONSTRAINT; Schema: apunam; Owner: postgres
--

ALTER TABLE ONLY cuenta
    ADD CONSTRAINT cuenta_id_proveedor_fkey FOREIGN KEY (id_proveedor) REFERENCES proveedores(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2103 (class 2606 OID 20447)
-- Name: localidades_id_provincia_fkey; Type: FK CONSTRAINT; Schema: apunam; Owner: postgres
--

ALTER TABLE ONLY localidades
    ADD CONSTRAINT localidades_id_provincia_fkey FOREIGN KEY (id_provincia) REFERENCES provincias(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2106 (class 2606 OID 20462)
-- Name: planes_emision_id_afiliado_fkey; Type: FK CONSTRAINT; Schema: apunam; Owner: postgres
--

ALTER TABLE ONLY planes_emision
    ADD CONSTRAINT planes_emision_id_afiliado_fkey FOREIGN KEY (id_afiliado) REFERENCES afiliado_perfil(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2105 (class 2606 OID 20457)
-- Name: planes_emision_id_proveedor_fkey; Type: FK CONSTRAINT; Schema: apunam; Owner: postgres
--

ALTER TABLE ONLY planes_emision
    ADD CONSTRAINT planes_emision_id_proveedor_fkey FOREIGN KEY (id_proveedor) REFERENCES proveedores(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2104 (class 2606 OID 20452)
-- Name: planes_emision_id_tipo_plan_fkey; Type: FK CONSTRAINT; Schema: apunam; Owner: postgres
--

ALTER TABLE ONLY planes_emision
    ADD CONSTRAINT planes_emision_id_tipo_plan_fkey FOREIGN KEY (id_tipo_plan) REFERENCES tipo_plan(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2107 (class 2606 OID 20467)
-- Name: vales_id_conciliacion_fkey; Type: FK CONSTRAINT; Schema: apunam; Owner: postgres
--

ALTER TABLE ONLY vales
    ADD CONSTRAINT vales_id_conciliacion_fkey FOREIGN KEY (id_conciliacion) REFERENCES conciliacion(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2108 (class 2606 OID 20472)
-- Name: vales_id_plan_emision_fkey; Type: FK CONSTRAINT; Schema: apunam; Owner: postgres
--

ALTER TABLE ONLY vales
    ADD CONSTRAINT vales_id_plan_emision_fkey FOREIGN KEY (id_plan_emision) REFERENCES planes_emision(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


SET search_path = public, pg_catalog;

--
-- TOC entry 2089 (class 2606 OID 19131)
-- Name: FK_CONCILIACION_ID_AFILIADO; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "CONCILIACION"
    ADD CONSTRAINT "FK_CONCILIACION_ID_AFILIADO" FOREIGN KEY ("ID_AFILIADO") REFERENCES "AFILIADO_PERFIL"("ID") ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2090 (class 2606 OID 19154)
-- Name: FK_CONCILIACION_ID_PERIODO; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "CONCILIACION"
    ADD CONSTRAINT "FK_CONCILIACION_ID_PERIODO" FOREIGN KEY ("ID_PERIODO") REFERENCES "PERIODO"("ID") ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2078 (class 2606 OID 18986)
-- Name: FK_ID_AFIL; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "CHEQUES_AFILIADO"
    ADD CONSTRAINT "FK_ID_AFIL" FOREIGN KEY ("ID_AFILIADO") REFERENCES "AFILIADO_PERFIL"("ID") ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2079 (class 2606 OID 18991)
-- Name: FK_ID_CHEQUE; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "CHEQUES_AFILIADO"
    ADD CONSTRAINT "FK_ID_CHEQUE" FOREIGN KEY ("ID_CHEQUE") REFERENCES "CHEQUES"("ID") ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2081 (class 2606 OID 19026)
-- Name: FK_ID_CHEQUE2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "CHEQUES_PROVEEDOR"
    ADD CONSTRAINT "FK_ID_CHEQUE2" FOREIGN KEY ("ID_CHEQUE") REFERENCES "CHEQUES"("ID") ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2091 (class 2606 OID 19229)
-- Name: FK_ID_CONVENIOS; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "CONV_PROVEEDOR"
    ADD CONSTRAINT "FK_ID_CONVENIOS" FOREIGN KEY ("ID_CONVENIIO") REFERENCES "CONVENIOS"("ID") ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2082 (class 2606 OID 19100)
-- Name: FK_ID_PLANES_EMISION; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "VALES"
    ADD CONSTRAINT "FK_ID_PLANES_EMISION" FOREIGN KEY ("ID_PLAN_EMISION") REFERENCES "PLANES_EMISION"("ID") ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2080 (class 2606 OID 18996)
-- Name: FK_ID_PROV; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "CHEQUES_PROVEEDOR"
    ADD CONSTRAINT "FK_ID_PROV" FOREIGN KEY ("ID_PROVEEDOR") REFERENCES "PROVEEDORES"("ID") ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2092 (class 2606 OID 19234)
-- Name: FK_ID_PROV; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "CONV_PROVEEDOR"
    ADD CONSTRAINT "FK_ID_PROV" FOREIGN KEY ("ID_PROVEEDOR") REFERENCES "PROVEEDORES"("ID") ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2085 (class 2606 OID 19050)
-- Name: FK_ID_PROV_CUENTA; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "CUENTA"
    ADD CONSTRAINT "FK_ID_PROV_CUENTA" FOREIGN KEY ("ID_PROVEEDOR") REFERENCES "PROVEEDORES"("ID") ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2077 (class 2606 OID 19036)
-- Name: FK_ID_PROV_LOCA; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "LOCALIDADES"
    ADD CONSTRAINT "FK_ID_PROV_LOCA" FOREIGN KEY ("ID_PROVINCIA") REFERENCES "PROVINCIAS"("ID") ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2084 (class 2606 OID 18976)
-- Name: FK_ID_SEDE; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "AFILIADO_PERFIL"
    ADD CONSTRAINT "FK_ID_SEDE" FOREIGN KEY ("ID_SEDE") REFERENCES "SEDES"("ID") ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2083 (class 2606 OID 19138)
-- Name: FK_VALES_ID_CONCILIACION; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "VALES"
    ADD CONSTRAINT "FK_VALES_ID_CONCILIACION" FOREIGN KEY ("ID_CONCILIACION") REFERENCES "CONCILIACION"("ID") ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2086 (class 2606 OID 19077)
-- Name: PLANES_EMISION_ID_AFILIADO_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PLANES_EMISION"
    ADD CONSTRAINT "PLANES_EMISION_ID_AFILIADO_fkey" FOREIGN KEY ("ID_AFILIADO") REFERENCES "AFILIADO_PERFIL"("ID") ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2087 (class 2606 OID 19082)
-- Name: PLANES_EMISION_ID_PROVEEDOR_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PLANES_EMISION"
    ADD CONSTRAINT "PLANES_EMISION_ID_PROVEEDOR_fkey" FOREIGN KEY ("ID_PROVEEDOR") REFERENCES "PROVEEDORES"("ID") ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2088 (class 2606 OID 19116)
-- Name: PLANES_EMISION_ID_TIPO_PLAN; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PLANES_EMISION"
    ADD CONSTRAINT "PLANES_EMISION_ID_TIPO_PLAN" FOREIGN KEY ("ID_TIPO_PLAN") REFERENCES "TIPO_PLAN"("ID") ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2277 (class 0 OID 0)
-- Dependencies: 3
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2014-03-20 18:21:26

--
-- PostgreSQL database dump complete
--

