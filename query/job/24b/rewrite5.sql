create or replace view aggJoin1204916717014106559 as (
with aggView371406653270038291 as (select name as v49, id as v48 from name as n where gender= 'f')
select v48, v49 from aggView371406653270038291 where v49 LIKE '%An%');
create or replace view aggView1973310170809339978 as select id as v9, name as v10 from char_name as chn;
create or replace view aggJoin326692262128313554 as (
with aggView3101710917695504030 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v59, info as v43 from movie_info as mi, aggView3101710917695504030 where mi.info_type_id=aggView3101710917695504030.v30 and ((info LIKE 'Japan:%201%') OR (info LIKE 'USA:%201%')));
create or replace view aggJoin6298559387911812782 as (
with aggView4327656062909238443 as (select id as v32 from keyword as k where keyword IN ('hero','martial-arts','hand-to-hand-combat','computer-animated-movie'))
select movie_id as v59 from movie_keyword as mk, aggView4327656062909238443 where mk.keyword_id=aggView4327656062909238443.v32);
create or replace view aggJoin4756300852841765583 as (
with aggView8743850747062156990 as (select v59 from aggJoin6298559387911812782 group by v59)
select id as v59, title as v60, production_year as v63 from title as t, aggView8743850747062156990 where t.id=aggView8743850747062156990.v59 and production_year>2010);
create or replace view aggJoin98862810357380818 as (
with aggView7906886258025731002 as (select v59 from aggJoin326692262128313554 group by v59)
select movie_id as v59, company_id as v23 from movie_companies as mc, aggView7906886258025731002 where mc.movie_id=aggView7906886258025731002.v59);
create or replace view aggJoin1921219578202163809 as (
with aggView8768811196863396175 as (select id as v23 from company_name as cn where country_code= '[us]' and name= 'DreamWorks Animation')
select v59 from aggJoin98862810357380818 join aggView8768811196863396175 using(v23));
create or replace view aggJoin7097646517854541416 as (
with aggView7422881468397989052 as (select v59 from aggJoin1921219578202163809 group by v59)
select v59, v60, v63 from aggJoin4756300852841765583 join aggView7422881468397989052 using(v59));
create or replace view aggJoin6370695128073730612 as (
with aggView7342873358557421587 as (select v59, v60 from aggJoin7097646517854541416 group by v59,v60)
select v59, v60 from aggView7342873358557421587 where v60 LIKE 'Kung Fu Panda%');
create or replace view aggJoin3603632846724373489 as (
with aggView7425248190218968329 as (select v9, MIN(v10) as v71 from aggView1973310170809339978 group by v9)
select person_id as v48, movie_id as v59, note as v20, role_id as v57, v71 from cast_info as ci, aggView7425248190218968329 where ci.person_role_id=aggView7425248190218968329.v9 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin189305009009316452 as (
with aggView215213937746377428 as (select v59, MIN(v60) as v73 from aggJoin6370695128073730612 group by v59)
select v48, v20, v57, v71 as v71, v73 from aggJoin3603632846724373489 join aggView215213937746377428 using(v59));
create or replace view aggJoin6809583092409074336 as (
with aggView4015954049888938390 as (select id as v57 from role_type as rt where role= 'actress')
select v48, v20, v71, v73 from aggJoin189305009009316452 join aggView4015954049888938390 using(v57));
create or replace view aggJoin7896393118034510692 as (
with aggView6130430753212697659 as (select person_id as v48 from aka_name as an group by person_id)
select v48, v20, v71 as v71, v73 as v73 from aggJoin6809583092409074336 join aggView6130430753212697659 using(v48));
create or replace view aggJoin8997390632450120661 as (
with aggView2961728568698535488 as (select v48, MIN(v71) as v71, MIN(v73) as v73 from aggJoin7896393118034510692 group by v48,v71,v73)
select v49, v71, v73 from aggJoin1204916717014106559 join aggView2961728568698535488 using(v48));
select MIN(v71) as v71,MIN(v49) as v72,MIN(v73) as v73 from aggJoin8997390632450120661;
