create or replace view aggView5093642755587629710 as select id as v8 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin2251707897077660667 as select movie_id as v23 from movie_keyword as mk, aggView5093642755587629710 where mk.keyword_id=aggView5093642755587629710.v8;
create or replace view aggView7936544864413798791 as select v23, COUNT(*) as annot from aggJoin2251707897077660667 group by v23;
create or replace view aggJoin5248223654314856608 as select id as v23, production_year as v27, annot from title as t, aggView7936544864413798791 where t.id=aggView7936544864413798791.v23 and production_year>2014;
create or replace view aggView5492404135937097610 as select v23, SUM(annot) as annot from aggJoin5248223654314856608 group by v23;
create or replace view aggJoin5970568474603226847 as select person_id as v14, annot from cast_info as ci, aggView5492404135937097610 where ci.movie_id=aggView5492404135937097610.v23;
create or replace view aggView8745859459445056630 as select v14, SUM(annot) as annot from aggJoin5970568474603226847 group by v14;
create or replace view aggJoin4100325213227653731 as select annot from name as n, aggView8745859459445056630 where n.id=aggView8745859459445056630.v14 and name LIKE '%Downey%Robert%';
select SUM(annot) as v35 from aggJoin4100325213227653731;
