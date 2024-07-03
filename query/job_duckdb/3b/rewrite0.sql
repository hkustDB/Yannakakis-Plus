create or replace view aggView2121973914593481680 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin5950204386508600145 as select movie_id as v12 from movie_keyword as mk, aggView2121973914593481680 where mk.keyword_id=aggView2121973914593481680.v1;
create or replace view aggView3684120750933752549 as select v12 from aggJoin5950204386508600145 group by v12;
create or replace view aggJoin1114472349677787625 as select movie_id as v12, info as v7 from movie_info as mi, aggView3684120750933752549 where mi.movie_id=aggView3684120750933752549.v12 and info= 'Bulgaria';
create or replace view aggView7006583199056980053 as select v12 from aggJoin1114472349677787625 group by v12;
create or replace view aggJoin8189703221579651501 as select title as v13, production_year as v16 from title as t, aggView7006583199056980053 where t.id=aggView7006583199056980053.v12 and production_year>2010;
create or replace view aggView1925126319512236113 as select v13 from aggJoin8189703221579651501;
select MIN(v13) as v24 from aggView1925126319512236113;
