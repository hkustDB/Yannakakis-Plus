create or replace view aggJoin8004982690099307891 as (
with aggView8730058383438328468 as (select id as v9, name as v71 from char_name as chn)
select person_id as v48, movie_id as v59, note as v20, role_id as v57, v71 from cast_info as ci, aggView8730058383438328468 where ci.person_role_id=aggView8730058383438328468.v9 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin5343461761424698659 as (
with aggView3440508670808075569 as (select id as v59, title as v73 from title as t where production_year>2010)
select movie_id as v59, company_id as v23, v73 from movie_companies as mc, aggView3440508670808075569 where mc.movie_id=aggView3440508670808075569.v59);
create or replace view aggJoin7787021960719326108 as (
with aggView5958749003173023209 as (select person_id as v48 from aka_name as an group by person_id)
select id as v48, name as v49, gender as v52 from name as n, aggView5958749003173023209 where n.id=aggView5958749003173023209.v48 and name LIKE '%An%' and gender= 'f');
create or replace view aggJoin3775084609246719019 as (
with aggView8746575997614212740 as (select v48, MIN(v49) as v72 from aggJoin7787021960719326108 group by v48)
select v59, v20, v57, v71 as v71, v72 from aggJoin8004982690099307891 join aggView8746575997614212740 using(v48));
create or replace view aggJoin2340659389546422554 as (
with aggView752085892319893162 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v59, info as v43 from movie_info as mi, aggView752085892319893162 where mi.info_type_id=aggView752085892319893162.v30 and ((info LIKE 'Japan:%201%') OR (info LIKE 'USA:%201%')));
create or replace view aggJoin2067155207930676405 as (
with aggView5260128463506108101 as (select id as v23 from company_name as cn where country_code= '[us]')
select v59, v73 from aggJoin5343461761424698659 join aggView5260128463506108101 using(v23));
create or replace view aggJoin9144891085995833467 as (
with aggView7296214665322228528 as (select v59, MIN(v73) as v73 from aggJoin2067155207930676405 group by v59,v73)
select movie_id as v59, keyword_id as v32, v73 from movie_keyword as mk, aggView7296214665322228528 where mk.movie_id=aggView7296214665322228528.v59);
create or replace view aggJoin3845691011230094262 as (
with aggView7833450389054818569 as (select id as v57 from role_type as rt where role= 'actress')
select v59, v20, v71, v72 from aggJoin3775084609246719019 join aggView7833450389054818569 using(v57));
create or replace view aggJoin4814663710757597334 as (
with aggView6174905645380040195 as (select id as v32 from keyword as k where keyword IN ('hero','martial-arts','hand-to-hand-combat'))
select v59, v73 from aggJoin9144891085995833467 join aggView6174905645380040195 using(v32));
create or replace view aggJoin1679156681797660035 as (
with aggView3463941779751355499 as (select v59, MIN(v73) as v73 from aggJoin4814663710757597334 group by v59,v73)
select v59, v20, v71 as v71, v72 as v72, v73 from aggJoin3845691011230094262 join aggView3463941779751355499 using(v59));
create or replace view aggJoin5275552812444701462 as (
with aggView342433113334072506 as (select v59, MIN(v71) as v71, MIN(v72) as v72, MIN(v73) as v73 from aggJoin1679156681797660035 group by v59,v73,v72,v71)
select v71, v72, v73 from aggJoin2340659389546422554 join aggView342433113334072506 using(v59));
select MIN(v71) as v71,MIN(v72) as v72,MIN(v73) as v73 from aggJoin5275552812444701462;
