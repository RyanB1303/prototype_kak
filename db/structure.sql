SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: sasaran_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.sasaran_status AS ENUM (
    'draft',
    'pengajuan',
    'disetujui',
    'ditolak'
);


--
-- Name: usulan_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.usulan_status AS ENUM (
    'draft',
    'pengajuan',
    'disetujui',
    'ditolak',
    'menunggu_persetujuan',
    'aktif'
);


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: action_text_rich_texts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.action_text_rich_texts (
    id bigint NOT NULL,
    name character varying NOT NULL,
    body text,
    record_type character varying NOT NULL,
    record_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: action_text_rich_texts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.action_text_rich_texts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: action_text_rich_texts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.action_text_rich_texts_id_seq OWNED BY public.action_text_rich_texts.id;


--
-- Name: active_storage_attachments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.active_storage_attachments (
    id bigint NOT NULL,
    name character varying NOT NULL,
    record_type character varying NOT NULL,
    record_id bigint NOT NULL,
    blob_id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL
);


--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.active_storage_attachments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.active_storage_attachments_id_seq OWNED BY public.active_storage_attachments.id;


--
-- Name: active_storage_blobs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.active_storage_blobs (
    id bigint NOT NULL,
    key character varying NOT NULL,
    filename character varying NOT NULL,
    content_type character varying,
    metadata text,
    service_name character varying NOT NULL,
    byte_size bigint NOT NULL,
    checksum character varying NOT NULL,
    created_at timestamp without time zone NOT NULL
);


--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.active_storage_blobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.active_storage_blobs_id_seq OWNED BY public.active_storage_blobs.id;


--
-- Name: active_storage_variant_records; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.active_storage_variant_records (
    id bigint NOT NULL,
    blob_id bigint NOT NULL,
    variation_digest character varying NOT NULL
);


--
-- Name: active_storage_variant_records_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.active_storage_variant_records_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: active_storage_variant_records_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.active_storage_variant_records_id_seq OWNED BY public.active_storage_variant_records.id;


--
-- Name: aksis; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.aksis (
    id bigint NOT NULL,
    target integer,
    realisasi integer,
    bulan integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    tahapan_id bigint,
    id_rencana_aksi character varying,
    id_aksi_bulan character varying
);


--
-- Name: aksis_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.aksis_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: aksis_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.aksis_id_seq OWNED BY public.aksis.id;


--
-- Name: anggaran_bluds; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.anggaran_bluds (
    id bigint NOT NULL,
    kode_kelompok_barang character varying,
    uraian_kelompok_barang character varying,
    kode_barang character varying,
    uraian_barang character varying,
    spesifikasi character varying,
    satuan character varying,
    harga_satuan bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    tahun character varying
);


--
-- Name: anggaran_bluds_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.anggaran_bluds_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: anggaran_bluds_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.anggaran_bluds_id_seq OWNED BY public.anggaran_bluds.id;


--
-- Name: anggaran_hspk_umums; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.anggaran_hspk_umums (
    id bigint NOT NULL,
    kode_kelompok_barang character varying,
    uraian_kelompok_barang character varying,
    kode_barang character varying,
    uraian_barang character varying,
    spesifikasi character varying,
    satuan character varying,
    harga_satuan bigint,
    tahun character varying,
    id_standar_harga character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    hspk_id bigint
);


--
-- Name: anggaran_hspk_umums_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.anggaran_hspk_umums_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: anggaran_hspk_umums_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.anggaran_hspk_umums_id_seq OWNED BY public.anggaran_hspk_umums.id;


--
-- Name: anggaran_hspks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.anggaran_hspks (
    id bigint NOT NULL,
    kode_kelompok_barang character varying,
    uraian_kelompok_barang character varying,
    kode_barang character varying,
    uraian_barang character varying,
    spesifikasi character varying,
    satuan character varying,
    harga_satuan bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    tahun character varying,
    id_standar_harga character varying
);


--
-- Name: anggaran_hspks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.anggaran_hspks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: anggaran_hspks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.anggaran_hspks_id_seq OWNED BY public.anggaran_hspks.id;


--
-- Name: anggaran_sbus; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.anggaran_sbus (
    id bigint NOT NULL,
    kode_kelompok_barang character varying,
    uraian_kelompok_barang character varying,
    kode_barang character varying,
    uraian_barang character varying,
    spesifikasi character varying,
    satuan character varying,
    harga_satuan bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    tahun character varying,
    id_standar_harga character varying
);


--
-- Name: anggaran_sbus_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.anggaran_sbus_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: anggaran_sbus_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.anggaran_sbus_id_seq OWNED BY public.anggaran_sbus.id;


--
-- Name: anggaran_sshes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.anggaran_sshes (
    id bigint NOT NULL,
    kode_kelompok_barang character varying,
    uraian_kelompok_barang character varying,
    kode_barang character varying,
    uraian_barang character varying,
    spesifikasi character varying,
    satuan character varying,
    harga_satuan bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    tahun character varying,
    id_standar_harga character varying
);


--
-- Name: anggaran_sshes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.anggaran_sshes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: anggaran_sshes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.anggaran_sshes_id_seq OWNED BY public.anggaran_sshes.id;


--
-- Name: anggarans; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.anggarans (
    id bigint NOT NULL,
    kode_rek character varying,
    uraian text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    tahapan_id bigint,
    level integer DEFAULT 0,
    parent_id bigint,
    pajak_id bigint,
    set_input character varying DEFAULT '0'::character varying,
    tahun integer,
    jumlah numeric
);


--
-- Name: anggarans_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.anggarans_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: anggarans_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.anggarans_id_seq OWNED BY public.anggarans.id;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: background_migration_jobs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.background_migration_jobs (
    id bigint NOT NULL,
    migration_id bigint NOT NULL,
    min_value bigint NOT NULL,
    max_value bigint NOT NULL,
    batch_size integer NOT NULL,
    sub_batch_size integer NOT NULL,
    pause_ms integer NOT NULL,
    started_at timestamp without time zone,
    finished_at timestamp without time zone,
    status character varying DEFAULT 'enqueued'::character varying NOT NULL,
    max_attempts integer NOT NULL,
    attempts integer DEFAULT 0 NOT NULL,
    error_class character varying,
    error_message character varying,
    backtrace character varying[],
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: background_migration_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.background_migration_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: background_migration_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.background_migration_jobs_id_seq OWNED BY public.background_migration_jobs.id;


--
-- Name: background_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.background_migrations (
    id bigint NOT NULL,
    migration_name character varying NOT NULL,
    arguments jsonb DEFAULT '[]'::jsonb NOT NULL,
    batch_column_name character varying NOT NULL,
    min_value bigint NOT NULL,
    max_value bigint NOT NULL,
    rows_count bigint,
    batch_size integer NOT NULL,
    sub_batch_size integer NOT NULL,
    batch_pause integer NOT NULL,
    sub_batch_pause_ms integer NOT NULL,
    batch_max_attempts integer NOT NULL,
    status character varying DEFAULT 'enqueued'::character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: background_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.background_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: background_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.background_migrations_id_seq OWNED BY public.background_migrations.id;


--
-- Name: comments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.comments (
    id bigint NOT NULL,
    head text,
    body text NOT NULL,
    anggaran_id bigint NOT NULL,
    user_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: comments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.comments_id_seq OWNED BY public.comments.id;


--
-- Name: dasar_hukums; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.dasar_hukums (
    id bigint NOT NULL,
    peraturan text,
    judul character varying,
    tahun character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    sasaran_id character varying
);


--
-- Name: dasar_hukums_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.dasar_hukums_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: dasar_hukums_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.dasar_hukums_id_seq OWNED BY public.dasar_hukums.id;


--
-- Name: genders; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.genders (
    id bigint NOT NULL,
    akses character varying,
    partisipasi character varying,
    kontrol character varying,
    manfaat character varying,
    sasaran_id bigint,
    program_kegiatan_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    reformulasi_tujuan character varying,
    data_terpilah character varying,
    indikator character varying,
    target character varying,
    satuan character varying,
    penyebab_internal character varying,
    penyebab_external character varying,
    penerima_manfaat character varying,
    sasaran_subkegiatan character varying,
    tahun character varying,
    rencana_aksi character varying,
    rencana_aksi_id character varying
);


--
-- Name: genders_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.genders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: genders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.genders_id_seq OWNED BY public.genders.id;


--
-- Name: indikator_sasarans; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.indikator_sasarans (
    id bigint NOT NULL,
    indikator_kinerja character varying,
    target character varying,
    satuan character varying,
    aspek character varying,
    id_indikator character varying,
    sasaran_id character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    type character varying
);


--
-- Name: indikator_sasarans_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.indikator_sasarans_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: indikator_sasarans_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.indikator_sasarans_id_seq OWNED BY public.indikator_sasarans.id;


--
-- Name: indikators; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.indikators (
    id bigint NOT NULL,
    indikator character varying,
    target character varying,
    satuan character varying,
    tahun character varying,
    kode character varying,
    jenis character varying,
    sub_jenis character varying,
    pagu character varying DEFAULT '0'::character varying,
    kode_indikator character varying,
    version integer DEFAULT 0 NOT NULL,
    keterangan character varying,
    kotak integer DEFAULT 0 NOT NULL,
    kode_opd character varying
);


--
-- Name: indikators_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.indikators_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: indikators_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.indikators_id_seq OWNED BY public.indikators.id;


--
-- Name: inovasis; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.inovasis (
    id bigint NOT NULL,
    usulan character varying,
    manfaat character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    tahun character varying,
    opd character varying,
    nip_asn character varying,
    sasaran_id bigint,
    is_active boolean DEFAULT false,
    status public.usulan_status DEFAULT 'draft'::public.usulan_status,
    uraian character varying
);


--
-- Name: inovasis_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.inovasis_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: inovasis_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.inovasis_id_seq OWNED BY public.inovasis.id;


--
-- Name: kaks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.kaks (
    id bigint NOT NULL,
    dasar_hukum text[] DEFAULT '{}'::text[],
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    program_kegiatan_id bigint,
    gambaran_umum text,
    penerima_manfaat text,
    metode_pelaksanaan text,
    tahapan_pelaksanaan text,
    waktu_dibutuhkan text,
    biaya_diperlukan text
);


--
-- Name: kaks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.kaks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: kaks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.kaks_id_seq OWNED BY public.kaks.id;


--
-- Name: kamus_usulans; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.kamus_usulans (
    id bigint NOT NULL,
    id_kamus bigint NOT NULL,
    id_unit bigint,
    id_program bigint,
    bidang_urusan character varying,
    usulan character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: kamus_usulans_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.kamus_usulans_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: kamus_usulans_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.kamus_usulans_id_seq OWNED BY public.kamus_usulans.id;


--
-- Name: kelompok_anggarans; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.kelompok_anggarans (
    id bigint NOT NULL,
    kode_kelompok character varying,
    tahun character varying,
    kelompok character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: kelompok_anggarans_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.kelompok_anggarans_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: kelompok_anggarans_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.kelompok_anggarans_id_seq OWNED BY public.kelompok_anggarans.id;


--
-- Name: kesenjangans; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.kesenjangans (
    id bigint NOT NULL,
    rincian_id bigint NOT NULL,
    akses character varying,
    partisipasi character varying,
    kontrol character varying,
    manfaat character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: kesenjangans_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.kesenjangans_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: kesenjangans_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.kesenjangans_id_seq OWNED BY public.kesenjangans.id;


--
-- Name: koefisiens; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.koefisiens (
    id bigint NOT NULL,
    satuan_volume character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    perhitungan_id bigint,
    volume numeric
);


--
-- Name: koefisiens_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.koefisiens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: koefisiens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.koefisiens_id_seq OWNED BY public.koefisiens.id;


--
-- Name: latar_belakangs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.latar_belakangs (
    id bigint NOT NULL,
    dasar_hukum text,
    gambaran_umum text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    sasaran_id bigint,
    id_indikator_sasaran character varying,
    key_activities character varying
);


--
-- Name: latar_belakangs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.latar_belakangs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: latar_belakangs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.latar_belakangs_id_seq OWNED BY public.latar_belakangs.id;


--
-- Name: lembagas; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.lembagas (
    id bigint NOT NULL,
    nama_lembaga character varying,
    tahun character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    kode_lembaga character varying
);


--
-- Name: lembagas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.lembagas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: lembagas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.lembagas_id_seq OWNED BY public.lembagas.id;


--
-- Name: mandatoris; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.mandatoris (
    id bigint NOT NULL,
    usulan character varying,
    peraturan_terkait character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    tahun character varying,
    opd character varying,
    nip_asn character varying,
    sasaran_id bigint,
    is_active boolean DEFAULT false,
    status public.usulan_status DEFAULT 'draft'::public.usulan_status,
    uraian character varying
);


--
-- Name: mandatoris_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.mandatoris_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: mandatoris_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.mandatoris_id_seq OWNED BY public.mandatoris.id;


--
-- Name: master_bidang_urusans; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.master_bidang_urusans (
    id bigint NOT NULL,
    id_bidang_urusan_sipd character varying,
    id_urusan character varying,
    tahun character varying,
    kode_bidang_urusan character varying,
    nama_bidang_urusan character varying,
    id_unik_sipd character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: master_bidang_urusans_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.master_bidang_urusans_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: master_bidang_urusans_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.master_bidang_urusans_id_seq OWNED BY public.master_bidang_urusans.id;


--
-- Name: master_kegiatans; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.master_kegiatans (
    id bigint NOT NULL,
    id_kegiatan_sipd character varying,
    kode_giat character varying,
    tahun character varying DEFAULT '2022'::character varying,
    id_urusan character varying,
    id_bidang_urusan character varying,
    nama_giat character varying DEFAULT '-'::character varying,
    no_giat character varying,
    id_unik_sipd character varying NOT NULL,
    id_program character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: master_kegiatans_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.master_kegiatans_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: master_kegiatans_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.master_kegiatans_id_seq OWNED BY public.master_kegiatans.id;


--
-- Name: master_output_kegiatans; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.master_output_kegiatans (
    id bigint NOT NULL,
    id_output_bl character varying NOT NULL,
    id_bl character varying,
    id_skpd character varying,
    id_sub_skpd character varying,
    id_program character varying,
    id_kegiatan character varying,
    id_sub_kegiatan character varying,
    indikator_kegiatan character varying,
    target_kegiatan character varying,
    satuan_kegiatan character varying,
    indikator_sub_kegiatan character varying,
    target_sub_kegiatan character varying,
    satuan_sub_kegiatan character varying,
    tahun character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: master_output_kegiatans_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.master_output_kegiatans_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: master_output_kegiatans_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.master_output_kegiatans_id_seq OWNED BY public.master_output_kegiatans.id;


--
-- Name: master_programs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.master_programs (
    id bigint NOT NULL,
    id_program_sipd character varying,
    kode_program character varying,
    tahun character varying DEFAULT '2022'::character varying,
    id_urusan character varying,
    id_bidang_urusan character varying,
    nama_program character varying DEFAULT '-'::character varying,
    no_program character varying,
    id_unik_sipd character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: master_programs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.master_programs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: master_programs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.master_programs_id_seq OWNED BY public.master_programs.id;


--
-- Name: master_subkegiatans; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.master_subkegiatans (
    id bigint NOT NULL,
    id_sub_kegiatan_sipd character varying,
    kode_sub_kegiatan character varying,
    tahun character varying DEFAULT '2022'::character varying,
    id_urusan character varying,
    id_bidang_urusan character varying,
    nama_sub_kegiatan character varying DEFAULT '-'::character varying,
    no_sub_kegiatan character varying,
    id_unik_sipd character varying NOT NULL,
    id_program character varying,
    id_kegiatan character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: master_subkegiatans_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.master_subkegiatans_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: master_subkegiatans_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.master_subkegiatans_id_seq OWNED BY public.master_subkegiatans.id;


--
-- Name: master_urusans; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.master_urusans (
    id bigint NOT NULL,
    id_urusan_sipd character varying,
    id_unik_sipd character varying NOT NULL,
    tahun character varying,
    kode_urusan character varying,
    nama_urusan character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: master_urusans_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.master_urusans_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: master_urusans_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.master_urusans_id_seq OWNED BY public.master_urusans.id;


--
-- Name: musrenbangs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.musrenbangs (
    id bigint NOT NULL,
    usulan text,
    tahun character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    sasaran_id bigint,
    opd character varying,
    nip_asn character varying,
    alamat text,
    is_active boolean DEFAULT false,
    status public.usulan_status DEFAULT 'draft'::public.usulan_status,
    uraian character varying,
    id_unik bigint,
    id_kamus bigint
);


--
-- Name: musrenbangs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.musrenbangs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: musrenbangs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.musrenbangs_id_seq OWNED BY public.musrenbangs.id;


--
-- Name: opds; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.opds (
    id bigint NOT NULL,
    nama_opd character varying,
    kode_opd character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    lembaga_id integer,
    id_opd_skp integer,
    kode_unik_opd character varying,
    urusan character varying,
    bidang_urusan character varying,
    kode_urusan character varying,
    kode_bidang_urusan character varying,
    nama_kepala character varying,
    nip_kepala character varying,
    status_kepala character varying,
    tahun character varying,
    id_daerah character varying,
    pangkat_kepala character varying
);


--
-- Name: opds_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.opds_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: opds_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.opds_id_seq OWNED BY public.opds.id;


--
-- Name: pagus; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pagus (
    id bigint NOT NULL,
    item character varying,
    uang integer,
    tipe character varying,
    satuan character varying,
    volume integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    total integer
);


--
-- Name: pagus_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.pagus_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pagus_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.pagus_id_seq OWNED BY public.pagus.id;


--
-- Name: pajaks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pajaks (
    id bigint NOT NULL,
    tahun character varying,
    tipe character varying,
    potongan double precision,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: pajaks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.pajaks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pajaks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.pajaks_id_seq OWNED BY public.pajaks.id;


--
-- Name: perhitungans; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.perhitungans (
    id bigint NOT NULL,
    satuan character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    anggaran_id bigint,
    deskripsi character varying,
    spesifikasi text,
    pajak_id bigint,
    harga numeric,
    total numeric,
    volume numeric,
    tahun character varying
);


--
-- Name: perhitungans_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.perhitungans_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: perhitungans_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.perhitungans_id_seq OWNED BY public.perhitungans.id;


--
-- Name: permasalahans; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.permasalahans (
    id bigint NOT NULL,
    permasalahan text,
    jenis text,
    penyebab_internal character varying,
    penyebab_external character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    sasaran_id bigint
);


--
-- Name: permasalahans_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.permasalahans_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: permasalahans_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.permasalahans_id_seq OWNED BY public.permasalahans.id;


--
-- Name: pokpirs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pokpirs (
    id bigint NOT NULL,
    usulan character varying,
    alamat character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    tahun character varying,
    opd character varying,
    nip_asn character varying,
    sasaran_id bigint,
    is_active boolean DEFAULT false,
    status public.usulan_status DEFAULT 'draft'::public.usulan_status,
    uraian character varying,
    id_unik bigint,
    id_kamus bigint
);


--
-- Name: pokpirs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.pokpirs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pokpirs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.pokpirs_id_seq OWNED BY public.pokpirs.id;


--
-- Name: program_kegiatans; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.program_kegiatans (
    id bigint NOT NULL,
    nama_program character varying,
    nama_kegiatan character varying,
    nama_subkegiatan character varying,
    indikator_kinerja character varying,
    target character varying,
    satuan character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    subkegiatan_tematik_id bigint,
    indikator_subkegiatan character varying,
    target_subkegiatan character varying,
    satuan_target_subkegiatan character varying,
    kode_opd character varying,
    indikator_program character varying,
    target_program character varying,
    satuan_target_program character varying,
    id_unit character varying,
    kode_urusan character varying,
    nama_urusan character varying,
    kode_bidang_urusan character varying,
    nama_bidang_urusan character varying,
    id_program_sipd character varying,
    kode_program character varying,
    kode_giat character varying,
    id_sub_giat character varying,
    kode_sub_giat character varying,
    pagu character varying,
    identifier_belanja character varying,
    kode_skpd character varying,
    kode_sub_skpd character varying,
    id_sub_unit character varying,
    id_giat character varying,
    tahun character varying,
    isu_strategis character varying
);


--
-- Name: program_kegiatans_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.program_kegiatans_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: program_kegiatans_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.program_kegiatans_id_seq OWNED BY public.program_kegiatans.id;


--
-- Name: programs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.programs (
    id bigint NOT NULL,
    id_program character varying,
    tahun character varying,
    kode_program character varying,
    nama_program character varying,
    id_unik character varying,
    indikator character varying,
    satuan character varying,
    target character varying,
    nama_urusan character varying,
    nama_bidang_urusan character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: programs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.programs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: programs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.programs_id_seq OWNED BY public.programs.id;


--
-- Name: rekenings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.rekenings (
    id bigint NOT NULL,
    kode_rekening character varying,
    jenis_rekening character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    set_input integer DEFAULT 0
);


--
-- Name: rekenings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.rekenings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: rekenings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.rekenings_id_seq OWNED BY public.rekenings.id;


--
-- Name: renstras; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.renstras (
    id bigint NOT NULL,
    visi character varying,
    misi character varying,
    tujuan character varying,
    sasaran character varying,
    strategi character varying,
    id_bidang_urusan character varying,
    kode_bidang_urusan character varying,
    nama_bidang_urusan character varying,
    id_program_sipd character varying,
    kode_program character varying,
    nama_program character varying,
    indikator_program character varying,
    id_rpjmd_sipd character varying,
    id_giat_sipd character varying,
    kode_giat character varying,
    nama_giat character varying,
    indikator_kegiatan character varying,
    target_giat_1 character varying,
    target_giat_2 character varying,
    target_giat_3 character varying,
    target_giat_4 character varying,
    target_giat_5 character varying,
    pagu_giat_1 character varying,
    pagu_giat_2 character varying,
    pagu_giat_3 character varying,
    pagu_giat_4 character varying,
    pagu_giat_5 character varying,
    satuan_target_giat character varying,
    id_sub_giat_sipd character varying,
    kode_sub_giat character varying,
    nama_sub_giat character varying,
    indikator_sub_giat character varying,
    target_sub_giat_1 character varying,
    target_sub_giat_2 character varying,
    target_sub_giat_3 character varying,
    target_sub_giat_4 character varying,
    target_sub_giat_5 character varying,
    pagu_sub_giat_1 character varying,
    pagu_sub_giat_2 character varying,
    pagu_sub_giat_3 character varying,
    pagu_sub_giat_4 character varying,
    pagu_sub_giat_5 character varying,
    satuan_target_sub_giat character varying,
    id_unit character varying,
    id_skpd character varying,
    kode_skpd character varying,
    nama_skpd character varying,
    id_renstra character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: renstras_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.renstras_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: renstras_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.renstras_id_seq OWNED BY public.renstras.id;


--
-- Name: rincians; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.rincians (
    id bigint NOT NULL,
    sasaran_id bigint NOT NULL,
    data_terpilah character varying,
    penyebab_internal character varying,
    penyebab_external character varying,
    permasalahan_umum character varying,
    permasalahan_gender character varying,
    resiko character varying,
    lokasi_pelaksanaan character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    dampak character varying,
    skala_id bigint,
    kemungkinan_id integer
);


--
-- Name: rincians_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.rincians_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: rincians_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.rincians_id_seq OWNED BY public.rincians.id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.roles (
    id bigint NOT NULL,
    name character varying,
    resource_type character varying,
    resource_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- Name: sasaran_kota; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sasaran_kota (
    id bigint NOT NULL,
    id_misi character varying,
    id_tujuan character varying,
    id_sasaran character varying,
    tahun_awal character varying,
    tahun_akhir character varying,
    visi character varying,
    misi character varying,
    tujuan character varying,
    sasaran character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    kode_sasaran character varying
);


--
-- Name: sasaran_kota_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.sasaran_kota_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sasaran_kota_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.sasaran_kota_id_seq OWNED BY public.sasaran_kota.id;


--
-- Name: sasarans; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sasarans (
    id bigint NOT NULL,
    sasaran_kinerja character varying,
    indikator_kinerja character varying,
    target integer,
    kualitas integer,
    satuan character varying,
    penerima_manfaat character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    program_kegiatan_id bigint,
    anggaran integer,
    nip_asn character varying,
    id_rencana character varying,
    sumber_dana character varying,
    subkegiatan_tematik_id bigint,
    tahun character varying,
    status public.sasaran_status DEFAULT 'draft'::public.sasaran_status,
    sasaran_atasan_id character varying,
    sasaran_atasan character varying,
    type character varying,
    sasaran_opd character varying,
    sasaran_kota character varying,
    sasaran_milik character varying
);


--
-- Name: sasarans_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.sasarans_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sasarans_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.sasarans_id_seq OWNED BY public.sasarans.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: search_all_anggarans; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.search_all_anggarans AS
 SELECT anggaran_sshes.uraian_barang,
    anggaran_sshes.kode_barang,
    anggaran_sshes.spesifikasi,
    anggaran_sshes.satuan,
    anggaran_sshes.harga_satuan,
    'AnggaranSsh'::text AS searchable_type,
    anggaran_sshes.id AS searchable_id
   FROM public.anggaran_sshes
UNION
 SELECT anggaran_sbus.uraian_barang,
    anggaran_sbus.kode_barang,
    anggaran_sbus.spesifikasi,
    anggaran_sbus.satuan,
    anggaran_sbus.harga_satuan,
    'AnggaranSbu'::text AS searchable_type,
    anggaran_sbus.id AS searchable_id
   FROM public.anggaran_sbus
UNION
 SELECT anggaran_hspks.uraian_barang,
    anggaran_hspks.kode_barang,
    anggaran_hspks.spesifikasi,
    anggaran_hspks.satuan,
    anggaran_hspks.harga_satuan,
    'AnggaranHspk'::text AS searchable_type,
    anggaran_hspks.id AS searchable_id
   FROM public.anggaran_hspks
UNION
 SELECT anggaran_bluds.uraian_barang,
    anggaran_bluds.kode_barang,
    anggaran_bluds.spesifikasi,
    anggaran_bluds.satuan,
    anggaran_bluds.harga_satuan,
    'AnggaranBlud'::text AS searchable_type,
    anggaran_bluds.id AS searchable_id
   FROM public.anggaran_bluds
UNION
 SELECT anggaran_hspk_umums.uraian_barang,
    anggaran_hspk_umums.kode_barang,
    anggaran_hspk_umums.spesifikasi,
    anggaran_hspk_umums.satuan,
    anggaran_hspk_umums.harga_satuan,
    'AnggaranHspkUmum'::text AS searchable_type,
    anggaran_hspk_umums.id AS searchable_id
   FROM public.anggaran_hspk_umums;


--
-- Name: search_all_usulans; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.search_all_usulans AS
 SELECT musrenbangs.usulan,
    musrenbangs.sasaran_id,
    'Musrenbang'::text AS searchable_type,
    musrenbangs.id AS searchable_id
   FROM public.musrenbangs
  WHERE (musrenbangs.is_active = true)
UNION
 SELECT pokpirs.usulan,
    pokpirs.sasaran_id,
    'Pokpir'::text AS searchable_type,
    pokpirs.id AS searchable_id
   FROM public.pokpirs
  WHERE (pokpirs.is_active = true)
UNION
 SELECT mandatoris.usulan,
    mandatoris.sasaran_id,
    'Mandatori'::text AS searchable_type,
    mandatoris.id AS searchable_id
   FROM public.mandatoris
  WHERE (mandatoris.is_active = true)
UNION
 SELECT inovasis.usulan,
    inovasis.sasaran_id,
    'Inovasi'::text AS searchable_type,
    inovasis.id AS searchable_id
   FROM public.inovasis
  WHERE (inovasis.is_active = true);


--
-- Name: skalas; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.skalas (
    id bigint NOT NULL,
    kode_skala character varying,
    deskripsi character varying,
    nilai character varying,
    tipe_nilai character varying,
    keterangan character varying,
    type character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    rincian_id bigint
);


--
-- Name: skalas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.skalas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: skalas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.skalas_id_seq OWNED BY public.skalas.id;


--
-- Name: strategi_keluarans; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.strategi_keluarans (
    id bigint NOT NULL,
    metode text,
    tahapan text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: strategi_keluarans_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.strategi_keluarans_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: strategi_keluarans_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.strategi_keluarans_id_seq OWNED BY public.strategi_keluarans.id;


--
-- Name: subkegiatan_tematiks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.subkegiatan_tematiks (
    id bigint NOT NULL,
    nama_tematik character varying,
    kode_tematik character varying,
    tahun character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: subkegiatan_tematiks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.subkegiatan_tematiks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: subkegiatan_tematiks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.subkegiatan_tematiks_id_seq OWNED BY public.subkegiatan_tematiks.id;


--
-- Name: sumber_danas; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sumber_danas (
    id bigint NOT NULL,
    kode_sumber_dana character varying,
    sumber_dana character varying,
    tahun character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: sumber_danas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.sumber_danas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sumber_danas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.sumber_danas_id_seq OWNED BY public.sumber_danas.id;


--
-- Name: tahapans; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tahapans (
    id bigint NOT NULL,
    tahapan_kerja character varying,
    target integer,
    realisasi integer,
    bulan character varying,
    jumlah_target integer,
    jumlah_realisasi integer,
    keterangan character varying,
    waktu integer,
    progress integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    sasaran_id bigint,
    id_rencana_aksi character varying,
    id_rencana character varying
);


--
-- Name: tahapans_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.tahapans_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tahapans_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.tahapans_id_seq OWNED BY public.tahapans.id;


--
-- Name: tematik_sasarans; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tematik_sasarans (
    id bigint NOT NULL,
    sasaran_id bigint,
    subkegiatan_tematik_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: tematik_sasarans_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.tematik_sasarans_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tematik_sasarans_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.tematik_sasarans_id_seq OWNED BY public.tematik_sasarans.id;


--
-- Name: tujuan_kota; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tujuan_kota (
    id bigint NOT NULL,
    id_misi character varying,
    tahun_awal character varying,
    tahun_akhir character varying,
    id_tujuan character varying,
    visi character varying,
    misi character varying,
    tujuan character varying,
    type character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    kode_tujuan character varying
);


--
-- Name: tujuan_kota_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.tujuan_kota_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tujuan_kota_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.tujuan_kota_id_seq OWNED BY public.tujuan_kota.id;


--
-- Name: tujuans; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tujuans (
    id bigint NOT NULL,
    tujuan character varying,
    id_tujuan character varying NOT NULL,
    type character varying,
    kode_unik_opd character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: tujuans_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.tujuans_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tujuans_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.tujuans_id_seq OWNED BY public.tujuans.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    nama character varying,
    nik character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    kode_opd character varying,
    pangkat character varying,
    jabatan character varying,
    eselon character varying,
    nama_pangkat character varying,
    id_bidang bigint,
    nama_bidang character varying,
    type character varying,
    atasan character varying,
    atasan_nama character varying
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: users_roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users_roles (
    user_id bigint,
    role_id bigint
);


--
-- Name: usulans; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.usulans (
    id bigint NOT NULL,
    keterangan character varying,
    usulanable_type character varying,
    usulanable_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    sasaran_id bigint
);


--
-- Name: usulans_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.usulans_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: usulans_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.usulans_id_seq OWNED BY public.usulans.id;


--
-- Name: action_text_rich_texts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.action_text_rich_texts ALTER COLUMN id SET DEFAULT nextval('public.action_text_rich_texts_id_seq'::regclass);


--
-- Name: active_storage_attachments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_attachments ALTER COLUMN id SET DEFAULT nextval('public.active_storage_attachments_id_seq'::regclass);


--
-- Name: active_storage_blobs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_blobs ALTER COLUMN id SET DEFAULT nextval('public.active_storage_blobs_id_seq'::regclass);


--
-- Name: active_storage_variant_records id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_variant_records ALTER COLUMN id SET DEFAULT nextval('public.active_storage_variant_records_id_seq'::regclass);


--
-- Name: aksis id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.aksis ALTER COLUMN id SET DEFAULT nextval('public.aksis_id_seq'::regclass);


--
-- Name: anggaran_bluds id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.anggaran_bluds ALTER COLUMN id SET DEFAULT nextval('public.anggaran_bluds_id_seq'::regclass);


--
-- Name: anggaran_hspk_umums id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.anggaran_hspk_umums ALTER COLUMN id SET DEFAULT nextval('public.anggaran_hspk_umums_id_seq'::regclass);


--
-- Name: anggaran_hspks id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.anggaran_hspks ALTER COLUMN id SET DEFAULT nextval('public.anggaran_hspks_id_seq'::regclass);


--
-- Name: anggaran_sbus id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.anggaran_sbus ALTER COLUMN id SET DEFAULT nextval('public.anggaran_sbus_id_seq'::regclass);


--
-- Name: anggaran_sshes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.anggaran_sshes ALTER COLUMN id SET DEFAULT nextval('public.anggaran_sshes_id_seq'::regclass);


--
-- Name: anggarans id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.anggarans ALTER COLUMN id SET DEFAULT nextval('public.anggarans_id_seq'::regclass);


--
-- Name: background_migration_jobs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.background_migration_jobs ALTER COLUMN id SET DEFAULT nextval('public.background_migration_jobs_id_seq'::regclass);


--
-- Name: background_migrations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.background_migrations ALTER COLUMN id SET DEFAULT nextval('public.background_migrations_id_seq'::regclass);


--
-- Name: comments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comments ALTER COLUMN id SET DEFAULT nextval('public.comments_id_seq'::regclass);


--
-- Name: dasar_hukums id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dasar_hukums ALTER COLUMN id SET DEFAULT nextval('public.dasar_hukums_id_seq'::regclass);


--
-- Name: genders id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.genders ALTER COLUMN id SET DEFAULT nextval('public.genders_id_seq'::regclass);


--
-- Name: indikator_sasarans id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.indikator_sasarans ALTER COLUMN id SET DEFAULT nextval('public.indikator_sasarans_id_seq'::regclass);


--
-- Name: indikators id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.indikators ALTER COLUMN id SET DEFAULT nextval('public.indikators_id_seq'::regclass);


--
-- Name: inovasis id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inovasis ALTER COLUMN id SET DEFAULT nextval('public.inovasis_id_seq'::regclass);


--
-- Name: kaks id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.kaks ALTER COLUMN id SET DEFAULT nextval('public.kaks_id_seq'::regclass);


--
-- Name: kamus_usulans id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.kamus_usulans ALTER COLUMN id SET DEFAULT nextval('public.kamus_usulans_id_seq'::regclass);


--
-- Name: kelompok_anggarans id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.kelompok_anggarans ALTER COLUMN id SET DEFAULT nextval('public.kelompok_anggarans_id_seq'::regclass);


--
-- Name: kesenjangans id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.kesenjangans ALTER COLUMN id SET DEFAULT nextval('public.kesenjangans_id_seq'::regclass);


--
-- Name: koefisiens id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.koefisiens ALTER COLUMN id SET DEFAULT nextval('public.koefisiens_id_seq'::regclass);


--
-- Name: latar_belakangs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.latar_belakangs ALTER COLUMN id SET DEFAULT nextval('public.latar_belakangs_id_seq'::regclass);


--
-- Name: lembagas id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lembagas ALTER COLUMN id SET DEFAULT nextval('public.lembagas_id_seq'::regclass);


--
-- Name: mandatoris id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.mandatoris ALTER COLUMN id SET DEFAULT nextval('public.mandatoris_id_seq'::regclass);


--
-- Name: master_bidang_urusans id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.master_bidang_urusans ALTER COLUMN id SET DEFAULT nextval('public.master_bidang_urusans_id_seq'::regclass);


--
-- Name: master_kegiatans id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.master_kegiatans ALTER COLUMN id SET DEFAULT nextval('public.master_kegiatans_id_seq'::regclass);


--
-- Name: master_output_kegiatans id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.master_output_kegiatans ALTER COLUMN id SET DEFAULT nextval('public.master_output_kegiatans_id_seq'::regclass);


--
-- Name: master_programs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.master_programs ALTER COLUMN id SET DEFAULT nextval('public.master_programs_id_seq'::regclass);


--
-- Name: master_subkegiatans id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.master_subkegiatans ALTER COLUMN id SET DEFAULT nextval('public.master_subkegiatans_id_seq'::regclass);


--
-- Name: master_urusans id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.master_urusans ALTER COLUMN id SET DEFAULT nextval('public.master_urusans_id_seq'::regclass);


--
-- Name: musrenbangs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.musrenbangs ALTER COLUMN id SET DEFAULT nextval('public.musrenbangs_id_seq'::regclass);


--
-- Name: opds id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.opds ALTER COLUMN id SET DEFAULT nextval('public.opds_id_seq'::regclass);


--
-- Name: pagus id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pagus ALTER COLUMN id SET DEFAULT nextval('public.pagus_id_seq'::regclass);


--
-- Name: pajaks id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pajaks ALTER COLUMN id SET DEFAULT nextval('public.pajaks_id_seq'::regclass);


--
-- Name: perhitungans id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.perhitungans ALTER COLUMN id SET DEFAULT nextval('public.perhitungans_id_seq'::regclass);


--
-- Name: permasalahans id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.permasalahans ALTER COLUMN id SET DEFAULT nextval('public.permasalahans_id_seq'::regclass);


--
-- Name: pokpirs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pokpirs ALTER COLUMN id SET DEFAULT nextval('public.pokpirs_id_seq'::regclass);


--
-- Name: program_kegiatans id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.program_kegiatans ALTER COLUMN id SET DEFAULT nextval('public.program_kegiatans_id_seq'::regclass);


--
-- Name: programs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.programs ALTER COLUMN id SET DEFAULT nextval('public.programs_id_seq'::regclass);


--
-- Name: rekenings id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rekenings ALTER COLUMN id SET DEFAULT nextval('public.rekenings_id_seq'::regclass);


--
-- Name: renstras id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.renstras ALTER COLUMN id SET DEFAULT nextval('public.renstras_id_seq'::regclass);


--
-- Name: rincians id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rincians ALTER COLUMN id SET DEFAULT nextval('public.rincians_id_seq'::regclass);


--
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- Name: sasaran_kota id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sasaran_kota ALTER COLUMN id SET DEFAULT nextval('public.sasaran_kota_id_seq'::regclass);


--
-- Name: sasarans id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sasarans ALTER COLUMN id SET DEFAULT nextval('public.sasarans_id_seq'::regclass);


--
-- Name: skalas id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.skalas ALTER COLUMN id SET DEFAULT nextval('public.skalas_id_seq'::regclass);


--
-- Name: strategi_keluarans id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strategi_keluarans ALTER COLUMN id SET DEFAULT nextval('public.strategi_keluarans_id_seq'::regclass);


--
-- Name: subkegiatan_tematiks id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.subkegiatan_tematiks ALTER COLUMN id SET DEFAULT nextval('public.subkegiatan_tematiks_id_seq'::regclass);


--
-- Name: sumber_danas id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sumber_danas ALTER COLUMN id SET DEFAULT nextval('public.sumber_danas_id_seq'::regclass);


--
-- Name: tahapans id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tahapans ALTER COLUMN id SET DEFAULT nextval('public.tahapans_id_seq'::regclass);


--
-- Name: tematik_sasarans id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tematik_sasarans ALTER COLUMN id SET DEFAULT nextval('public.tematik_sasarans_id_seq'::regclass);


--
-- Name: tujuan_kota id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tujuan_kota ALTER COLUMN id SET DEFAULT nextval('public.tujuan_kota_id_seq'::regclass);


--
-- Name: tujuans id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tujuans ALTER COLUMN id SET DEFAULT nextval('public.tujuans_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: usulans id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.usulans ALTER COLUMN id SET DEFAULT nextval('public.usulans_id_seq'::regclass);


--
-- Name: action_text_rich_texts action_text_rich_texts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.action_text_rich_texts
    ADD CONSTRAINT action_text_rich_texts_pkey PRIMARY KEY (id);


--
-- Name: active_storage_attachments active_storage_attachments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_attachments
    ADD CONSTRAINT active_storage_attachments_pkey PRIMARY KEY (id);


--
-- Name: active_storage_blobs active_storage_blobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_blobs
    ADD CONSTRAINT active_storage_blobs_pkey PRIMARY KEY (id);


--
-- Name: active_storage_variant_records active_storage_variant_records_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_variant_records
    ADD CONSTRAINT active_storage_variant_records_pkey PRIMARY KEY (id);


--
-- Name: aksis aksis_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.aksis
    ADD CONSTRAINT aksis_pkey PRIMARY KEY (id);


--
-- Name: anggaran_bluds anggaran_bluds_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.anggaran_bluds
    ADD CONSTRAINT anggaran_bluds_pkey PRIMARY KEY (id);


--
-- Name: anggaran_hspk_umums anggaran_hspk_umums_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.anggaran_hspk_umums
    ADD CONSTRAINT anggaran_hspk_umums_pkey PRIMARY KEY (id);


--
-- Name: anggaran_hspks anggaran_hspks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.anggaran_hspks
    ADD CONSTRAINT anggaran_hspks_pkey PRIMARY KEY (id);


--
-- Name: anggaran_sbus anggaran_sbus_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.anggaran_sbus
    ADD CONSTRAINT anggaran_sbus_pkey PRIMARY KEY (id);


--
-- Name: anggaran_sshes anggaran_sshes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.anggaran_sshes
    ADD CONSTRAINT anggaran_sshes_pkey PRIMARY KEY (id);


--
-- Name: anggarans anggarans_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.anggarans
    ADD CONSTRAINT anggarans_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: background_migration_jobs background_migration_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.background_migration_jobs
    ADD CONSTRAINT background_migration_jobs_pkey PRIMARY KEY (id);


--
-- Name: background_migrations background_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.background_migrations
    ADD CONSTRAINT background_migrations_pkey PRIMARY KEY (id);


--
-- Name: comments comments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- Name: dasar_hukums dasar_hukums_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dasar_hukums
    ADD CONSTRAINT dasar_hukums_pkey PRIMARY KEY (id);


--
-- Name: genders genders_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.genders
    ADD CONSTRAINT genders_pkey PRIMARY KEY (id);


--
-- Name: indikator_sasarans indikator_sasarans_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.indikator_sasarans
    ADD CONSTRAINT indikator_sasarans_pkey PRIMARY KEY (id);


--
-- Name: indikators indikators_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.indikators
    ADD CONSTRAINT indikators_pkey PRIMARY KEY (id);


--
-- Name: inovasis inovasis_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inovasis
    ADD CONSTRAINT inovasis_pkey PRIMARY KEY (id);


--
-- Name: kaks kaks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.kaks
    ADD CONSTRAINT kaks_pkey PRIMARY KEY (id);


--
-- Name: kamus_usulans kamus_usulans_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.kamus_usulans
    ADD CONSTRAINT kamus_usulans_pkey PRIMARY KEY (id);


--
-- Name: kelompok_anggarans kelompok_anggarans_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.kelompok_anggarans
    ADD CONSTRAINT kelompok_anggarans_pkey PRIMARY KEY (id);


--
-- Name: kesenjangans kesenjangans_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.kesenjangans
    ADD CONSTRAINT kesenjangans_pkey PRIMARY KEY (id);


--
-- Name: koefisiens koefisiens_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.koefisiens
    ADD CONSTRAINT koefisiens_pkey PRIMARY KEY (id);


--
-- Name: latar_belakangs latar_belakangs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.latar_belakangs
    ADD CONSTRAINT latar_belakangs_pkey PRIMARY KEY (id);


--
-- Name: lembagas lembagas_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lembagas
    ADD CONSTRAINT lembagas_pkey PRIMARY KEY (id);


--
-- Name: mandatoris mandatoris_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.mandatoris
    ADD CONSTRAINT mandatoris_pkey PRIMARY KEY (id);


--
-- Name: master_bidang_urusans master_bidang_urusans_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.master_bidang_urusans
    ADD CONSTRAINT master_bidang_urusans_pkey PRIMARY KEY (id);


--
-- Name: master_kegiatans master_kegiatans_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.master_kegiatans
    ADD CONSTRAINT master_kegiatans_pkey PRIMARY KEY (id);


--
-- Name: master_output_kegiatans master_output_kegiatans_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.master_output_kegiatans
    ADD CONSTRAINT master_output_kegiatans_pkey PRIMARY KEY (id);


--
-- Name: master_programs master_programs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.master_programs
    ADD CONSTRAINT master_programs_pkey PRIMARY KEY (id);


--
-- Name: master_subkegiatans master_subkegiatans_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.master_subkegiatans
    ADD CONSTRAINT master_subkegiatans_pkey PRIMARY KEY (id);


--
-- Name: master_urusans master_urusans_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.master_urusans
    ADD CONSTRAINT master_urusans_pkey PRIMARY KEY (id);


--
-- Name: musrenbangs musrenbangs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.musrenbangs
    ADD CONSTRAINT musrenbangs_pkey PRIMARY KEY (id);


--
-- Name: opds opds_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.opds
    ADD CONSTRAINT opds_pkey PRIMARY KEY (id);


--
-- Name: pagus pagus_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pagus
    ADD CONSTRAINT pagus_pkey PRIMARY KEY (id);


--
-- Name: pajaks pajaks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pajaks
    ADD CONSTRAINT pajaks_pkey PRIMARY KEY (id);


--
-- Name: perhitungans perhitungans_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.perhitungans
    ADD CONSTRAINT perhitungans_pkey PRIMARY KEY (id);


--
-- Name: permasalahans permasalahans_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.permasalahans
    ADD CONSTRAINT permasalahans_pkey PRIMARY KEY (id);


--
-- Name: pokpirs pokpirs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pokpirs
    ADD CONSTRAINT pokpirs_pkey PRIMARY KEY (id);


--
-- Name: program_kegiatans program_kegiatans_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.program_kegiatans
    ADD CONSTRAINT program_kegiatans_pkey PRIMARY KEY (id);


--
-- Name: programs programs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.programs
    ADD CONSTRAINT programs_pkey PRIMARY KEY (id);


--
-- Name: rekenings rekenings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rekenings
    ADD CONSTRAINT rekenings_pkey PRIMARY KEY (id);


--
-- Name: renstras renstras_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.renstras
    ADD CONSTRAINT renstras_pkey PRIMARY KEY (id);


--
-- Name: rincians rincians_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rincians
    ADD CONSTRAINT rincians_pkey PRIMARY KEY (id);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: sasaran_kota sasaran_kota_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sasaran_kota
    ADD CONSTRAINT sasaran_kota_pkey PRIMARY KEY (id);


--
-- Name: sasarans sasarans_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sasarans
    ADD CONSTRAINT sasarans_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: skalas skalas_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.skalas
    ADD CONSTRAINT skalas_pkey PRIMARY KEY (id);


--
-- Name: strategi_keluarans strategi_keluarans_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strategi_keluarans
    ADD CONSTRAINT strategi_keluarans_pkey PRIMARY KEY (id);


--
-- Name: subkegiatan_tematiks subkegiatan_tematiks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.subkegiatan_tematiks
    ADD CONSTRAINT subkegiatan_tematiks_pkey PRIMARY KEY (id);


--
-- Name: sumber_danas sumber_danas_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sumber_danas
    ADD CONSTRAINT sumber_danas_pkey PRIMARY KEY (id);


--
-- Name: tahapans tahapans_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tahapans
    ADD CONSTRAINT tahapans_pkey PRIMARY KEY (id);


--
-- Name: tematik_sasarans tematik_sasarans_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tematik_sasarans
    ADD CONSTRAINT tematik_sasarans_pkey PRIMARY KEY (id);


--
-- Name: tujuan_kota tujuan_kota_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tujuan_kota
    ADD CONSTRAINT tujuan_kota_pkey PRIMARY KEY (id);


--
-- Name: tujuans tujuans_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tujuans
    ADD CONSTRAINT tujuans_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: usulans usulans_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.usulans
    ADD CONSTRAINT usulans_pkey PRIMARY KEY (id);


--
-- Name: index_action_text_rich_texts_uniqueness; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_action_text_rich_texts_uniqueness ON public.action_text_rich_texts USING btree (record_type, record_id, name);


--
-- Name: index_active_storage_attachments_on_blob_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_active_storage_attachments_on_blob_id ON public.active_storage_attachments USING btree (blob_id);


--
-- Name: index_active_storage_attachments_uniqueness; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_active_storage_attachments_uniqueness ON public.active_storage_attachments USING btree (record_type, record_id, name, blob_id);


--
-- Name: index_active_storage_blobs_on_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_active_storage_blobs_on_key ON public.active_storage_blobs USING btree (key);


--
-- Name: index_active_storage_variant_records_uniqueness; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_active_storage_variant_records_uniqueness ON public.active_storage_variant_records USING btree (blob_id, variation_digest);


--
-- Name: index_aksis_on_id_aksi_bulan; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_aksis_on_id_aksi_bulan ON public.aksis USING btree (id_aksi_bulan);


--
-- Name: index_anggarans_on_pajak_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_anggarans_on_pajak_id ON public.anggarans USING btree (pajak_id);


--
-- Name: index_anggarans_on_parent_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_anggarans_on_parent_id ON public.anggarans USING btree (parent_id);


--
-- Name: index_anggarans_on_tahapan_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_anggarans_on_tahapan_id ON public.anggarans USING btree (tahapan_id);


--
-- Name: index_background_migration_jobs_on_finished_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_background_migration_jobs_on_finished_at ON public.background_migration_jobs USING btree (migration_id, finished_at);


--
-- Name: index_background_migration_jobs_on_max_value; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_background_migration_jobs_on_max_value ON public.background_migration_jobs USING btree (migration_id, max_value);


--
-- Name: index_background_migration_jobs_on_updated_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_background_migration_jobs_on_updated_at ON public.background_migration_jobs USING btree (migration_id, status, updated_at);


--
-- Name: index_background_migrations_on_unique_configuration; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_background_migrations_on_unique_configuration ON public.background_migrations USING btree (migration_name, arguments);


--
-- Name: index_comments_on_anggaran_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_comments_on_anggaran_id ON public.comments USING btree (anggaran_id);


--
-- Name: index_comments_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_comments_on_user_id ON public.comments USING btree (user_id);


--
-- Name: index_genders_on_program_kegiatan_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_genders_on_program_kegiatan_id ON public.genders USING btree (program_kegiatan_id);


--
-- Name: index_genders_on_sasaran_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_genders_on_sasaran_id ON public.genders USING btree (sasaran_id);


--
-- Name: index_indikator_sasarans_on_id_indikator; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_indikator_sasarans_on_id_indikator ON public.indikator_sasarans USING btree (id_indikator);


--
-- Name: index_inovasis_on_sasaran_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_inovasis_on_sasaran_id ON public.inovasis USING btree (sasaran_id);


--
-- Name: index_inovasis_on_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_inovasis_on_status ON public.inovasis USING btree (status);


--
-- Name: index_kaks_on_program_kegiatan_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_kaks_on_program_kegiatan_id ON public.kaks USING btree (program_kegiatan_id);


--
-- Name: index_kamus_usulans_on_id_kamus; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_kamus_usulans_on_id_kamus ON public.kamus_usulans USING btree (id_kamus);


--
-- Name: index_kesenjangans_on_rincian_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_kesenjangans_on_rincian_id ON public.kesenjangans USING btree (rincian_id);


--
-- Name: index_koefisiens_on_perhitungan_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_koefisiens_on_perhitungan_id ON public.koefisiens USING btree (perhitungan_id);


--
-- Name: index_latar_belakangs_on_id_indikator_sasaran; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_latar_belakangs_on_id_indikator_sasaran ON public.latar_belakangs USING btree (id_indikator_sasaran);


--
-- Name: index_mandatoris_on_sasaran_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_mandatoris_on_sasaran_id ON public.mandatoris USING btree (sasaran_id);


--
-- Name: index_mandatoris_on_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_mandatoris_on_status ON public.mandatoris USING btree (status);


--
-- Name: index_master_bidang_urusans_on_id_unik_sipd; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_master_bidang_urusans_on_id_unik_sipd ON public.master_bidang_urusans USING btree (id_unik_sipd);


--
-- Name: index_master_kegiatans_on_id_unik_sipd; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_master_kegiatans_on_id_unik_sipd ON public.master_kegiatans USING btree (id_unik_sipd);


--
-- Name: index_master_output_kegiatans_on_id_output_bl; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_master_output_kegiatans_on_id_output_bl ON public.master_output_kegiatans USING btree (id_output_bl);


--
-- Name: index_master_programs_on_id_unik_sipd; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_master_programs_on_id_unik_sipd ON public.master_programs USING btree (id_unik_sipd);


--
-- Name: index_master_subkegiatans_on_id_unik_sipd; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_master_subkegiatans_on_id_unik_sipd ON public.master_subkegiatans USING btree (id_unik_sipd);


--
-- Name: index_master_urusans_on_id_unik_sipd; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_master_urusans_on_id_unik_sipd ON public.master_urusans USING btree (id_unik_sipd);


--
-- Name: index_musrenbangs_on_id_unik; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_musrenbangs_on_id_unik ON public.musrenbangs USING btree (id_unik);


--
-- Name: index_musrenbangs_on_sasaran_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_musrenbangs_on_sasaran_id ON public.musrenbangs USING btree (sasaran_id);


--
-- Name: index_musrenbangs_on_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_musrenbangs_on_status ON public.musrenbangs USING btree (status);


--
-- Name: index_opds_on_kode_unik_opd; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_opds_on_kode_unik_opd ON public.opds USING btree (kode_unik_opd);


--
-- Name: index_perhitungans_on_anggaran_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_perhitungans_on_anggaran_id ON public.perhitungans USING btree (anggaran_id);


--
-- Name: index_pokpirs_on_id_unik; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_pokpirs_on_id_unik ON public.pokpirs USING btree (id_unik);


--
-- Name: index_pokpirs_on_sasaran_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_pokpirs_on_sasaran_id ON public.pokpirs USING btree (sasaran_id);


--
-- Name: index_pokpirs_on_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_pokpirs_on_status ON public.pokpirs USING btree (status);


--
-- Name: index_program_kegiatans_on_identifier_belanja; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_program_kegiatans_on_identifier_belanja ON public.program_kegiatans USING btree (identifier_belanja);


--
-- Name: index_program_kegiatans_on_subkegiatan_tematik_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_program_kegiatans_on_subkegiatan_tematik_id ON public.program_kegiatans USING btree (subkegiatan_tematik_id);


--
-- Name: index_renstras_on_id_renstra; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_renstras_on_id_renstra ON public.renstras USING btree (id_renstra);


--
-- Name: index_rincians_on_sasaran_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_rincians_on_sasaran_id ON public.rincians USING btree (sasaran_id);


--
-- Name: index_rincians_on_skala_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_rincians_on_skala_id ON public.rincians USING btree (skala_id);


--
-- Name: index_roles_on_name_and_resource_type_and_resource_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_roles_on_name_and_resource_type_and_resource_id ON public.roles USING btree (name, resource_type, resource_id);


--
-- Name: index_roles_on_resource; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_roles_on_resource ON public.roles USING btree (resource_type, resource_id);


--
-- Name: index_sasaran_kota_on_id_sasaran; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_sasaran_kota_on_id_sasaran ON public.sasaran_kota USING btree (id_sasaran);


--
-- Name: index_sasarans_on_id_rencana; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_sasarans_on_id_rencana ON public.sasarans USING btree (id_rencana);


--
-- Name: index_tahapans_on_id_rencana_aksi; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_tahapans_on_id_rencana_aksi ON public.tahapans USING btree (id_rencana_aksi);


--
-- Name: index_tematik_sasarans_on_sasaran_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_tematik_sasarans_on_sasaran_id ON public.tematik_sasarans USING btree (sasaran_id);


--
-- Name: index_tematik_sasarans_on_subkegiatan_tematik_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_tematik_sasarans_on_subkegiatan_tematik_id ON public.tematik_sasarans USING btree (subkegiatan_tematik_id);


--
-- Name: index_tujuan_kota_on_id_tujuan; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_tujuan_kota_on_id_tujuan ON public.tujuan_kota USING btree (id_tujuan);


--
-- Name: index_tujuans_on_id_tujuan; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_tujuans_on_id_tujuan ON public.tujuans USING btree (id_tujuan);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_email ON public.users USING btree (email);


--
-- Name: index_users_on_nik; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_nik ON public.users USING btree (nik);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON public.users USING btree (reset_password_token);


--
-- Name: index_users_roles_on_role_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_roles_on_role_id ON public.users_roles USING btree (role_id);


--
-- Name: index_users_roles_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_roles_on_user_id ON public.users_roles USING btree (user_id);


--
-- Name: index_users_roles_on_user_id_and_role_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_roles_on_user_id_and_role_id ON public.users_roles USING btree (user_id, role_id);


--
-- Name: index_usulans_on_sasaran_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_usulans_on_sasaran_id ON public.usulans USING btree (sasaran_id);


--
-- Name: index_usulans_on_usulanable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_usulans_on_usulanable ON public.usulans USING btree (usulanable_type, usulanable_id);


--
-- Name: comments fk_rails_03de2dc08c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT fk_rails_03de2dc08c FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: tematik_sasarans fk_rails_09b7ad3d51; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tematik_sasarans
    ADD CONSTRAINT fk_rails_09b7ad3d51 FOREIGN KEY (sasaran_id) REFERENCES public.sasarans(id);


--
-- Name: tematik_sasarans fk_rails_22e78acf56; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tematik_sasarans
    ADD CONSTRAINT fk_rails_22e78acf56 FOREIGN KEY (subkegiatan_tematik_id) REFERENCES public.subkegiatan_tematiks(id);


--
-- Name: anggarans fk_rails_283268988b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.anggarans
    ADD CONSTRAINT fk_rails_283268988b FOREIGN KEY (pajak_id) REFERENCES public.pajaks(id);


--
-- Name: background_migration_jobs fk_rails_2aea8b9084; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.background_migration_jobs
    ADD CONSTRAINT fk_rails_2aea8b9084 FOREIGN KEY (migration_id) REFERENCES public.background_migrations(id) ON DELETE CASCADE;


--
-- Name: perhitungans fk_rails_2be8e57a69; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.perhitungans
    ADD CONSTRAINT fk_rails_2be8e57a69 FOREIGN KEY (pajak_id) REFERENCES public.pajaks(id) ON DELETE SET NULL NOT VALID;


--
-- Name: permasalahans fk_rails_4bce9be9f2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.permasalahans
    ADD CONSTRAINT fk_rails_4bce9be9f2 FOREIGN KEY (sasaran_id) REFERENCES public.sasarans(id);


--
-- Name: program_kegiatans fk_rails_569fe757c0; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.program_kegiatans
    ADD CONSTRAINT fk_rails_569fe757c0 FOREIGN KEY (subkegiatan_tematik_id) REFERENCES public.subkegiatan_tematiks(id);


--
-- Name: sasarans fk_rails_5880531b5c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sasarans
    ADD CONSTRAINT fk_rails_5880531b5c FOREIGN KEY (nip_asn) REFERENCES public.users(nik);


--
-- Name: kesenjangans fk_rails_617f862287; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.kesenjangans
    ADD CONSTRAINT fk_rails_617f862287 FOREIGN KEY (rincian_id) REFERENCES public.rincians(id);


--
-- Name: sasarans fk_rails_78dfe7067c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sasarans
    ADD CONSTRAINT fk_rails_78dfe7067c FOREIGN KEY (subkegiatan_tematik_id) REFERENCES public.subkegiatan_tematiks(id);


--
-- Name: dasar_hukums fk_rails_9530516a5c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dasar_hukums
    ADD CONSTRAINT fk_rails_9530516a5c FOREIGN KEY (sasaran_id) REFERENCES public.sasarans(id_rencana);


--
-- Name: active_storage_variant_records fk_rails_993965df05; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_variant_records
    ADD CONSTRAINT fk_rails_993965df05 FOREIGN KEY (blob_id) REFERENCES public.active_storage_blobs(id);


--
-- Name: latar_belakangs fk_rails_b420bec91b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.latar_belakangs
    ADD CONSTRAINT fk_rails_b420bec91b FOREIGN KEY (sasaran_id) REFERENCES public.sasarans(id);


--
-- Name: comments fk_rails_ba01fcc435; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT fk_rails_ba01fcc435 FOREIGN KEY (anggaran_id) REFERENCES public.anggarans(id);


--
-- Name: active_storage_attachments fk_rails_c3b3935057; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_attachments
    ADD CONSTRAINT fk_rails_c3b3935057 FOREIGN KEY (blob_id) REFERENCES public.active_storage_blobs(id);


--
-- Name: rincians fk_rails_d41263ddba; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rincians
    ADD CONSTRAINT fk_rails_d41263ddba FOREIGN KEY (sasaran_id) REFERENCES public.sasarans(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20211117111734'),
('20211117134919'),
('20211118014824'),
('20211122011717'),
('20211122155526'),
('20211122160439'),
('20211122161823'),
('20211123004734'),
('20211123011849'),
('20211125014415'),
('20211125062414'),
('20211125063107'),
('20211125072846'),
('20211125073143'),
('20211126031500'),
('20211126031753'),
('20211126032022'),
('20211126033005'),
('20211126060741'),
('20211129022042'),
('20211129061925'),
('20211129221844'),
('20211129223607'),
('20211130024236'),
('20211130024454'),
('20211130133308'),
('20211130134259'),
('20211130134430'),
('20211130134647'),
('20211130155327'),
('20211130161202'),
('20211201033746'),
('20211201041756'),
('20211201082317'),
('20211201082509'),
('20211202012436'),
('20211202024043'),
('20211202024937'),
('20211202033622'),
('20211202035522'),
('20211213215504'),
('20211213215752'),
('20211226112338'),
('20211226114806'),
('20211226115208'),
('20211226115249'),
('20211226122226'),
('20211226135624'),
('20220103111107'),
('20220109013810'),
('20220109013854'),
('20220109013855'),
('20220121185156'),
('20220204020944'),
('20220210064526'),
('20220210073823'),
('20220210074611'),
('20220210080542'),
('20220210080819'),
('20220210080923'),
('20220210230618'),
('20220216073611'),
('20220217202811'),
('20220217232235'),
('20220221093506'),
('20220221151205'),
('20220221153340'),
('20220222005538'),
('20220222005609'),
('20220222005700'),
('20220222073321'),
('20220223040427'),
('20220223041123'),
('20220225022813'),
('20220228152349'),
('20220228153139'),
('20220301023835'),
('20220301032833'),
('20220301075120'),
('20220301080810'),
('20220301080938'),
('20220301081008'),
('20220303132948'),
('20220307154802'),
('20220307154811'),
('20220307154823'),
('20220308073415'),
('20220309011023'),
('20220310145807'),
('20220310160049'),
('20220310231308'),
('20220315224940'),
('20220317022005'),
('20220321032216'),
('20220321034451'),
('20220327011422'),
('20220327020014'),
('20220329044557'),
('20220329074240'),
('20220329101930'),
('20220329102302'),
('20220329104150'),
('20220329105912'),
('20220402133813'),
('20220414052715'),
('20220414062221'),
('20220415222139'),
('20220416035018'),
('20220416041551'),
('20220417070528'),
('20220422033311'),
('20220422055009'),
('20220423095629'),
('20220423095836'),
('20220423100357'),
('20220423134650'),
('20220423134924'),
('20220423154555'),
('20220424080049'),
('20220424151655'),
('20220424152317'),
('20220425044032'),
('20220425184806'),
('20220425190940'),
('20220427020239'),
('20220427030931'),
('20220427165709'),
('20220427172539'),
('20220428015251'),
('20220428031837'),
('20220428034402'),
('20220428034736'),
('20220428060458'),
('20220503064338'),
('20220504045005'),
('20220504114533'),
('20220505175922'),
('20220512221743'),
('20220512224036'),
('20220518040710'),
('20220518074325'),
('20220520072832'),
('20220520074832'),
('20220520162623'),
('20220524004152'),
('20220608034333'),
('20220608063442'),
('20220608072733'),
('20220608160351'),
('20220608160457'),
('20220608160705'),
('20220608160820'),
('20220608163724'),
('20220609014559'),
('20220623072453'),
('20220624012209'),
('20220624014758'),
('20220624060055'),
('20220627001747'),
('20220627003603'),
('20220627025154'),
('20220704014143'),
('20220719032829'),
('20220719071026'),
('20220720064452'),
('20220725112104'),
('20220727070419'),
('20220728124001'),
('20220728124341'),
('20220729030633'),
('20220731054048'),
('20220812065723'),
('20220822023747'),
('20220822163037'),
('20220823171259'),
('20220829023819'),
('20220901004124'),
('20220902020642'),
('20220902032047'),
('20220904202731'),
('20220908035548'),
('20220908193810'),
('20220909014123'),
('20220909075315'),
('20220912074109'),
('20220912095543'),
('20220912101849'),
('20220912105503'),
('20221001100003'),
('20221006070803'),
('20221006072126'),
('20221010010305'),
('20221011022256'),
('20221011193500'),
('20221018022814'),
('20221019073357');


