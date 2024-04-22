create or replace view aggView1487652545404300739 as select person_id as v35, name as v3 from aka_name as an group by person_id,name;
create or replace view aggView8228363451431999889 as select id as v9, name as v10 from char_name as chn;
create or replace view aggView1868282726701105924 as select name as v36, id as v35 from name as n where gender= 'f';
create or replace view aggJoin3565989819566141945 as (
with aggView7157289513161032064 as (select id as v32 from company_name as cn where country_code= '[us]')
select movie_id as v18 from movie_companies as mc, aggView7157289513161032064 where mc.company_id=aggView7157289513161032064.v32);
create or replace view aggJoin4113926971021651507 as (
with aggView4402785585675874090 as (select v18 from aggJoin3565989819566141945 group by v18)
select id as v18, title as v47 from title as t, aggView4402785585675874090 where t.id=aggView4402785585675874090.v18);
create or replace view aggView2396515760762656740 as select v18, v47 from aggJoin4113926971021651507 group by v18,v47;
create or replace view aggJoin963370614894121017 as (
with aggView5148127034176545755 as (select v9, MIN(v10) as v59 from aggView8228363451431999889 group by v9)
select person_id as v35, movie_id as v18, note as v20, role_id as v22, v59 from cast_info as ci, aggView5148127034176545755 where ci.person_role_id=aggView5148127034176545755.v9 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin523754644522241357 as (
with aggView6687164143052406931 as (select v18, MIN(v47) as v61 from aggView2396515760762656740 group by v18)
select v35, v20, v22, v59 as v59, v61 from aggJoin963370614894121017 join aggView6687164143052406931 using(v18));
create or replace view aggJoin7007472183545049485 as (
with aggView8530407288493078542 as (select id as v22 from role_type as rt where role= 'actress')
select v35, v20, v59, v61 from aggJoin523754644522241357 join aggView8530407288493078542 using(v22));
create or replace view aggJoin228940568541993249 as (
with aggView3745167932467217081 as (select v35, MIN(v59) as v59, MIN(v61) as v61 from aggJoin7007472183545049485 group by v35,v59,v61)
select v36, v35, v59, v61 from aggView1868282726701105924 join aggView3745167932467217081 using(v35));
create or replace view aggJoin4977642958668622738 as (
with aggView3102724073688180113 as (select v35, MIN(v59) as v59, MIN(v61) as v61, MIN(v36) as v60 from aggJoin228940568541993249 group by v35,v59,v61)
select v3, v59, v61, v60 from aggView1487652545404300739 join aggView3102724073688180113 using(v35));
select MIN(v3) as v58,MIN(v59) as v59,MIN(v60) as v60,MIN(v61) as v61 from aggJoin4977642958668622738;
