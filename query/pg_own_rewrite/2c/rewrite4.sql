create or replace view aggView3235756697307232393 as select id as v1 from company_name as cn where country_code= '[sm]';
create or replace view aggJoin7711391341454337762 as select movie_id as v12 from movie_companies as mc, aggView3235756697307232393 where mc.company_id=aggView3235756697307232393.v1;
create or replace view aggView5163289915406762778 as select v12 from aggJoin7711391341454337762 group by v12;
create or replace view aggJoin7555376961102010307 as select id as v12, title as v20 from title as t, aggView5163289915406762778 where t.id=aggView5163289915406762778.v12;
create or replace view aggView7201394023489754358 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin5597779316841223158 as select movie_id as v12 from movie_keyword as mk, aggView7201394023489754358 where mk.keyword_id=aggView7201394023489754358.v18;
create or replace view aggView3806563068377587967 as select v12, MIN(v20) as v31 from aggJoin7555376961102010307 group by v12;
create or replace view aggJoin4469369641876898658 as select v31 from aggJoin5597779316841223158 join aggView3806563068377587967 using(v12);
select MIN(v31) as v31 from aggJoin4469369641876898658;
