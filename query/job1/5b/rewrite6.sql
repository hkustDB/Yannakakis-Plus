create or replace view aggView1476708395516737040 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin2390957597099799129 as select movie_id as v15, note as v9 from movie_companies as mc, aggView1476708395516737040 where mc.company_type_id=aggView1476708395516737040.v1 and note LIKE '%(USA)%' and note LIKE '%(VHS)%' and note LIKE '%(1994)%';
create or replace view aggView4978956058714982162 as select v15 from aggJoin2390957597099799129 group by v15;
create or replace view aggJoin7823081907718243785 as select id as v15, title as v16 from title as t, aggView4978956058714982162 where t.id=aggView4978956058714982162.v15 and production_year>2010;
create or replace view aggView1840269012622954578 as select v15, MIN(v16) as v27 from aggJoin7823081907718243785 group by v15;
create or replace view aggJoin1329745321098621691 as select info_type_id as v3, v27 from movie_info as mi, aggView1840269012622954578 where mi.movie_id=aggView1840269012622954578.v15 and info IN ('USA','America');
create or replace view aggView6890901615712738716 as select id as v3 from info_type as it;
create or replace view aggJoin8641301674343415884 as select v27 from aggJoin1329745321098621691 join aggView6890901615712738716 using(v3);
select MIN(v27) as v27 from aggJoin8641301674343415884;
