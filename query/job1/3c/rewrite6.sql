create or replace view aggView7814305049350009798 as select id as v12, title as v24 from title as t where production_year>1990;
create or replace view aggJoin6738010515681482033 as select movie_id as v12, keyword_id as v1, v24 from movie_keyword as mk, aggView7814305049350009798 where mk.movie_id=aggView7814305049350009798.v12;
create or replace view aggView1252341000273858159 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin8208635910080439824 as select v12, v24 from aggJoin6738010515681482033 join aggView1252341000273858159 using(v1);
create or replace view aggView3007738836949859152 as select v12, MIN(v24) as v24 from aggJoin8208635910080439824 group by v12;
create or replace view aggJoin4906680324646722490 as select info as v7, v24 from movie_info as mi, aggView3007738836949859152 where mi.movie_id=aggView3007738836949859152.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view res as select MIN(v24) as v24 from aggJoin4906680324646722490;
select sum(v24) from res;