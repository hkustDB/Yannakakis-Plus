create or replace view aggJoin8043186281181390244 as (
with aggView1311880214622528761 as (select id as v35, name as v60 from name as n where gender= 'f')
select person_id as v35, name as v3, v60 from aka_name as an, aggView1311880214622528761 where an.person_id=aggView1311880214622528761.v35);
create or replace view aggJoin8212979004062093176 as (
with aggView9012786289334210085 as (select v35, MIN(v60) as v60, MIN(v3) as v58 from aggJoin8043186281181390244 group by v35,v60)
select movie_id as v18, person_role_id as v9, note as v20, role_id as v22, v60, v58 from cast_info as ci, aggView9012786289334210085 where ci.person_id=aggView9012786289334210085.v35 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin7464371006348764047 as (
with aggView8405429257829327679 as (select id as v9, name as v59 from char_name as chn)
select v18, v20, v22, v60, v58, v59 from aggJoin8212979004062093176 join aggView8405429257829327679 using(v9));
create or replace view aggJoin835481976411666952 as (
with aggView8080263821378424040 as (select id as v22 from role_type as rt where role= 'actress')
select v18, v20, v60, v58, v59 from aggJoin7464371006348764047 join aggView8080263821378424040 using(v22));
create or replace view aggJoin1475983312634570471 as (
with aggView5233975414170051726 as (select v18, MIN(v60) as v60, MIN(v58) as v58, MIN(v59) as v59 from aggJoin835481976411666952 group by v18,v60,v59,v58)
select id as v18, title as v47, v60, v58, v59 from title as t, aggView5233975414170051726 where t.id=aggView5233975414170051726.v18);
create or replace view aggJoin3537780787915418196 as (
with aggView2499065936924986545 as (select v18, MIN(v60) as v60, MIN(v58) as v58, MIN(v59) as v59, MIN(v47) as v61 from aggJoin1475983312634570471 group by v18,v60,v59,v58)
select company_id as v32, v60, v58, v59, v61 from movie_companies as mc, aggView2499065936924986545 where mc.movie_id=aggView2499065936924986545.v18);
create or replace view aggJoin4065597593105976114 as (
with aggView2604108982887340050 as (select id as v32 from company_name as cn where country_code= '[us]')
select v60, v58, v59, v61 from aggJoin3537780787915418196 join aggView2604108982887340050 using(v32));
select MIN(v58) as v58,MIN(v59) as v59,MIN(v60) as v60,MIN(v61) as v61 from aggJoin4065597593105976114;
