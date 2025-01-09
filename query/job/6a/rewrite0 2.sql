create or replace view aggView1131427583345539819 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin5452544174489546922 as select movie_id as v23, v35 from movie_keyword as mk, aggView1131427583345539819 where mk.keyword_id=aggView1131427583345539819.v8;
create or replace view aggView2066653409454504655 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin8383068620487120365 as select movie_id as v23, v36 from cast_info as ci, aggView2066653409454504655 where ci.person_id=aggView2066653409454504655.v14;
create or replace view aggView5030755371675011565 as select v23, MIN(v35) as v35 from aggJoin5452544174489546922 group by v23;
create or replace view aggJoin7117881656673470707 as select id as v23, title as v24, production_year as v27, v35 from title as t, aggView5030755371675011565 where t.id=aggView5030755371675011565.v23 and production_year>2010;
create or replace view aggView54364138065072992 as select v23, MIN(v36) as v36 from aggJoin8383068620487120365 group by v23;
create or replace view aggJoin6919937557944274981 as select v24, v27, v35 as v35, v36 from aggJoin7117881656673470707 join aggView54364138065072992 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v24) as v37 from aggJoin6919937557944274981;
