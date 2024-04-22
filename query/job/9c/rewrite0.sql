create or replace view aggView1438889960926653296 as select name as v36, id as v35 from name as n where name LIKE '%An%' and gender= 'f';
create or replace view aggView1222485997959391865 as select person_id as v35, name as v3 from aka_name as an group by person_id,name;
create or replace view aggView4751059589544743297 as select name as v10, id as v9 from char_name as chn;
create or replace view aggJoin1270834184568716697 as (
with aggView3537131621940276766 as (select id as v32 from company_name as cn where country_code= '[us]')
select movie_id as v18 from movie_companies as mc, aggView3537131621940276766 where mc.company_id=aggView3537131621940276766.v32);
create or replace view aggJoin7285700249491821517 as (
with aggView6711394921593968800 as (select v18 from aggJoin1270834184568716697 group by v18)
select id as v18, title as v47 from title as t, aggView6711394921593968800 where t.id=aggView6711394921593968800.v18);
create or replace view aggView7822384652794125421 as select v18, v47 from aggJoin7285700249491821517 group by v18,v47;
create or replace view aggJoin853456617184309211 as (
with aggView5546851135106607174 as (select v9, MIN(v10) as v59 from aggView4751059589544743297 group by v9)
select person_id as v35, movie_id as v18, note as v20, role_id as v22, v59 from cast_info as ci, aggView5546851135106607174 where ci.person_role_id=aggView5546851135106607174.v9 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin9200541313642466078 as (
with aggView6702656101898938330 as (select v18, MIN(v47) as v61 from aggView7822384652794125421 group by v18)
select v35, v20, v22, v59 as v59, v61 from aggJoin853456617184309211 join aggView6702656101898938330 using(v18));
create or replace view aggJoin3047582688506417982 as (
with aggView150271508364095320 as (select id as v22 from role_type as rt where role= 'actress')
select v35, v20, v59, v61 from aggJoin9200541313642466078 join aggView150271508364095320 using(v22));
create or replace view aggJoin4460747535689754843 as (
with aggView2545765533989800058 as (select v35, MIN(v59) as v59, MIN(v61) as v61 from aggJoin3047582688506417982 group by v35,v61,v59)
select v35, v3, v59, v61 from aggView1222485997959391865 join aggView2545765533989800058 using(v35));
create or replace view aggJoin1480267377072818976 as (
with aggView5074822318983486433 as (select v35, MIN(v59) as v59, MIN(v61) as v61, MIN(v3) as v58 from aggJoin4460747535689754843 group by v35,v61,v59)
select v36, v59, v61, v58 from aggView1438889960926653296 join aggView5074822318983486433 using(v35));
select MIN(v58) as v58,MIN(v59) as v59,MIN(v36) as v60,MIN(v61) as v61 from aggJoin1480267377072818976;
