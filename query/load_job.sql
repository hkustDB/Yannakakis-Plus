CREATE TABLE IF NOT EXISTS aka_name (
    id integer,
    person_id integer,
    name varchar(512),
    imdb_index varchar(3),
    name_pcode_cf varchar(11),
    name_pcode_nf varchar(11),
    surname_pcode varchar(11),
    md5sum varchar(65),
    PRIMARY KEY (id)
);
insert into aka_name SELECT * FROM read_parquet('/PATH_TO_JOB_DATA/aka_name.parquet');

CREATE TABLE IF NOT EXISTS aka_title (
    id integer NOT NULL,
    movie_id integer NOT NULL,
    title varchar(553) NOT NULL,
    imdb_index varchar(12),
    kind_id integer NOT NULL,
    production_year real,
    phonetic_code varchar(5),
    episode_of_id real,
    season_nr real,
    episode_nr real,
    note varchar(72),
    md5sum varchar(32),
    PRIMARY KEY (id)
);
insert into aka_title SELECT * FROM read_parquet('/PATH_TO_JOB_DATA/aka_title.parquet');

CREATE TABLE IF NOT EXISTS cast_info (
    id integer,
    person_id integer,
    movie_id integer,
    person_role_id real,
    note text,
    nr_order real,
    role_id integer,
    PRIMARY KEY (id)
);
insert into cast_info SELECT * FROM read_parquet('/PATH_TO_JOB_DATA/cast_info.parquet');

CREATE TABLE IF NOT EXISTS char_name (
    id integer,
    name varchar(512),
    imdb_index varchar(2),
    imdb_id real,
    name_pcode_nf varchar(5),
    surname_pcode varchar(5),
    md5sum varchar(32),
    PRIMARY KEY (id)
);
insert into char_name SELECT * FROM read_parquet('/PATH_TO_JOB_DATA/char_name.parquet');

CREATE TABLE IF NOT EXISTS comp_cast_type (
    id integer,
    kind varchar(32),
    PRIMARY KEY (id)
);
insert into comp_cast_type SELECT * FROM read_parquet('/PATH_TO_JOB_DATA/comp_cast_type.parquet');

CREATE TABLE IF NOT EXISTS company_name (
    id integer,
    name varchar(512),
    country_code varchar(6),
    imdb_id real,
    name_pcode_nf varchar(5),
    name_pcode_sf varchar(5),
    md5sum varchar(32),
    PRIMARY KEY (id)
);
insert into company_name SELECT * FROM read_parquet('/PATH_TO_JOB_DATA/company_name.parquet');

CREATE TABLE IF NOT EXISTS company_type (
    id integer,
    kind varchar(32),
    PRIMARY KEY (id)
);
insert into company_type SELECT * FROM read_parquet('/PATH_TO_JOB_DATA/company_type.parquet');

CREATE TABLE IF NOT EXISTS complete_cast (
    id integer,
    movie_id integer,
    subject_id integer,
    status_id integer,
    PRIMARY KEY (id)
);
insert into complete_cast SELECT * FROM read_parquet('/PATH_TO_JOB_DATA/complete_cast.parquet');

CREATE TABLE IF NOT EXISTS info_type (
    id integer,
    info varchar(32),
    PRIMARY KEY (id)
);
insert into info_type SELECT * FROM read_parquet('/PATH_TO_JOB_DATA/info_type.parquet');

CREATE TABLE IF NOT EXISTS keyword (
    id integer,
    keyword varchar(512),
    phonetic_code varchar(5),
    PRIMARY KEY (id)
);
insert into keyword SELECT * FROM read_parquet('/PATH_TO_JOB_DATA/keyword.parquet');

CREATE TABLE IF NOT EXISTS kind_type (
    id integer,
    kind varchar(15),
    PRIMARY KEY (id)
);
insert into kind_type SELECT * FROM read_parquet('/PATH_TO_JOB_DATA/kind_type.parquet');

CREATE TABLE IF NOT EXISTS link_type (
    id integer,
    link varchar(32),
    PRIMARY KEY (id)
);
insert into link_type SELECT * FROM read_parquet('/PATH_TO_JOB_DATA/link_type.parquet');

CREATE TABLE IF NOT EXISTS movie_companies (
    id integer,
    movie_id integer,
    company_id integer,
    company_type_id integer,
    note text,
    PRIMARY KEY (id)
);
insert into movie_companies SELECT * FROM read_parquet('/PATH_TO_JOB_DATA/movie_companies.parquet');

CREATE TABLE IF NOT EXISTS movie_info_idx (
    id integer,
    movie_id integer,
    info_type_id integer,
    info text,
    note text,
    PRIMARY KEY (id)
);
insert into movie_info SELECT * FROM read_parquet('/PATH_TO_JOB_DATA/movie_info.parquet');

CREATE TABLE IF NOT EXISTS movie_keyword (
    id integer,
    movie_id integer,
    keyword_id integer,
    PRIMARY KEY (id)
);
insert into movie_info_idx SELECT * FROM read_parquet('/PATH_TO_JOB_DATA/movie_info_idx.parquet');

CREATE TABLE IF NOT EXISTS movie_link (
    id integer,
    movie_id integer,
    linked_movie_id integer,
    link_type_id integer,
    PRIMARY KEY (id)
);
insert into movie_keyword SELECT * FROM read_parquet('/PATH_TO_JOB_DATA/movie_keyword.parquet');

CREATE TABLE IF NOT EXISTS name (
    id integer,
    name varchar(512),
    imdb_index varchar(9),
    imdb_id real,
    gender varchar(1),
    name_pcode_cf varchar(5),
    name_pcode_nf varchar(5),
    surname_pcode varchar(5),
    md5sum varchar(32),
    PRIMARY KEY (id)
);
insert into movie_link SELECT * FROM read_parquet('/PATH_TO_JOB_DATA/movie_link.parquet');

CREATE TABLE IF NOT EXISTS role_type (
    id integer,
    role varchar(32),
    PRIMARY KEY (id)
);
insert into name SELECT * FROM read_parquet('/PATH_TO_JOB_DATA/name.parquet');

CREATE TABLE IF NOT EXISTS title (
    id integer,
    title varchar(512),
    imdb_index varchar(5),
    kind_id integer,
    production_year real,
    imdb_id real,
    phonetic_code varchar(5),
    episode_of_id real,
    season_nr real,
    episode_nr real,
    series_years varchar(49),
    md5sum varchar(32),
    PRIMARY KEY (id)
);
insert into role_type SELECT * FROM read_parquet('/PATH_TO_JOB_DATA/role_type.parquet');

CREATE TABLE IF NOT EXISTS movie_info (
    id integer,
    movie_id integer,
    info_type_id integer,
    info text,
    note text,
    PRIMARY KEY (id)
);
insert into title SELECT * FROM read_parquet('/PATH_TO_JOB_DATA/title.parquet');

CREATE TABLE IF NOT EXISTS person_info (
    id integer,
    person_id integer,
    info_type_id integer,
    info text,
    note text,
    PRIMARY KEY (id)
);
insert into person_info SELECT * FROM read_parquet('/PATH_TO_JOB_DATA/person_info.parquet');