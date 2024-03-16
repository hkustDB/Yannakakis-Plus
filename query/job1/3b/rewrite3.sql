create or replace view aggView3247280163977641813 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin6553530366739422914 as select movie_id as v12 from movie_keyword as mk, aggView3247280163977641813 where mk.keyword_id=aggView3247280163977641813.v1;
create or replace view aggView4647865478591561971 as select v12 from aggJoin6553530366739422914 group by v12;
create or replace view aggJoin5351998884252785055 as select id as v12, title as v13 from title as t, aggView4647865478591561971 where t.id=aggView4647865478591561971.v12 and production_year>2010;
create or replace view aggView7615170290245037103 as select v12, MIN(v13) as v24 from aggJoin5351998884252785055 group by v12;
create or replace view aggJoin5609499588149303211 as select v24 from movie_info as mi, aggView7615170290245037103 where mi.movie_id=aggView7615170290245037103.v12 and info= 'Bulgaria';
create or replace view res as select MIN(v24) as v24 from aggJoin5609499588149303211;
select sum(v24) from res;