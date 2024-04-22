create or replace view aggJoin3729974877834522345 as (
with aggView5601758411183609982 as (select id as v42, name as v65 from name as n where name LIKE '%An%' and gender= 'f')
select person_id as v42, v65 from aka_name as an, aggView5601758411183609982 where an.person_id=aggView5601758411183609982.v42);
create or replace view aggJoin8813035735601060678 as (
with aggView346928997446231071 as (select id as v51 from role_type as rt where role= 'actress')
select person_id as v42, movie_id as v53, person_role_id as v9, note as v20 from cast_info as ci, aggView346928997446231071 where ci.role_id=aggView346928997446231071.v51 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin381049759359599813 as (
with aggView6978935269566112600 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v53, info as v40 from movie_info as mi, aggView6978935269566112600 where mi.info_type_id=aggView6978935269566112600.v30 and ((info LIKE 'Japan:%200%') OR (info LIKE 'USA:%200%')));
create or replace view aggJoin988628595316325565 as (
with aggView933550730946775219 as (select v42, MIN(v65) as v65 from aggJoin3729974877834522345 group by v42,v65)
select v53, v9, v20, v65 from aggJoin8813035735601060678 join aggView933550730946775219 using(v42));
create or replace view aggJoin6149331400824701375 as (
with aggView95981552865400293 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v53 from movie_companies as mc, aggView95981552865400293 where mc.company_id=aggView95981552865400293.v23);
create or replace view aggJoin1058564544564376162 as (
with aggView388180949293587207 as (select id as v9 from char_name as chn)
select v53, v20, v65 from aggJoin988628595316325565 join aggView388180949293587207 using(v9));
create or replace view aggJoin4574069473283956809 as (
with aggView1022710195786700685 as (select v53 from aggJoin381049759359599813 group by v53)
select id as v53, title as v54, production_year as v57 from title as t, aggView1022710195786700685 where t.id=aggView1022710195786700685.v53 and production_year>2000);
create or replace view aggJoin2240862844699530822 as (
with aggView8819401998462613442 as (select v53, MIN(v54) as v66 from aggJoin4574069473283956809 group by v53)
select v53, v20, v65 as v65, v66 from aggJoin1058564544564376162 join aggView8819401998462613442 using(v53));
create or replace view aggJoin4581896524338415632 as (
with aggView7133081925704943898 as (select v53, MIN(v65) as v65, MIN(v66) as v66 from aggJoin2240862844699530822 group by v53,v66,v65)
select v65, v66 from aggJoin6149331400824701375 join aggView7133081925704943898 using(v53));
select MIN(v65) as v65,MIN(v66) as v66 from aggJoin4581896524338415632;
