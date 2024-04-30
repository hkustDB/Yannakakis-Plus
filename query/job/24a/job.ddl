CREATE TABLE aka_name (
    id integer,
    person_id integer,
    name varchar,
    imdb_index varchar,
    name_pcode_cf varchar,
    name_pcode_nf varchar,
    surname_pcode varchar,
    md5sum varchar,
    PRIMARY KEY (id)
) WITH (
        'cardinality' = '90134300'
);

CREATE TABLE aka_title (
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
    md5sum varchar,
    PRIMARY KEY (id)
) WITH (
        'cardinality' = '36147200'
);

CREATE TABLE cast_info (
    id integer,
    person_id integer,
    movie_id integer,
    person_role_id integer,
    note varchar,
    nr_order integer,
    role_id integer,
    PRIMARY KEY (id)
) WITH (
        'cardinality' = '86747700'
);

CREATE TABLE char_name (
    id integer,
    name varchar,
    imdb_index varchar,
    imdb_id integer,
    name_pcode_nf varchar,
    surname_pcode varchar,
    md5sum varchar,
    PRIMARY KEY (id)
) WITH (
        'cardinality' = '314033900'
);

CREATE TABLE comp_cast_type (
    id integer,
    kind varchar,
    PRIMARY KEY (id)
) WITH (
        'cardinality' = '400'
);

CREATE TABLE company_name (
    id integer,
    name varchar,
    country_code varchar,
    imdb_id integer,
    name_pcode_nf varchar,
    name_pcode_sf varchar,
    md5sum varchar,
    PRIMARY KEY (id)
) WITH (
        'cardinality' = '8484300'
);

CREATE TABLE company_type (
    id integer,
    kind varchar,
    PRIMARY KEY (id)
) WITH (
        'cardinality' = '400'
);

CREATE TABLE complete_cast (
    id integer,
    movie_id integer,
    subject_id integer,
    status_id integer,
    PRIMARY KEY (id)
) WITH (
        'cardinality' = '13508600'
);

CREATE TABLE info_type (
    id integer,
    info varchar,
    PRIMARY KEY (id)
) WITH (
        'cardinality' = '100'
);

CREATE TABLE keyword (
    id integer,
    keyword varchar,
    phonetic_code varchar,
    PRIMARY KEY (id)
) WITH (
        'cardinality' = '300'
);

CREATE TABLE kind_type (
    id integer,
    kind varchar,
    PRIMARY KEY (id)
) WITH (
        'cardinality' = '700'
);

CREATE TABLE link_type (
    id integer,
    link varchar,
    PRIMARY KEY (id)
) WITH (
        'cardinality' = '1800'
);

CREATE TABLE movie_companies (
    id integer,
    movie_id integer,
    company_id integer,
    company_type_id integer,
    note varchar,
    PRIMARY KEY (id)
) WITH (
        'cardinality' = '260912900'
);

CREATE TABLE movie_info_idx (
    id integer,
    movie_id integer,
    info_type_id integer,
    info varchar,
    note varchar,
    PRIMARY KEY (id)
) WITH (
        'cardinality' = '138003500'
);

CREATE TABLE movie_keyword (
    id integer,
    movie_id integer,
    keyword_id integer,
    PRIMARY KEY (id)
) WITH (
        'cardinality' = '452393000'
);

CREATE TABLE movie_link (
    id integer,
    movie_id integer,
    linked_movie_id integer,
    link_type_id integer,
    PRIMARY KEY (id)
) WITH (
        'cardinality' = '2999700'
);

CREATE TABLE name (
    id integer,
    name varchar,
    imdb_index varchar,
    imdb_id integer,
    gender varchar,
    name_pcode_cf varchar,
    name_pcode_nf varchar,
    surname_pcode varchar,
    md5sum varchar,
    PRIMARY KEY (id)
) WITH (
        'cardinality' = '5001100'
);

CREATE TABLE role_type (
    id integer,
    role varchar,
    PRIMARY KEY (id)
) WITH (
        'cardinality' = '100'
);

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
    md5sum varchar,
    PRIMARY KEY (id)
) WITH (
        'cardinality' = '39166600'
);

CREATE TABLE movie_info (
    id integer,
    movie_id integer,
    info_type_id integer,
    info varchar,
    note varchar,
    PRIMARY KEY (id)
) WITH (
        'cardinality' = '30124700'
);

CREATE TABLE person_info (
    id integer,
    person_id integer,
    info_type_id integer,
    info varchar,
    note varchar,
    PRIMARY KEY (id)
) WITH (
        'cardinality' = '296366400'
);