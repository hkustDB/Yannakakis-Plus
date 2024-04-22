create or replace view aggJoin8938663407376135046 as (
with aggView5586423493856771282 as (select name as v49, id as v48 from name as n where gender= 'f')
select v48, v49 from aggView5586423493856771282 where v49 LIKE '%An%');
create or replace view aggView1159016887616490859 as select id as v9, name as v10 from char_name as chn;
create or replace view aggJoin1985873415908155372 as (
with aggView3200881134067350635 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v59, info as v43 from movie_info as mi, aggView3200881134067350635 where mi.info_type_id=aggView3200881134067350635.v30 and ((info LIKE 'Japan:%201%') OR (info LIKE 'USA:%201%')));
create or replace view aggJoin3618797400749918776 as (
with aggView1685177450126081795 as (select v59 from aggJoin1985873415908155372 group by v59)
select movie_id as v59, keyword_id as v32 from movie_keyword as mk, aggView1685177450126081795 where mk.movie_id=aggView1685177450126081795.v59);
create or replace view aggJoin933096233866341487 as (
with aggView9060792281541224608 as (select id as v32 from keyword as k where keyword IN ('hero','martial-arts','hand-to-hand-combat','computer-animated-movie'))
select v59 from aggJoin3618797400749918776 join aggView9060792281541224608 using(v32));
create or replace view aggJoin1556755130919155683 as (
with aggView4663665569887676289 as (select v59 from aggJoin933096233866341487 group by v59)
select id as v59, title as v60, production_year as v63 from title as t, aggView4663665569887676289 where t.id=aggView4663665569887676289.v59 and production_year>2010);
create or replace view aggJoin6976642538826498697 as (
with aggView5534717921869590399 as (select v59, v60 from aggJoin1556755130919155683 group by v59,v60)
select v59, v60 from aggView5534717921869590399 where v60 LIKE 'Kung Fu Panda%');
create or replace view aggJoin2915631639038122227 as (
with aggView5968597012032043299 as (select v9, MIN(v10) as v71 from aggView1159016887616490859 group by v9)
select person_id as v48, movie_id as v59, note as v20, role_id as v57, v71 from cast_info as ci, aggView5968597012032043299 where ci.person_role_id=aggView5968597012032043299.v9 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin4658356054785039935 as (
with aggView469347322617210703 as (select v48, MIN(v49) as v72 from aggJoin8938663407376135046 group by v48)
select v48, v59, v20, v57, v71 as v71, v72 from aggJoin2915631639038122227 join aggView469347322617210703 using(v48));
create or replace view aggJoin2132204957277861908 as (
with aggView6923585393187407587 as (select id as v57 from role_type as rt where role= 'actress')
select v48, v59, v20, v71, v72 from aggJoin4658356054785039935 join aggView6923585393187407587 using(v57));
create or replace view aggJoin6973736401810660493 as (
with aggView8621426447213016154 as (select person_id as v48 from aka_name as an group by person_id)
select v59, v20, v71 as v71, v72 as v72 from aggJoin2132204957277861908 join aggView8621426447213016154 using(v48));
create or replace view aggJoin3378955904478375121 as (
with aggView6200994482126884574 as (select id as v23 from company_name as cn where country_code= '[us]' and name= 'DreamWorks Animation')
select movie_id as v59 from movie_companies as mc, aggView6200994482126884574 where mc.company_id=aggView6200994482126884574.v23);
create or replace view aggJoin8687240538984174239 as (
with aggView3556814983762545616 as (select v59 from aggJoin3378955904478375121 group by v59)
select v59, v20, v71 as v71, v72 as v72 from aggJoin6973736401810660493 join aggView3556814983762545616 using(v59));
create or replace view aggJoin653807223603531121 as (
with aggView9180537687448551859 as (select v59, MIN(v71) as v71, MIN(v72) as v72 from aggJoin8687240538984174239 group by v59,v72,v71)
select v60, v71, v72 from aggJoin6976642538826498697 join aggView9180537687448551859 using(v59));
select MIN(v71) as v71,MIN(v72) as v72,MIN(v60) as v73 from aggJoin653807223603531121;
