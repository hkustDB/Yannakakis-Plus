CREATE TABLE aaka_nameb (
    id integer,
    person_id integer,
    name varchar,
    imdb_index varchar,
    name_pcode_cf varchar,
    name_pcode_nf varchar,
    surname_pcode varchar,
    md5sum varchar);

CREATE TABLE caka_titled (
    id integer,
    movie_id integer,
    title varchar,
    imdb_index varchar,
    kind_id integer,
    production_year integer,
    phonetic_code varchar,
    episode_of_id integer,
    season_nr integer,
    episode_nr integer,
    note varchar,
    md5sum varchar);

CREATE TABLE ecast_infof (
    id integer,
    person_id integer,
    movie_id integer,
    person_role_id integer,
    note varchar,
    nr_order integer,
    role_id integer);

CREATE TABLE gchar_nameh (
    id integer,
    name varchar,
    imdb_index varchar,
    imdb_id integer,
    name_pcode_nf varchar,
    surname_pcode varchar,
    md5sum varchar);

CREATE TABLE icomp_cast_typet (
    id integer,
    kind varchar);

CREATE TABLE lcompany_namem (
    id integer,
    name varchar,
    country_code varchar,
    imdb_id integer,
    name_pcode_nf varchar,
    name_pcode_sf varchar,
    md5sum varchar);

CREATE TABLE ocompany_typen (
    id integer,
    kind varchar);

CREATE TABLE pcomplete_castq (
    id integer,
    movie_id integer,
    subject_id integer,
    status_id integer);

CREATE TABLE rinfo_types (
    id integer,
    info varchar);

CREATE TABLE keyword (
    id integer,
    keyword varchar,
    phonetic_code varchar);

CREATE TABLE zkind_typea (
    id integer,
    kind varchar);

CREATE TABLE ylink_typeb (
    id integer,
    link varchar);

CREATE TABLE xmovie_companiesc (
    id integer,
    movie_id integer,
    company_id integer,
    company_type_id integer,
    note varchar);

CREATE TABLE tmovie_info_idxd (
    id integer,
    movie_id integer,
    info_type_id integer,
    info varchar,
    note varchar);

CREATE TABLE smovie_keywordp (
    id integer,
    movie_id integer,
    keyword_id integer);

CREATE TABLE lmovie_linkq (
    id integer,
    movie_id integer,
    linked_movie_id integer,
    link_type_id integer);

CREATE TABLE name (
    id integer,
    name varchar,
    imdb_index varchar,
    imdb_id integer,
    gender varchar,
    name_pcode_cf varchar,
    name_pcode_nf varchar,
    surname_pcode varchar,
    md5sum varchar);

CREATE TABLE irole_typeo (
    id integer,
    role varchar);

CREATE TABLE title (
    id integer,
    title varchar,
    imdb_index varchar,
    kind_id integer,
    production_year integer,
    imdb_id integer,
    phonetic_code varchar,
    episode_of_id integer,
    season_nr integer,
    episode_nr integer,
    series_years varchar,
    md5sum varchar);

CREATE TABLE emovie_infoa (
    id integer,
    movie_id integer,
    info_type_id integer,
    info varchar,
    note varchar);

CREATE TABLE lperson_infos (
    id integer,
    person_id integer,
    info_type_id integer,
    info varchar,
    note varchar);