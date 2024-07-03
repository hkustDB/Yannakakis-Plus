create or replace view aggView3022648099329628501 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin1300736629497806535 as select movie_id as v23, v35 from movie_keyword as mk, aggView3022648099329628501 where mk.keyword_id=aggView3022648099329628501.v8;
create or replace view aggView7476020801360322540 as select v23, MIN(v35) as v35 from aggJoin1300736629497806535 group by v23,v35;
create or replace view aggJoin8415999153871785458 as select id as v23, title as v24, production_year as v27, v35 from title as t, aggView7476020801360322540 where t.id=aggView7476020801360322540.v23 and production_year>2000;
create or replace view aggView7300190067493808110 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin6423147227051805719 as select movie_id as v23, v36 from cast_info as ci, aggView7300190067493808110 where ci.person_id=aggView7300190067493808110.v14;
create or replace view aggView1269289147496109204 as select v23, MIN(v35) as v35, MIN(v24) as v37 from aggJoin8415999153871785458 group by v23,v35;
create or replace view aggJoin5891934349590868904 as select v36 as v36, v35, v37 from aggJoin6423147227051805719 join aggView1269289147496109204 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin5891934349590868904;
