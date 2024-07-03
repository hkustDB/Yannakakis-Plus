create or replace view aggView2390346468942587148 as select id as v14, title as v27 from title as t where production_year>2010;
create or replace view aggJoin2827433535966377896 as select movie_id as v14, info_type_id as v1, info as v9, v27 from movie_info_idx as mi_idx, aggView2390346468942587148 where mi_idx.movie_id=aggView2390346468942587148.v14 and info>'9.0';
create or replace view aggView6725186595906755118 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin2628006409210283281 as select v14, v9, v27 from aggJoin2827433535966377896 join aggView6725186595906755118 using(v1);
create or replace view aggView8705747811385796362 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin8818951012610629224 as select movie_id as v14 from movie_keyword as mk, aggView8705747811385796362 where mk.keyword_id=aggView8705747811385796362.v3;
create or replace view aggView5594538305691130297 as select v14, MIN(v27) as v27, MIN(v9) as v26 from aggJoin2628006409210283281 group by v14,v27;
create or replace view aggJoin3603487384704809417 as select v27, v26 from aggJoin8818951012610629224 join aggView5594538305691130297 using(v14);
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin3603487384704809417;
