create or replace view aggView1445170976890870850 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin3993782788218219803 as select movie_id as v23, v35 from movie_keyword as mk, aggView1445170976890870850 where mk.keyword_id=aggView1445170976890870850.v8;
create or replace view aggView844901489793087165 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin3156153787010426931 as select movie_id as v23, v36 from cast_info as ci, aggView844901489793087165 where ci.person_id=aggView844901489793087165.v14;
create or replace view aggView676396058049844621 as select id as v23, title as v37 from title as t where production_year>2010;
create or replace view aggJoin7580357090644922470 as select v23, v35, v37 from aggJoin3993782788218219803 join aggView676396058049844621 using(v23);
create or replace view aggView5271333270703811791 as select v23, MIN(v35) as v35, MIN(v37) as v37 from aggJoin7580357090644922470 group by v23;
create or replace view aggJoin3512546725660018342 as select v36 as v36, v35, v37 from aggJoin3156153787010426931 join aggView5271333270703811791 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin3512546725660018342;
