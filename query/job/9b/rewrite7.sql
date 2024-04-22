create or replace view aggView3727393188743637078 as select id as v9, name as v10 from char_name as chn;
create or replace view aggView1611772202640572306 as select title as v47, id as v18 from title as t where production_year>=2007 and production_year<=2010;
create or replace view aggJoin6987724379072659494 as (
with aggView7113071816456190348 as (select name as v36, id as v35 from name as n where gender= 'f')
select v35, v36 from aggView7113071816456190348 where v36 LIKE '%Angel%');
create or replace view aggView7036643217827022621 as select name as v3, person_id as v35 from aka_name as an group by name,person_id;
create or replace view aggJoin3690109685877418858 as (
with aggView6346149496314425242 as (select v18, MIN(v47) as v61 from aggView1611772202640572306 group by v18)
select person_id as v35, movie_id as v18, person_role_id as v9, note as v20, role_id as v22, v61 from cast_info as ci, aggView6346149496314425242 where ci.movie_id=aggView6346149496314425242.v18 and note= '(voice)');
create or replace view aggJoin7399134483624019818 as (
with aggView6234709990886012157 as (select v9, MIN(v10) as v59 from aggView3727393188743637078 group by v9)
select v35, v18, v20, v22, v61 as v61, v59 from aggJoin3690109685877418858 join aggView6234709990886012157 using(v9));
create or replace view aggJoin3975642117683006511 as (
with aggView9202598903824800152 as (select id as v22 from role_type as rt where role= 'actress')
select v35, v18, v20, v61, v59 from aggJoin7399134483624019818 join aggView9202598903824800152 using(v22));
create or replace view aggJoin443315540127857046 as (
with aggView7278679184612071795 as (select id as v32 from company_name as cn where country_code= '[us]')
select movie_id as v18, note as v34 from movie_companies as mc, aggView7278679184612071795 where mc.company_id=aggView7278679184612071795.v32 and ((note LIKE '%(USA)%') OR (note LIKE '%(worldwide)%')) and note LIKE '%(200%)%');
create or replace view aggJoin5070418174578827301 as (
with aggView7276468218553713891 as (select v18 from aggJoin443315540127857046 group by v18)
select v35, v20, v61 as v61, v59 as v59 from aggJoin3975642117683006511 join aggView7276468218553713891 using(v18));
create or replace view aggJoin4298546554333040476 as (
with aggView7745258853062386664 as (select v35, MIN(v61) as v61, MIN(v59) as v59 from aggJoin5070418174578827301 group by v35,v59,v61)
select v35, v36, v61, v59 from aggJoin6987724379072659494 join aggView7745258853062386664 using(v35));
create or replace view aggJoin6335985858741909626 as (
with aggView8282433713501488127 as (select v35, MIN(v61) as v61, MIN(v59) as v59, MIN(v36) as v60 from aggJoin4298546554333040476 group by v35,v59,v61)
select v3, v61, v59, v60 from aggView7036643217827022621 join aggView8282433713501488127 using(v35));
select MIN(v3) as v58,MIN(v59) as v59,MIN(v60) as v60,MIN(v61) as v61 from aggJoin6335985858741909626;
