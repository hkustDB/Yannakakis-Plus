create or replace view aggView1166350247363744091 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin8366875043919551304 as select movie_id as v23, v36 from cast_info as ci, aggView1166350247363744091 where ci.person_id=aggView1166350247363744091.v14;
create or replace view aggView7014469679581870508 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin8498648338852359211 as select movie_id as v23, v35 from movie_keyword as mk, aggView7014469679581870508 where mk.keyword_id=aggView7014469679581870508.v8;
create or replace view aggView2884463292935459090 as select v23, MIN(v35) as v35 from aggJoin8498648338852359211 group by v23,v35;
create or replace view aggJoin8948980319727652525 as select id as v23, title as v24, production_year as v27, v35 from title as t, aggView2884463292935459090 where t.id=aggView2884463292935459090.v23 and production_year>2000;
create or replace view aggView6199142489666732176 as select v23, MIN(v35) as v35, MIN(v24) as v37 from aggJoin8948980319727652525 group by v23,v35;
create or replace view aggJoin533881208465946775 as select v36 as v36, v35, v37 from aggJoin8366875043919551304 join aggView6199142489666732176 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin533881208465946775;
