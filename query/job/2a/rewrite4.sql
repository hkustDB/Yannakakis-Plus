create or replace view aggView5275798945138322761 as select id as v12, title as v31 from title as t;
create or replace view aggJoin8443860408263387436 as select movie_id as v12, company_id as v1, v31 from movie_companies as mc, aggView5275798945138322761 where mc.movie_id=aggView5275798945138322761.v12;
create or replace view aggView1895784480085179262 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin3372591740344246903 as select movie_id as v12 from movie_keyword as mk, aggView1895784480085179262 where mk.keyword_id=aggView1895784480085179262.v18;
create or replace view aggView3757507923047616416 as select id as v1 from company_name as cn where country_code= '[de]';
create or replace view aggJoin6266525153724923175 as select v12, v31 from aggJoin8443860408263387436 join aggView3757507923047616416 using(v1);
create or replace view aggView3567724702592894045 as select v12, MIN(v31) as v31 from aggJoin6266525153724923175 group by v12;
create or replace view aggJoin2938907479390679455 as select v31 from aggJoin3372591740344246903 join aggView3567724702592894045 using(v12);
select MIN(v31) as v31 from aggJoin2938907479390679455;
