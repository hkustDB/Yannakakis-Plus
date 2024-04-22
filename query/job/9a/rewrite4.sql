create or replace view aggView4908565396382607522 as select name as v10, id as v9 from char_name as chn;
create or replace view aggView3811287185164665004 as select id as v18, title as v47 from title as t where production_year>=2005 and production_year<=2015;
create or replace view aggJoin8811004617741152004 as (
with aggView7414273647149677386 as (select id as v35 from name as n where gender= 'f' and name LIKE '%Ang%')
select person_id as v35, name as v3 from aka_name as an, aggView7414273647149677386 where an.person_id=aggView7414273647149677386.v35);
create or replace view aggView4317592418553225270 as select v3, v35 from aggJoin8811004617741152004 group by v3,v35;
create or replace view aggJoin2794430578493351702 as (
with aggView3540808631497058993 as (select v9, MIN(v10) as v59 from aggView4908565396382607522 group by v9)
select person_id as v35, movie_id as v18, note as v20, role_id as v22, v59 from cast_info as ci, aggView3540808631497058993 where ci.person_role_id=aggView3540808631497058993.v9 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin227954007332202332 as (
with aggView4595155268979841671 as (select v35, MIN(v3) as v58 from aggView4317592418553225270 group by v35)
select v18, v20, v22, v59 as v59, v58 from aggJoin2794430578493351702 join aggView4595155268979841671 using(v35));
create or replace view aggJoin7417390870767092772 as (
with aggView6549315085942880782 as (select id as v32 from company_name as cn where country_code= '[us]')
select movie_id as v18, note as v34 from movie_companies as mc, aggView6549315085942880782 where mc.company_id=aggView6549315085942880782.v32 and ((note LIKE '%(USA)%') OR (note LIKE '%(worldwide)%')));
create or replace view aggJoin6809255709937159790 as (
with aggView342427569592951715 as (select id as v22 from role_type as rt where role= 'actress')
select v18, v20, v59, v58 from aggJoin227954007332202332 join aggView342427569592951715 using(v22));
create or replace view aggJoin7780833890325320579 as (
with aggView5541094874565505884 as (select v18 from aggJoin7417390870767092772 group by v18)
select v18, v20, v59 as v59, v58 as v58 from aggJoin6809255709937159790 join aggView5541094874565505884 using(v18));
create or replace view aggJoin8784916988330555278 as (
with aggView6654242944140184987 as (select v18, MIN(v59) as v59, MIN(v58) as v58 from aggJoin7780833890325320579 group by v18,v59,v58)
select v47, v59, v58 from aggView3811287185164665004 join aggView6654242944140184987 using(v18));
select MIN(v58) as v58,MIN(v59) as v59,MIN(v47) as v60 from aggJoin8784916988330555278;
