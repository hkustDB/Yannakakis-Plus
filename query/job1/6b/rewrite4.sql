create or replace view aggView6851050721323497225 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin3273065639896177539 as select movie_id as v23, v36 from cast_info as ci, aggView6851050721323497225 where ci.person_id=aggView6851050721323497225.v14;
create or replace view aggView1597103379920620898 as select id as v23, title as v37 from title as t where production_year>2014;
create or replace view aggJoin9105111132609369234 as select v23, v36, v37 from aggJoin3273065639896177539 join aggView1597103379920620898 using(v23);
create or replace view aggView111265419985491305 as select v23, MIN(v36) as v36, MIN(v37) as v37 from aggJoin9105111132609369234 group by v23;
create or replace view aggJoin8523939163860795470 as select keyword_id as v8, v36, v37 from movie_keyword as mk, aggView111265419985491305 where mk.movie_id=aggView111265419985491305.v23;
create or replace view aggView2882432508242372864 as select v8, MIN(v36) as v36, MIN(v37) as v37 from aggJoin8523939163860795470 group by v8;
create or replace view aggJoin1093313957732485321 as select keyword as v9, v36, v37 from keyword as k, aggView2882432508242372864 where k.id=aggView2882432508242372864.v8 and keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
select MIN(v9) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin1093313957732485321;
