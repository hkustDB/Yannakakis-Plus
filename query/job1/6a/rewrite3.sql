create or replace view aggView3187002349350570252 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin4628388189449178871 as select movie_id as v23, v35 from movie_keyword as mk, aggView3187002349350570252 where mk.keyword_id=aggView3187002349350570252.v8;
create or replace view aggView4297963247238459531 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin1525410105516291503 as select movie_id as v23, v36 from cast_info as ci, aggView4297963247238459531 where ci.person_id=aggView4297963247238459531.v14;
create or replace view aggView5475661084161385958 as select v23, MIN(v35) as v35 from aggJoin4628388189449178871 group by v23;
create or replace view aggJoin4066822159736350067 as select v23, v36 as v36, v35 from aggJoin1525410105516291503 join aggView5475661084161385958 using(v23);
create or replace view aggView3169684146866674802 as select v23, MIN(v36) as v36, MIN(v35) as v35 from aggJoin4066822159736350067 group by v23;
create or replace view aggJoin6559667015961621653 as select title as v24, v36, v35 from title as t, aggView3169684146866674802 where t.id=aggView3169684146866674802.v23 and production_year>2010;
select MIN(v35) as v35,MIN(v36) as v36,MIN(v24) as v37 from aggJoin6559667015961621653;
