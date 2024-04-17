create or replace view aggView6370998570708346886 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin3127916928647306302 as select movie_id as v23, v35 from movie_keyword as mk, aggView6370998570708346886 where mk.keyword_id=aggView6370998570708346886.v8;
create or replace view aggView6123455149762201806 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin4876555069276376879 as select movie_id as v23, v36 from cast_info as ci, aggView6123455149762201806 where ci.person_id=aggView6123455149762201806.v14;
create or replace view aggView2099109996745898779 as select v23, MIN(v35) as v35 from aggJoin3127916928647306302 group by v23,v35;
create or replace view aggJoin7488912952433353381 as select id as v23, title as v24, production_year as v27, v35 from title as t, aggView2099109996745898779 where t.id=aggView2099109996745898779.v23 and production_year>2010;
create or replace view aggView8627450698970883646 as select v23, MIN(v35) as v35, MIN(v24) as v37 from aggJoin7488912952433353381 group by v23,v35;
create or replace view aggJoin6889053679866790601 as select v36 as v36, v35, v37 from aggJoin4876555069276376879 join aggView8627450698970883646 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin6889053679866790601;
