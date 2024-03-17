create or replace view aggView4320776618974930332 as select movie_id as v12 from movie_info as mi where info= 'Bulgaria' group by movie_id;
create or replace view aggJoin2799948211716596347 as select id as v12, title as v13 from title as t, aggView4320776618974930332 where t.id=aggView4320776618974930332.v12 and production_year>2010;
create or replace view aggView1889624193304828684 as select v12, MIN(v13) as v24 from aggJoin2799948211716596347 group by v12;
create or replace view aggJoin3092244103586151719 as select keyword_id as v1, v24 from movie_keyword as mk, aggView1889624193304828684 where mk.movie_id=aggView1889624193304828684.v12;
create or replace view aggView6399079127806335610 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin6381370238978880320 as select v24 from aggJoin3092244103586151719 join aggView6399079127806335610 using(v1);
create or replace view res as select MIN(v24) as v24 from aggJoin6381370238978880320;
select sum(v24) from res;