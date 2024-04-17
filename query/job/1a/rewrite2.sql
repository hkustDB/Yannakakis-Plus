create or replace view aggView1381169833139089836 as select id as v15, title as v28, production_year as v29 from title as t;
create or replace view aggJoin2674888420066031311 as select movie_id as v15, info_type_id as v3, v28, v29 from movie_info_idx as mi_idx, aggView1381169833139089836 where mi_idx.movie_id=aggView1381169833139089836.v15;
create or replace view aggView4787538394288115192 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin981916363064046716 as select v15, v28, v29 from aggJoin2674888420066031311 join aggView4787538394288115192 using(v3);
create or replace view aggView8590266257816437108 as select v15, MIN(v28) as v28, MIN(v29) as v29 from aggJoin981916363064046716 group by v15,v28,v29;
create or replace view aggJoin2083081732113856258 as select company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView8590266257816437108 where mc.movie_id=aggView8590266257816437108.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%' and ((note LIKE '%(co-production)%') OR (note LIKE '%(presents)%'));
create or replace view aggView568315846085510076 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin3351538824566708429 as select v9, v28, v29 from aggJoin2083081732113856258 join aggView568315846085510076 using(v1);
select MIN(v9) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin3351538824566708429;
