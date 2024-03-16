create or replace view aggView6780548058944469003 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin8291945328921784299 as select movie_id as v23, v35 from movie_keyword as mk, aggView6780548058944469003 where mk.keyword_id=aggView6780548058944469003.v8;
create or replace view aggView7547352872183555359 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin9205646848388188525 as select movie_id as v23, v36 from cast_info as ci, aggView7547352872183555359 where ci.person_id=aggView7547352872183555359.v14;
create or replace view aggView9184450852368561322 as select v23, MIN(v35) as v35 from aggJoin8291945328921784299 group by v23;
create or replace view aggJoin956344057686374465 as select id as v23, title as v24, v35 from title as t, aggView9184450852368561322 where t.id=aggView9184450852368561322.v23 and production_year>2000;
create or replace view aggView4944265800061339290 as select v23, MIN(v35) as v35, MIN(v24) as v37 from aggJoin956344057686374465 group by v23;
create or replace view aggJoin4245479540539168957 as select v36 as v36, v35, v37 from aggJoin9205646848388188525 join aggView4944265800061339290 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin4245479540539168957;
