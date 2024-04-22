create or replace view aggView8012440928873127049 as select id as v9, name as v10 from char_name as chn;
create or replace view aggJoin9176315837011647868 as (
with aggView1847437553714664721 as (select name as v49, id as v48 from name as n where gender= 'f')
select v48, v49 from aggView1847437553714664721 where v49 LIKE '%An%');
create or replace view aggJoin5239087587047599873 as (
with aggView2693885720418437016 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v59, info as v43 from movie_info as mi, aggView2693885720418437016 where mi.info_type_id=aggView2693885720418437016.v30 and ((info LIKE 'Japan:%201%') OR (info LIKE 'USA:%201%')));
create or replace view aggJoin6981397718330638016 as (
with aggView650140784312075190 as (select id as v32 from keyword as k where keyword IN ('hero','martial-arts','hand-to-hand-combat','computer-animated-movie'))
select movie_id as v59 from movie_keyword as mk, aggView650140784312075190 where mk.keyword_id=aggView650140784312075190.v32);
create or replace view aggJoin1753299230621581034 as (
with aggView6796023674466013855 as (select v59 from aggJoin6981397718330638016 group by v59)
select v59, v43 from aggJoin5239087587047599873 join aggView6796023674466013855 using(v59));
create or replace view aggJoin2896338557169133776 as (
with aggView1002352553870832449 as (select id as v23 from company_name as cn where country_code= '[us]' and name= 'DreamWorks Animation')
select movie_id as v59 from movie_companies as mc, aggView1002352553870832449 where mc.company_id=aggView1002352553870832449.v23);
create or replace view aggJoin3974378718240006945 as (
with aggView1338183807967196095 as (select v59 from aggJoin2896338557169133776 group by v59)
select v59, v43 from aggJoin1753299230621581034 join aggView1338183807967196095 using(v59));
create or replace view aggJoin4272606255691539767 as (
with aggView6918443059057332675 as (select v59 from aggJoin3974378718240006945 group by v59)
select id as v59, title as v60, production_year as v63 from title as t, aggView6918443059057332675 where t.id=aggView6918443059057332675.v59 and production_year>2010);
create or replace view aggJoin7191682346592664738 as (
with aggView5891610978003286421 as (select v59, v60 from aggJoin4272606255691539767 group by v59,v60)
select v59, v60 from aggView5891610978003286421 where v60 LIKE 'Kung Fu Panda%');
create or replace view aggJoin698833586729321134 as (
with aggView3492799163987760029 as (select v59, MIN(v60) as v73 from aggJoin7191682346592664738 group by v59)
select person_id as v48, person_role_id as v9, note as v20, role_id as v57, v73 from cast_info as ci, aggView3492799163987760029 where ci.movie_id=aggView3492799163987760029.v59 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin5933788128065575607 as (
with aggView6506508689839060970 as (select v9, MIN(v10) as v71 from aggView8012440928873127049 group by v9)
select v48, v20, v57, v73 as v73, v71 from aggJoin698833586729321134 join aggView6506508689839060970 using(v9));
create or replace view aggJoin8614243923408401137 as (
with aggView7930200908493930735 as (select id as v57 from role_type as rt where role= 'actress')
select v48, v20, v73, v71 from aggJoin5933788128065575607 join aggView7930200908493930735 using(v57));
create or replace view aggJoin8658454963313679904 as (
with aggView4021847357067379810 as (select person_id as v48 from aka_name as an group by person_id)
select v48, v20, v73 as v73, v71 as v71 from aggJoin8614243923408401137 join aggView4021847357067379810 using(v48));
create or replace view aggJoin3361252067956660130 as (
with aggView3006243944883240745 as (select v48, MIN(v73) as v73, MIN(v71) as v71 from aggJoin8658454963313679904 group by v48,v71,v73)
select v49, v73, v71 from aggJoin9176315837011647868 join aggView3006243944883240745 using(v48));
select MIN(v71) as v71,MIN(v49) as v72,MIN(v73) as v73 from aggJoin3361252067956660130;
