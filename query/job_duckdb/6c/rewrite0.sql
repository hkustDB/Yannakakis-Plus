create or replace view aggView5066970704711772123 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin4416110862085674803 as select movie_id as v23, v35 from movie_keyword as mk, aggView5066970704711772123 where mk.keyword_id=aggView5066970704711772123.v8;
create or replace view aggView364256426998686567 as select v23, MIN(v35) as v35 from aggJoin4416110862085674803 group by v23;
create or replace view aggJoin4496129672332598169 as select id as v23, title as v24, production_year as v27, v35 from title as t, aggView364256426998686567 where t.id=aggView364256426998686567.v23 and production_year>2014;
create or replace view aggView4512207833263891488 as select v23, MIN(v35) as v35, MIN(v24) as v37 from aggJoin4496129672332598169 group by v23;
create or replace view aggJoin3470319218675978456 as select person_id as v14, v35, v37 from cast_info as ci, aggView4512207833263891488 where ci.movie_id=aggView4512207833263891488.v23;
create or replace view aggView1547183541283961668 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin7989595235316427052 as select v35, v37, v36 from aggJoin3470319218675978456 join aggView1547183541283961668 using(v14);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin7989595235316427052;
