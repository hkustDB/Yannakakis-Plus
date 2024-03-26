create or replace view aggView2319820969450292958 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin3743707580342347257 as select movie_id as v23, v36 from cast_info as ci, aggView2319820969450292958 where ci.person_id=aggView2319820969450292958.v14;
create or replace view aggView3299718001834821140 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin6760587146476281199 as select movie_id as v23, v35 from movie_keyword as mk, aggView3299718001834821140 where mk.keyword_id=aggView3299718001834821140.v8;
create or replace view aggView2966316149662202034 as select v23, MIN(v36) as v36 from aggJoin3743707580342347257 group by v23;
create or replace view aggJoin5863976773300410819 as select id as v23, title as v24, v36 from title as t, aggView2966316149662202034 where t.id=aggView2966316149662202034.v23 and production_year>2000;
create or replace view aggView1202231101885882369 as select v23, MIN(v36) as v36, MIN(v24) as v37 from aggJoin5863976773300410819 group by v23;
create or replace view aggJoin3968805669048878472 as select v35 as v35, v36, v37 from aggJoin6760587146476281199 join aggView1202231101885882369 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin3968805669048878472;
