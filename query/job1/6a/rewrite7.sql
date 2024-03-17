create or replace view aggView7563789319708597274 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin949882921217738922 as select movie_id as v23, v36 from cast_info as ci, aggView7563789319708597274 where ci.person_id=aggView7563789319708597274.v14;
create or replace view aggView3796921768410721945 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin1606578949386043561 as select movie_id as v23, v35 from movie_keyword as mk, aggView3796921768410721945 where mk.keyword_id=aggView3796921768410721945.v8;
create or replace view aggView2548902575838590780 as select v23, MIN(v36) as v36 from aggJoin949882921217738922 group by v23;
create or replace view aggJoin3928802663855796387 as select id as v23, title as v24, v36 from title as t, aggView2548902575838590780 where t.id=aggView2548902575838590780.v23 and production_year>2010;
create or replace view aggView926908319831486802 as select v23, MIN(v35) as v35 from aggJoin1606578949386043561 group by v23;
create or replace view aggJoin4098117436413988211 as select v24, v36 as v36, v35 from aggJoin3928802663855796387 join aggView926908319831486802 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v24) as v37 from aggJoin4098117436413988211;
