CREATE TABLE IF NOT EXISTS aka_name (
    id integer NOT NULL,
    person_id integer NOT NULL,
    name varchar(512),
    imdb_index varchar(3),
    name_pcode_cf varchar(11),
    name_pcode_nf varchar(11),
    surname_pcode varchar(11),
    md5sum varchar(65)
);
CREATE TABLE IF NOT EXISTS aka_title (
    id integer NOT NULL,
    movie_id integer NOT NULL,
    title varchar(553) NOT NULL,
    imdb_index varchar(12),
    kind_id integer NOT NULL,
    production_year integer,
    phonetic_code varchar(5),
    episode_of_id integer,
    season_nr integer,
    episode_nr integer,
    note varchar(72),
    md5sum varchar(32)
);CREATE TABLE IF NOT EXISTS cast_info (
    id integer,
    person_id integer,
    movie_id integer,
    person_role_id integer,
    note text,
    nr_order integer,
    role_id integer
);CREATE TABLE IF NOT EXISTS char_name (
    id integer,
    name varchar(512),
    imdb_index varchar(2),
    imdb_id integer,
    name_pcode_nf varchar(5),
    surname_pcode varchar(5),
    md5sum varchar(32)
);CREATE TABLE IF NOT EXISTS comp_cast_type (
    id integer,
    kind varchar(32)
);CREATE TABLE IF NOT EXISTS company_name (
    id integer,
    name varchar(512),
    country_code varchar(6),
    imdb_id integer,
    name_pcode_nf varchar(5),
    name_pcode_sf varchar(5),
    md5sum varchar(32)
);CREATE TABLE IF NOT EXISTS company_type (
    id integer,
    kind varchar(32)
);CREATE TABLE IF NOT EXISTS complete_cast (
    id integer,
    movie_id integer,
    subject_id integer,
    status_id integer
);CREATE TABLE IF NOT EXISTS info_type (
    id integer,
    info varchar(32)
);CREATE TABLE IF NOT EXISTS keyword (
    id integer,
    keyword varchar(512),
    phonetic_code varchar(5)
);CREATE TABLE IF NOT EXISTS kind_type (
    id integer,
    kind varchar(15)
);CREATE TABLE IF NOT EXISTS link_type (
    id integer,
    link varchar(32)
);CREATE TABLE IF NOT EXISTS movie_companies (
    id integer,
    movie_id integer,
    company_id integer,
    company_type_id integer,
    note text
);CREATE TABLE IF NOT EXISTS movie_info_idx (
    id integer,
    movie_id integer,
    info_type_id integer,
    info text,
    note text
);CREATE TABLE IF NOT EXISTS movie_keyword (
    id integer,
    movie_id integer,
    keyword_id integer
);CREATE TABLE IF NOT EXISTS movie_link (
    id integer,
    movie_id integer,
    linked_movie_id integer,
    link_type_id integer
);CREATE TABLE IF NOT EXISTS name (
    id integer,
    name varchar(512),
    imdb_index varchar(9),
    imdb_id integer,
    gender varchar(1),
    name_pcode_cf varchar(5),
    name_pcode_nf varchar(5),
    surname_pcode varchar(5),
    md5sum varchar(32)
);CREATE TABLE IF NOT EXISTS role_type (
    id integer,
    role varchar(32)
);CREATE TABLE IF NOT EXISTS title (
    id integer,
    title varchar(512),
    imdb_index varchar(5),
    kind_id integer,
    production_year integer,
    imdb_id integer,
    phonetic_code varchar(5),
    episode_of_id integer,
    season_nr integer,
    episode_nr integer,
    series_years varchar(49),
    md5sum varchar(32)
);CREATE TABLE IF NOT EXISTS movie_info (
    id integer,
    movie_id integer,
    info_type_id integer,
    info text,
    note text
);CREATE TABLE IF NOT EXISTS person_info (
    id integer,
    person_id integer,
    info_type_id integer,
    info text,
    note text
);
submit job insert overwrite into aka_name select * from oss_aka_name;
submit job insert overwrite into aka_title select * from oss_aka_title;
submit job insert overwrite into cast_info select * from oss_cast_info;#
submit job insert overwrite into char_name select * from oss_char_name;
submit job insert overwrite into comp_cast_type select * from oss_comp_cast_type;
submit job insert overwrite into company_name select * from oss_company_name;
submit job insert overwrite into company_type select * from oss_company_type;
submit job insert overwrite into complete_cast select * from oss_complete_cast;
submit job insert overwrite into info_type select * from oss_info_type;
submit job insert overwrite into keyword select * from oss_keyword;
submit job insert overwrite into kind_type select * from oss_kind_type;
submit job insert overwrite into link_type select * from oss_link_type;
submit job insert overwrite into movie_companies select * from oss_movie_companies;
submit job insert overwrite into movie_info_idx select * from oss_movie_info_idx;
submit job insert overwrite into movie_keyword select * from oss_movie_keyword;
submit job insert overwrite into movie_link select * from oss_movie_link;
submit job insert overwrite into name select * from oss_name;
submit job insert overwrite into role_type select * from oss_role_type;
submit job insert overwrite into title select * from oss_title;
submit job insert overwrite into movie_info select * from oss_movie_info;#
submit job insert overwrite into person_info select * from oss_person_info;#

ANALYZE TABLE aka_name UPDATE HISTOGRAM;
ANALYZE TABLE aka_title UPDATE HISTOGRAM;
ANALYZE TABLE cast_info UPDATE HISTOGRAM;
ANALYZE TABLE char_name UPDATE HISTOGRAM;
ANALYZE TABLE comp_cast_type UPDATE HISTOGRAM;
ANALYZE TABLE company_name UPDATE HISTOGRAM;
ANALYZE TABLE company_type UPDATE HISTOGRAM;
ANALYZE TABLE complete_cast UPDATE HISTOGRAM;
ANALYZE TABLE info_type UPDATE HISTOGRAM;
ANALYZE TABLE keyword UPDATE HISTOGRAM;
ANALYZE TABLE kind_type UPDATE HISTOGRAM;
ANALYZE TABLE link_type UPDATE HISTOGRAM;
ANALYZE TABLE movie_companies UPDATE HISTOGRAM;
ANALYZE TABLE movie_info_idx UPDATE HISTOGRAM;
ANALYZE TABLE movie_keyword UPDATE HISTOGRAM;
ANALYZE TABLE movie_link UPDATE HISTOGRAM;
ANALYZE TABLE name UPDATE HISTOGRAM;
ANALYZE TABLE role_type UPDATE HISTOGRAM;
ANALYZE TABLE title UPDATE HISTOGRAM;
ANALYZE TABLE movie_info UPDATE HISTOGRAM;
ANALYZE TABLE person_info UPDATE HISTOGRAM;