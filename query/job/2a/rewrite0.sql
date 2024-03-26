create or replace view aggView3888229223247240257 as select id as v1 from company_name as cn where country_code= '[de]';
create or replace view aggJoin5587105112214710901 as select movie_id as v12 from movie_companies as mc, aggView3888229223247240257 where mc.company_id=aggView3888229223247240257.v1;
create or replace view aggView290303426424065210 as select v12 from aggJoin5587105112214710901 group by v12;
create or replace view aggJoin1259015041997158348 as select id as v12, title as v20 from title as t, aggView290303426424065210 where t.id=aggView290303426424065210.v12;
create or replace view aggView7503729284354794526 as select v12, MIN(v20) as v31 from aggJoin1259015041997158348 group by v12;
create or replace view aggJoin4831836574613931295 as select keyword_id as v18, v31 from movie_keyword as mk, aggView7503729284354794526 where mk.movie_id=aggView7503729284354794526.v12;
create or replace view aggView5701200542816350402 as select v18, MIN(v31) as v31 from aggJoin4831836574613931295 group by v18;
create or replace view aggJoin8677770459149855370 as select keyword as v9, v31 from keyword as k, aggView5701200542816350402 where k.id=aggView5701200542816350402.v18 and keyword= 'character-name-in-title';
select MIN(v31) as v31 from aggJoin8677770459149855370;
