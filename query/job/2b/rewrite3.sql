create or replace view aggView7906500821651916430 as select id as v12, title as v31 from title as t;
create or replace view aggJoin5564468314060409023 as select movie_id as v12, company_id as v1, v31 from movie_companies as mc, aggView7906500821651916430 where mc.movie_id=aggView7906500821651916430.v12;
create or replace view aggView830222862480709546 as select id as v1 from company_name as cn where country_code= '[nl]';
create or replace view aggJoin976618695188559618 as select v12, v31 from aggJoin5564468314060409023 join aggView830222862480709546 using(v1);
create or replace view aggView3274216512457759978 as select v12, MIN(v31) as v31 from aggJoin976618695188559618 group by v12,v31;
create or replace view aggJoin2216687249132676913 as select keyword_id as v18, v31 from movie_keyword as mk, aggView3274216512457759978 where mk.movie_id=aggView3274216512457759978.v12;
create or replace view aggView8857813787565162598 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin5744539113853031419 as select v31 from aggJoin2216687249132676913 join aggView8857813787565162598 using(v18);
select MIN(v31) as v31 from aggJoin5744539113853031419;
