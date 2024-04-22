create or replace view aggJoin6839999713393211074 as (
with aggView4312176678305519718 as (select id as v18 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v12 from movie_keyword as mk, aggView4312176678305519718 where mk.keyword_id=aggView4312176678305519718.v18);
create or replace view aggJoin8095409494816394392 as (
with aggView8825242538118550901 as (select v12 from aggJoin6839999713393211074 group by v12)
select id as v12, title as v20 from title as t, aggView8825242538118550901 where t.id=aggView8825242538118550901.v12);
create or replace view aggJoin2932578763524430605 as (
with aggView747014444625959740 as (select id as v1 from company_name as cn where country_code= '[de]')
select movie_id as v12 from movie_companies as mc, aggView747014444625959740 where mc.company_id=aggView747014444625959740.v1);
create or replace view aggJoin5392168396282559341 as (
with aggView7242097476750738534 as (select v12 from aggJoin2932578763524430605 group by v12)
select v20 from aggJoin8095409494816394392 join aggView7242097476750738534 using(v12));
create or replace view aggView4683985878144597205 as select v20 from aggJoin5392168396282559341 group by v20;
select MIN(v20) as v31 from aggView4683985878144597205;
