create or replace view aggView3708629484897465968 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin1175522936285830831 as select movie_id as v23, v35 from movie_keyword as mk, aggView3708629484897465968 where mk.keyword_id=aggView3708629484897465968.v8;
create or replace view aggView6386537743486556543 as select v23, MIN(v35) as v35 from aggJoin1175522936285830831 group by v23;
create or replace view aggJoin7285565851518877223 as select id as v23, title as v24, production_year as v27, v35 from title as t, aggView6386537743486556543 where t.id=aggView6386537743486556543.v23 and production_year>2000;
create or replace view aggView8682927158176518113 as select v23, MIN(v35) as v35, MIN(v24) as v37 from aggJoin7285565851518877223 group by v23;
create or replace view aggJoin8061439476456210513 as select person_id as v14, v35, v37 from cast_info as ci, aggView8682927158176518113 where ci.movie_id=aggView8682927158176518113.v23;
create or replace view aggView3062724760200691919 as select v14, MIN(v35) as v35, MIN(v37) as v37 from aggJoin8061439476456210513 group by v14;
create or replace view aggJoin3998928281333854180 as select name as v15, v35, v37 from name as n, aggView3062724760200691919 where n.id=aggView3062724760200691919.v14;
select MIN(v35) as v35,MIN(v15) as v36,MIN(v37) as v37 from aggJoin3998928281333854180;
