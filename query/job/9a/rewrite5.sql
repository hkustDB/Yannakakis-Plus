create or replace view aggView7202961470996405302 as select name as v10, id as v9 from char_name as chn;
create or replace view aggView5795023705774852630 as select id as v18, title as v47 from title as t where production_year>=2005 and production_year<=2015;
create or replace view aggJoin2309886826128066162 as (
with aggView5066235672529921139 as (select id as v35 from name as n where gender= 'f' and name LIKE '%Ang%')
select person_id as v35, name as v3 from aka_name as an, aggView5066235672529921139 where an.person_id=aggView5066235672529921139.v35);
create or replace view aggView6645542586498936803 as select v3, v35 from aggJoin2309886826128066162 group by v3,v35;
create or replace view aggJoin8096477261874691875 as (
with aggView391636032262381932 as (select v18, MIN(v47) as v60 from aggView5795023705774852630 group by v18)
select person_id as v35, movie_id as v18, person_role_id as v9, note as v20, role_id as v22, v60 from cast_info as ci, aggView391636032262381932 where ci.movie_id=aggView391636032262381932.v18 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin2445600257308052961 as (
with aggView6487395427352389834 as (select v9, MIN(v10) as v59 from aggView7202961470996405302 group by v9)
select v35, v18, v20, v22, v60 as v60, v59 from aggJoin8096477261874691875 join aggView6487395427352389834 using(v9));
create or replace view aggJoin3878773373779000880 as (
with aggView8157484320333223377 as (select id as v32 from company_name as cn where country_code= '[us]')
select movie_id as v18, note as v34 from movie_companies as mc, aggView8157484320333223377 where mc.company_id=aggView8157484320333223377.v32 and ((note LIKE '%(USA)%') OR (note LIKE '%(worldwide)%')));
create or replace view aggJoin8692211939405199230 as (
with aggView7328781241761097925 as (select id as v22 from role_type as rt where role= 'actress')
select v35, v18, v20, v60, v59 from aggJoin2445600257308052961 join aggView7328781241761097925 using(v22));
create or replace view aggJoin6158691461815015995 as (
with aggView8118964054174672034 as (select v18 from aggJoin3878773373779000880 group by v18)
select v35, v20, v60 as v60, v59 as v59 from aggJoin8692211939405199230 join aggView8118964054174672034 using(v18));
create or replace view aggJoin4446632662838337435 as (
with aggView6233652406258500204 as (select v35, MIN(v60) as v60, MIN(v59) as v59 from aggJoin6158691461815015995 group by v35,v59,v60)
select v3, v60, v59 from aggView6645542586498936803 join aggView6233652406258500204 using(v35));
select MIN(v3) as v58,MIN(v59) as v59,MIN(v60) as v60 from aggJoin4446632662838337435;
