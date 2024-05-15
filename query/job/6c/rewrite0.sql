create or replace view aggView690139149458312007 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin2223553244947688982 as select movie_id as v23, v35 from movie_keyword as mk, aggView690139149458312007 where mk.keyword_id=aggView690139149458312007.v8;
create or replace view aggView1603991223674165375 as select v23, MIN(v35) as v35 from aggJoin2223553244947688982 group by v23;
create or replace view aggJoin5578161435281883605 as select id as v23, title as v24, production_year as v27, v35 from title as t, aggView1603991223674165375 where t.id=aggView1603991223674165375.v23 and production_year>2014;
create or replace view aggView2231525942206596961 as select v23, MIN(v35) as v35, MIN(v24) as v37 from aggJoin5578161435281883605 group by v23;
create or replace view aggJoin603999230619009419 as select person_id as v14, v35, v37 from cast_info as ci, aggView2231525942206596961 where ci.movie_id=aggView2231525942206596961.v23;
create or replace view aggView2714753333573287900 as select v14, MIN(v35) as v35, MIN(v37) as v37 from aggJoin603999230619009419 group by v14;
create or replace view aggJoin7571738423043277268 as select name as v15, v35, v37 from name as n, aggView2714753333573287900 where n.id=aggView2714753333573287900.v14 and name LIKE '%Downey%Robert%';
select MIN(v35) as v35,MIN(v15) as v36,MIN(v37) as v37 from aggJoin7571738423043277268;
