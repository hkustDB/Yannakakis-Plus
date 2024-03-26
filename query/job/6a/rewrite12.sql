create or replace view aggView7048819417637404898 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin5432454394039590154 as select movie_id as v23, v35 from movie_keyword as mk, aggView7048819417637404898 where mk.keyword_id=aggView7048819417637404898.v8;
create or replace view aggView5076890541495167772 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin23020280357317215 as select movie_id as v23, v36 from cast_info as ci, aggView5076890541495167772 where ci.person_id=aggView5076890541495167772.v14;
create or replace view aggView7680960703979374650 as select v23, MIN(v35) as v35 from aggJoin5432454394039590154 group by v23;
create or replace view aggJoin6815579551267823090 as select id as v23, title as v24, v35 from title as t, aggView7680960703979374650 where t.id=aggView7680960703979374650.v23 and production_year>2010;
create or replace view aggView6677734326074802645 as select v23, MIN(v36) as v36 from aggJoin23020280357317215 group by v23;
create or replace view aggJoin5142781727885670499 as select v24, v35 as v35, v36 from aggJoin6815579551267823090 join aggView6677734326074802645 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v24) as v37 from aggJoin5142781727885670499;
