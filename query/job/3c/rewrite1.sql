create or replace view aggView8151369195343113615 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin2212717684294486453 as select movie_id as v12 from movie_keyword as mk, aggView8151369195343113615 where mk.keyword_id=aggView8151369195343113615.v1;
create or replace view aggView296864303621433104 as select v12 from aggJoin2212717684294486453 group by v12;
create or replace view aggJoin6028736390309468546 as select id as v12, title as v13, production_year as v16 from title as t, aggView296864303621433104 where t.id=aggView296864303621433104.v12 and production_year>1990;
create or replace view aggView5585553588006223299 as select v12, MIN(v13) as v24 from aggJoin6028736390309468546 group by v12;
create or replace view aggJoin2022197255461611285 as select v24 from movie_info as mi, aggView5585553588006223299 where mi.movie_id=aggView5585553588006223299.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
select MIN(v24) as v24 from aggJoin2022197255461611285;
