create or replace view aggView1845041127007687600 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin3951935808279462747 as select movie_id as v23, v35 from movie_keyword as mk, aggView1845041127007687600 where mk.keyword_id=aggView1845041127007687600.v8;
create or replace view aggView2471614516133685056 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin543137519133753944 as select movie_id as v23, v36 from cast_info as ci, aggView2471614516133685056 where ci.person_id=aggView2471614516133685056.v14;
create or replace view aggView5577869199572994302 as select id as v23, title as v37 from title as t where production_year>2014;
create or replace view aggJoin7517595400125425017 as select v23, v36, v37 from aggJoin543137519133753944 join aggView5577869199572994302 using(v23);
create or replace view aggView3639321184427010968 as select v23, MIN(v35) as v35 from aggJoin3951935808279462747 group by v23,v35;
create or replace view aggJoin3555758848154098696 as select v36 as v36, v37 as v37, v35 from aggJoin7517595400125425017 join aggView3639321184427010968 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin3555758848154098696;
