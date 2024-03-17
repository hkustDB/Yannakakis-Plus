create or replace view aggView423380778068583246 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin5180571862234040542 as select movie_id as v23, v35 from movie_keyword as mk, aggView423380778068583246 where mk.keyword_id=aggView423380778068583246.v8;
create or replace view aggView5349123645418468405 as select v23, MIN(v35) as v35 from aggJoin5180571862234040542 group by v23;
create or replace view aggJoin5518645911125756012 as select id as v23, title as v24, v35 from title as t, aggView5349123645418468405 where t.id=aggView5349123645418468405.v23 and production_year>2010;
create or replace view aggView3135197092986305320 as select v23, MIN(v35) as v35, MIN(v24) as v37 from aggJoin5518645911125756012 group by v23;
create or replace view aggJoin1336400669194108938 as select person_id as v14, v35, v37 from cast_info as ci, aggView3135197092986305320 where ci.movie_id=aggView3135197092986305320.v23;
create or replace view aggView1261779452132588188 as select v14, MIN(v35) as v35, MIN(v37) as v37 from aggJoin1336400669194108938 group by v14;
create or replace view aggJoin4188582186717139713 as select name as v15, v35, v37 from name as n, aggView1261779452132588188 where n.id=aggView1261779452132588188.v14 and name LIKE '%Downey%Robert%';
select MIN(v35) as v35,MIN(v15) as v36,MIN(v37) as v37 from aggJoin4188582186717139713;
