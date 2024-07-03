create or replace view aggView8155098422409644387 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin5149007449252456469 as select movie_id as v12 from movie_keyword as mk, aggView8155098422409644387 where mk.keyword_id=aggView8155098422409644387.v1;
create or replace view aggView3584447753855874404 as select v12 from aggJoin5149007449252456469 group by v12;
create or replace view aggJoin927321817458049748 as select movie_id as v12, info as v7 from movie_info as mi, aggView3584447753855874404 where mi.movie_id=aggView3584447753855874404.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView270741181190772527 as select v12 from aggJoin927321817458049748 group by v12;
create or replace view aggJoin6063879364170826611 as select title as v13, production_year as v16 from title as t, aggView270741181190772527 where t.id=aggView270741181190772527.v12 and production_year>1990;
create or replace view aggView7506571668174524655 as select v13 from aggJoin6063879364170826611;
select MIN(v13) as v24 from aggView7506571668174524655;
