create or replace view aggView814322952848667906 as select id as v12, title as v31 from title as t;
create or replace view aggJoin4294160589907972532 as select movie_id as v12, keyword_id as v18, v31 from movie_keyword as mk, aggView814322952848667906 where mk.movie_id=aggView814322952848667906.v12;
create or replace view aggView5209151137148251997 as select id as v1 from company_name as cn where country_code= '[sm]';
create or replace view aggJoin3671832541530577540 as select movie_id as v12 from movie_companies as mc, aggView5209151137148251997 where mc.company_id=aggView5209151137148251997.v1;
create or replace view aggView7459286013903175627 as select v12 from aggJoin3671832541530577540 group by v12;
create or replace view aggJoin2179110466166158456 as select v18, v31 as v31 from aggJoin4294160589907972532 join aggView7459286013903175627 using(v12);
create or replace view aggView4245649319608672632 as select v18, MIN(v31) as v31 from aggJoin2179110466166158456 group by v18;
create or replace view aggJoin3911495973638350914 as select keyword as v9, v31 from keyword as k, aggView4245649319608672632 where k.id=aggView4245649319608672632.v18 and keyword= 'character-name-in-title';
select MIN(v31) as v31 from aggJoin3911495973638350914;
