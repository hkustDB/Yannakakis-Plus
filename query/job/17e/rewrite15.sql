create or replace view aggJoin3044724374598874967 as (
with aggView3798385917899293886 as (select id as v26, name as v47 from name as n)
select movie_id as v3, v47 from cast_info as ci, aggView3798385917899293886 where ci.person_id=aggView3798385917899293886.v26);
create or replace view aggJoin3124633762661517129 as (
with aggView577414520816987990 as (select id as v20 from company_name as cn where country_code= '[us]')
select movie_id as v3 from movie_companies as mc, aggView577414520816987990 where mc.company_id=aggView577414520816987990.v20);
create or replace view aggJoin591277895543414512 as (
with aggView6406291246830827422 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView6406291246830827422 where mk.keyword_id=aggView6406291246830827422.v25);
create or replace view aggJoin7504518222749020480 as (
with aggView5667097244319321355 as (select v3 from aggJoin591277895543414512 group by v3)
select v3 from aggJoin3124633762661517129 join aggView5667097244319321355 using(v3));
create or replace view aggJoin4836267584770276300 as (
with aggView3572295301661331449 as (select v3 from aggJoin7504518222749020480 group by v3)
select id as v3 from title as t, aggView3572295301661331449 where t.id=aggView3572295301661331449.v3);
create or replace view aggJoin1843258757789133885 as (
with aggView5962672466887532965 as (select v3 from aggJoin4836267584770276300 group by v3)
select v47 as v47 from aggJoin3044724374598874967 join aggView5962672466887532965 using(v3));
select MIN(v47) as v47 from aggJoin1843258757789133885;
