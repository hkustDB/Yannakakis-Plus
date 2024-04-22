create or replace view aggJoin8054976948267746337 as (
with aggView3324749279497010878 as (select id as v35, name as v60 from name as n where name LIKE '%An%' and gender= 'f')
select person_id as v35, name as v3, v60 from aka_name as an, aggView3324749279497010878 where an.person_id=aggView3324749279497010878.v35);
create or replace view aggJoin5533467938610092281 as (
with aggView6243392339987824226 as (select v35, MIN(v60) as v60, MIN(v3) as v58 from aggJoin8054976948267746337 group by v35,v60)
select movie_id as v18, person_role_id as v9, note as v20, role_id as v22, v60, v58 from cast_info as ci, aggView6243392339987824226 where ci.person_id=aggView6243392339987824226.v35 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin3724964345114424678 as (
with aggView1417590940097561595 as (select id as v18, title as v61 from title as t)
select v18, v9, v20, v22, v60, v58, v61 from aggJoin5533467938610092281 join aggView1417590940097561595 using(v18));
create or replace view aggJoin1797635574738100200 as (
with aggView3678585857355740898 as (select id as v22 from role_type as rt where role= 'actress')
select v18, v9, v20, v60, v58, v61 from aggJoin3724964345114424678 join aggView3678585857355740898 using(v22));
create or replace view aggJoin8183548610901695690 as (
with aggView5508302907862585828 as (select id as v32 from company_name as cn where country_code= '[us]')
select movie_id as v18 from movie_companies as mc, aggView5508302907862585828 where mc.company_id=aggView5508302907862585828.v32);
create or replace view aggJoin3681357930278425156 as (
with aggView4341024859857056954 as (select v18 from aggJoin8183548610901695690 group by v18)
select v9, v20, v60 as v60, v58 as v58, v61 as v61 from aggJoin1797635574738100200 join aggView4341024859857056954 using(v18));
create or replace view aggJoin8057646086345809535 as (
with aggView6554203877920192976 as (select v9, MIN(v60) as v60, MIN(v58) as v58, MIN(v61) as v61 from aggJoin3681357930278425156 group by v9,v61,v60,v58)
select name as v10, v60, v58, v61 from char_name as chn, aggView6554203877920192976 where chn.id=aggView6554203877920192976.v9);
select MIN(v58) as v58,MIN(v10) as v59,MIN(v60) as v60,MIN(v61) as v61 from aggJoin8057646086345809535;
