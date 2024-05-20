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

CREATE TABLE IF NOT EXISTS comp_cast_type (
    id integer,
    kind varchar(32),
    PRIMARY KEY (id)
);

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

CREATE TABLE IF NOT EXISTS company_type (
    id integer,
    kind varchar(32),
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS complete_cast (
    id integer,
    movie_id integer,
    subject_id integer,
    status_id integer,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS info_type (
    id integer,
    info varchar(32),
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS keyword (
    id integer,
    keyword varchar(512),
    phonetic_code varchar(5),
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS kind_type (
    id integer,
    kind varchar(15),
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS link_type (
    id integer,
    link varchar(32),
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS movie_companies (
    id integer,
    movie_id integer,
    company_id integer,
    company_type_id integer,
    note text,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS movie_info_idx (
    id integer,
    movie_id integer,
    info_type_id integer,
    info text,
    note text,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS movie_keyword (
    id integer,
    movie_id integer,
    keyword_id integer,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS movie_link (
    id integer,
    movie_id integer,
    linked_movie_id integer,
    link_type_id integer,
    PRIMARY KEY (id)
);

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

CREATE TABLE IF NOT EXISTS role_type (
    id integer,
    role varchar(32),
    PRIMARY KEY (id)
);

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

CREATE TABLE IF NOT EXISTS movie_info (
    id integer,
    movie_id integer,
    info_type_id integer,
    info text,
    note text,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS person_info (
    id integer,
    person_id integer,
    info_type_id integer,
    info text,
    note text,
    PRIMARY KEY (id)
);

create or replace view q2_inner as
SELECT ps_partkey as v1_partkey, MIN(ps_supplycost) as v1_supplycost_min
FROM partsupp, supplier, nation, region
WHERE s_suppkey = ps_suppkey
  AND s_nationkey = n_nationkey
  AND n_regionkey = r_regionkey
  AND r_name = 'EUROPE'
GROUP BY ps_partkey;

create or replace view orderswithyear as select orders.*, EXTRACT(YEAR FROM o_orderdate) AS o_year from orders;

create or replace view revenue0 (supplier_no, total_revenue) as select l_suppkey, sum(l_extendedprice * (1 - l_discount))
from lineitem
where l_shipdate >= DATE '1995-02-01' and l_shipdate < DATE '1995-05-01'
group by l_suppkey;

create or replace view q15_inner as select max(total_revenue) as max_tr from revenue0;

create view q17_inner as select l_partkey as v1_partkey, 0.2 * AVG(l_quantity) as v1_quantity_avg from lineitem l2 group by l_partkey;

create or replace view q18_inner as select l_orderkey as v1_orderkey from lineitem l2 group by l_orderkey having sum(l_quantity) > 312;

create or replace view q20_inner1 as SELECT p_partkey as v1_partkey FROM part WHERE p_name LIKE 'forest%';

create or replace view q20_inner2 as 
SELECT 0.5 * SUM(l_quantity) as v2_quantity_sum FROM lineitem, partsupp
WHERE l_partkey = ps_partkey
	AND l_suppkey = ps_suppkey
	AND l_shipdate >= DATE '1994-01-01'
	AND l_shipdate < DATE '1995-01-01';