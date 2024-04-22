create or replace view aggView8927897232613109912 as select name as v36, id as v35 from name as n where name LIKE '%An%' and gender= 'f';
create or replace view aggView7514268572004532559 as select person_id as v35, name as v3 from aka_name as an group by person_id,name;
create or replace view aggView1374712570189642041 as select name as v10, id as v9 from char_name as chn;
create or replace view aggJoin8262181016692590063 as (
with aggView9080686515420457264 as (select id as v32 from company_name as cn where country_code= '[us]')
select movie_id as v18 from movie_companies as mc, aggView9080686515420457264 where mc.company_id=aggView9080686515420457264.v32);
create or replace view aggJoin4802949481183784943 as (
with aggView5591013047112446160 as (select v18 from aggJoin8262181016692590063 group by v18)
select id as v18, title as v47 from title as t, aggView5591013047112446160 where t.id=aggView5591013047112446160.v18);
create or replace view aggView6121212155863297749 as select v18, v47 from aggJoin4802949481183784943 group by v18,v47;
create or replace view aggJoin3465116555662518148 as (
with aggView5702992040527791614 as (select v35, MIN(v36) as v60 from aggView8927897232613109912 group by v35)
select person_id as v35, movie_id as v18, person_role_id as v9, note as v20, role_id as v22, v60 from cast_info as ci, aggView5702992040527791614 where ci.person_id=aggView5702992040527791614.v35 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin313788842943588236 as (
with aggView2108065798039153225 as (select v35, MIN(v3) as v58 from aggView7514268572004532559 group by v35)
select v18, v9, v20, v22, v60 as v60, v58 from aggJoin3465116555662518148 join aggView2108065798039153225 using(v35));
create or replace view aggJoin8708643995524964645 as (
with aggView5506600116620676671 as (select v9, MIN(v10) as v59 from aggView1374712570189642041 group by v9)
select v18, v20, v22, v60 as v60, v58 as v58, v59 from aggJoin313788842943588236 join aggView5506600116620676671 using(v9));
create or replace view aggJoin4644215271003460818 as (
with aggView65894190114720997 as (select id as v22 from role_type as rt where role= 'actress')
select v18, v20, v60, v58, v59 from aggJoin8708643995524964645 join aggView65894190114720997 using(v22));
create or replace view aggJoin2941721388768737905 as (
with aggView5083294425994183273 as (select v18, MIN(v60) as v60, MIN(v58) as v58, MIN(v59) as v59 from aggJoin4644215271003460818 group by v18,v58,v60,v59)
select v47, v60, v58, v59 from aggView6121212155863297749 join aggView5083294425994183273 using(v18));
select MIN(v58) as v58,MIN(v59) as v59,MIN(v60) as v60,MIN(v47) as v61 from aggJoin2941721388768737905;
