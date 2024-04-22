create or replace view aggView1495687756834773310 as select person_id as v35, name as v3 from aka_name as an group by person_id,name;
create or replace view aggView1289475922057411464 as select id as v9, name as v10 from char_name as chn;
create or replace view aggView672261261183351684 as select name as v36, id as v35 from name as n where gender= 'f';
create or replace view aggJoin2518039797303722170 as (
with aggView6294366891244694729 as (select id as v32 from company_name as cn where country_code= '[us]')
select movie_id as v18 from movie_companies as mc, aggView6294366891244694729 where mc.company_id=aggView6294366891244694729.v32);
create or replace view aggJoin5412812106760774581 as (
with aggView8362933174580637429 as (select v18 from aggJoin2518039797303722170 group by v18)
select id as v18, title as v47 from title as t, aggView8362933174580637429 where t.id=aggView8362933174580637429.v18);
create or replace view aggView979548230668620526 as select v18, v47 from aggJoin5412812106760774581 group by v18,v47;
create or replace view aggJoin6762421491051912529 as (
with aggView2700625308770046384 as (select v9, MIN(v10) as v59 from aggView1289475922057411464 group by v9)
select person_id as v35, movie_id as v18, note as v20, role_id as v22, v59 from cast_info as ci, aggView2700625308770046384 where ci.person_role_id=aggView2700625308770046384.v9 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin1700327600141528477 as (
with aggView3152134873496143560 as (select v35, MIN(v36) as v60 from aggView672261261183351684 group by v35)
select v35, v3, v60 from aggView1495687756834773310 join aggView3152134873496143560 using(v35));
create or replace view aggJoin1661701003768640836 as (
with aggView5340181696278436706 as (select v35, MIN(v60) as v60, MIN(v3) as v58 from aggJoin1700327600141528477 group by v35,v60)
select v18, v20, v22, v59 as v59, v60, v58 from aggJoin6762421491051912529 join aggView5340181696278436706 using(v35));
create or replace view aggJoin7956627611229016446 as (
with aggView4733744535322560667 as (select id as v22 from role_type as rt where role= 'actress')
select v18, v20, v59, v60, v58 from aggJoin1661701003768640836 join aggView4733744535322560667 using(v22));
create or replace view aggJoin3934034364881342372 as (
with aggView6456651726860371614 as (select v18, MIN(v59) as v59, MIN(v60) as v60, MIN(v58) as v58 from aggJoin7956627611229016446 group by v18,v60,v59,v58)
select v47, v59, v60, v58 from aggView979548230668620526 join aggView6456651726860371614 using(v18));
select MIN(v58) as v58,MIN(v59) as v59,MIN(v60) as v60,MIN(v47) as v61 from aggJoin3934034364881342372;
