create or replace view aggView4046213746609708559 as select id as v14, title as v27 from title as t where production_year>1990;
create or replace view aggJoin3479191833900435655 as select movie_id as v14, keyword_id as v3, v27 from movie_keyword as mk, aggView4046213746609708559 where mk.movie_id=aggView4046213746609708559.v14;
create or replace view aggView1426453921294584708 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin2827225604939829328 as select v14, v27 from aggJoin3479191833900435655 join aggView1426453921294584708 using(v3);
create or replace view aggView3395248585467324939 as select v14, MIN(v27) as v27 from aggJoin2827225604939829328 group by v14;
create or replace view aggJoin7099184677176473250 as select info_type_id as v1, info as v9, v27 from movie_info_idx as mi_idx, aggView3395248585467324939 where mi_idx.movie_id=aggView3395248585467324939.v14 and info>'2.0';
create or replace view aggView3821567710703488070 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin5302943457123845851 as select v9, v27 from aggJoin7099184677176473250 join aggView3821567710703488070 using(v1);
select MIN(v9) as v26,MIN(v27) as v27 from aggJoin5302943457123845851;
