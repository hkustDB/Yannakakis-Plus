create or replace view aggView853963432011985545 as select id as v12, title as v31 from title as t;
create or replace view aggJoin8388872766824711360 as select movie_id as v12, company_id as v1, v31 from movie_companies as mc, aggView853963432011985545 where mc.movie_id=aggView853963432011985545.v12;
create or replace view aggView7079578933794523641 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin1206537321053627704 as select movie_id as v12 from movie_keyword as mk, aggView7079578933794523641 where mk.keyword_id=aggView7079578933794523641.v18;
create or replace view aggView3484666158308215773 as select v12 from aggJoin1206537321053627704 group by v12;
create or replace view aggJoin3063184833778120820 as select v1, v31 as v31 from aggJoin8388872766824711360 join aggView3484666158308215773 using(v12);
create or replace view aggView9205469061956569397 as select v1, MIN(v31) as v31 from aggJoin3063184833778120820 group by v1;
create or replace view aggJoin7668799211998424362 as select country_code as v3, v31 from company_name as cn, aggView9205469061956569397 where cn.id=aggView9205469061956569397.v1 and country_code= '[nl]';
select MIN(v31) as v31 from aggJoin7668799211998424362;
