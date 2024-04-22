create or replace view aggJoin8611181480633386133 as (
with aggView9051769397636826564 as (select id as v9, name as v71 from char_name as chn)
select person_id as v48, movie_id as v59, note as v20, role_id as v57, v71 from cast_info as ci, aggView9051769397636826564 where ci.person_role_id=aggView9051769397636826564.v9 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin1930937671772142820 as (
with aggView1713961304095471553 as (select id as v57 from role_type as rt where role= 'actress')
select v48, v59, v20, v71 from aggJoin8611181480633386133 join aggView1713961304095471553 using(v57));
create or replace view aggJoin2901648461639029298 as (
with aggView5561003327278593607 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v59, info as v43 from movie_info as mi, aggView5561003327278593607 where mi.info_type_id=aggView5561003327278593607.v30 and ((info LIKE 'Japan:%201%') OR (info LIKE 'USA:%201%')));
create or replace view aggJoin7256116399765976405 as (
with aggView8809321097485536896 as (select id as v32 from keyword as k where keyword IN ('hero','martial-arts','hand-to-hand-combat','computer-animated-movie'))
select movie_id as v59 from movie_keyword as mk, aggView8809321097485536896 where mk.keyword_id=aggView8809321097485536896.v32);
create or replace view aggJoin8988332384923787317 as (
with aggView7442216820019538942 as (select person_id as v48 from aka_name as an group by person_id)
select id as v48, name as v49, gender as v52 from name as n, aggView7442216820019538942 where n.id=aggView7442216820019538942.v48 and name LIKE '%An%' and gender= 'f');
create or replace view aggJoin1380690044461293965 as (
with aggView9144227786277497052 as (select v48, MIN(v49) as v72 from aggJoin8988332384923787317 group by v48)
select v59, v20, v71 as v71, v72 from aggJoin1930937671772142820 join aggView9144227786277497052 using(v48));
create or replace view aggJoin4671587413226133750 as (
with aggView8947151968346056176 as (select v59, MIN(v71) as v71, MIN(v72) as v72 from aggJoin1380690044461293965 group by v59,v72,v71)
select movie_id as v59, company_id as v23, v71, v72 from movie_companies as mc, aggView8947151968346056176 where mc.movie_id=aggView8947151968346056176.v59);
create or replace view aggJoin3037487867145220109 as (
with aggView8509180252415907711 as (select id as v23 from company_name as cn where country_code= '[us]' and name= 'DreamWorks Animation')
select v59, v71, v72 from aggJoin4671587413226133750 join aggView8509180252415907711 using(v23));
create or replace view aggJoin587582066578693502 as (
with aggView5424316485671863027 as (select v59, MIN(v71) as v71, MIN(v72) as v72 from aggJoin3037487867145220109 group by v59,v72,v71)
select v59, v43, v71, v72 from aggJoin2901648461639029298 join aggView5424316485671863027 using(v59));
create or replace view aggJoin4380882192268153147 as (
with aggView461938013656540739 as (select v59, MIN(v71) as v71, MIN(v72) as v72 from aggJoin587582066578693502 group by v59,v72,v71)
select id as v59, title as v60, production_year as v63, v71, v72 from title as t, aggView461938013656540739 where t.id=aggView461938013656540739.v59 and title LIKE 'Kung Fu Panda%' and production_year>2010);
create or replace view aggJoin8188095867697346055 as (
with aggView2946202403614181868 as (select v59, MIN(v71) as v71, MIN(v72) as v72, MIN(v60) as v73 from aggJoin4380882192268153147 group by v59,v72,v71)
select v71, v72, v73 from aggJoin7256116399765976405 join aggView2946202403614181868 using(v59));
select MIN(v71) as v71,MIN(v72) as v72,MIN(v73) as v73 from aggJoin8188095867697346055;
