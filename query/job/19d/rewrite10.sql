create or replace view aggJoin4896463625882325808 as (
with aggView7952794194491049591 as (select id as v42, name as v65 from name as n where gender= 'f')
select person_id as v42, v65 from aka_name as an, aggView7952794194491049591 where an.person_id=aggView7952794194491049591.v42);
create or replace view aggJoin450112440100235892 as (
with aggView4099285152943656998 as (select v42, MIN(v65) as v65 from aggJoin4896463625882325808 group by v42,v65)
select movie_id as v53, person_role_id as v9, note as v20, role_id as v51, v65 from cast_info as ci, aggView4099285152943656998 where ci.person_id=aggView4099285152943656998.v42 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin8475810269497822828 as (
with aggView8910180833953367482 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v53 from movie_companies as mc, aggView8910180833953367482 where mc.company_id=aggView8910180833953367482.v23);
create or replace view aggJoin6224972153888132686 as (
with aggView3538469841929824152 as (select v53 from aggJoin8475810269497822828 group by v53)
select id as v53, title as v54, production_year as v57 from title as t, aggView3538469841929824152 where t.id=aggView3538469841929824152.v53 and production_year>2000);
create or replace view aggJoin874989448772476716 as (
with aggView952830912890247229 as (select v53, MIN(v54) as v66 from aggJoin6224972153888132686 group by v53)
select v53, v9, v20, v51, v65 as v65, v66 from aggJoin450112440100235892 join aggView952830912890247229 using(v53));
create or replace view aggJoin7107686410616124886 as (
with aggView1148710480572965083 as (select id as v51 from role_type as rt where role= 'actress')
select v53, v9, v20, v65, v66 from aggJoin874989448772476716 join aggView1148710480572965083 using(v51));
create or replace view aggJoin6022517201139604962 as (
with aggView1822138059972310637 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v53 from movie_info as mi, aggView1822138059972310637 where mi.info_type_id=aggView1822138059972310637.v30);
create or replace view aggJoin403515279510789132 as (
with aggView5312597170105195792 as (select id as v9 from char_name as chn)
select v53, v20, v65, v66 from aggJoin7107686410616124886 join aggView5312597170105195792 using(v9));
create or replace view aggJoin4835630283966248572 as (
with aggView5579497434754284687 as (select v53, MIN(v65) as v65, MIN(v66) as v66 from aggJoin403515279510789132 group by v53,v65,v66)
select v65, v66 from aggJoin6022517201139604962 join aggView5579497434754284687 using(v53));
select MIN(v65) as v65,MIN(v66) as v66 from aggJoin4835630283966248572;
