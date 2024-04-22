create or replace view aggView997711072541188532 as select name as v10, id as v9 from char_name as chn;
create or replace view aggJoin4558351955726532062 as (
with aggView9116639191249432482 as (select person_id as v48 from aka_name as an group by person_id)
select id as v48, name as v49, gender as v52 from name as n, aggView9116639191249432482 where n.id=aggView9116639191249432482.v48 and gender= 'f');
create or replace view aggJoin6745279328966092268 as (
with aggView275559110008356099 as (select v48, v49 from aggJoin4558351955726532062 group by v48,v49)
select v48, v49 from aggView275559110008356099 where v49 LIKE '%An%');
create or replace view aggJoin8115572851574065556 as (
with aggView13832599302008269 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v59 from movie_companies as mc, aggView13832599302008269 where mc.company_id=aggView13832599302008269.v23);
create or replace view aggJoin2894398905025504604 as (
with aggView6636972579130755742 as (select id as v32 from keyword as k where keyword IN ('hero','martial-arts','hand-to-hand-combat'))
select movie_id as v59 from movie_keyword as mk, aggView6636972579130755742 where mk.keyword_id=aggView6636972579130755742.v32);
create or replace view aggJoin3539477076381518921 as (
with aggView7232761957209042277 as (select v59 from aggJoin2894398905025504604 group by v59)
select v59 from aggJoin8115572851574065556 join aggView7232761957209042277 using(v59));
create or replace view aggJoin8668169577460367561 as (
with aggView1452051416980469158 as (select v59 from aggJoin3539477076381518921 group by v59)
select id as v59, title as v60, production_year as v63 from title as t, aggView1452051416980469158 where t.id=aggView1452051416980469158.v59 and production_year>2010);
create or replace view aggView8809932491707371038 as select v59, v60 from aggJoin8668169577460367561 group by v59,v60;
create or replace view aggJoin1357406761477424876 as (
with aggView6103810860048592276 as (select v59, MIN(v60) as v73 from aggView8809932491707371038 group by v59)
select person_id as v48, movie_id as v59, person_role_id as v9, note as v20, role_id as v57, v73 from cast_info as ci, aggView6103810860048592276 where ci.movie_id=aggView6103810860048592276.v59 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin4698664605484908930 as (
with aggView9064161281144177411 as (select v48, MIN(v49) as v72 from aggJoin6745279328966092268 group by v48)
select v59, v9, v20, v57, v73 as v73, v72 from aggJoin1357406761477424876 join aggView9064161281144177411 using(v48));
create or replace view aggJoin2348799734882490393 as (
with aggView2849584241864674352 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v59, info as v43 from movie_info as mi, aggView2849584241864674352 where mi.info_type_id=aggView2849584241864674352.v30 and ((info LIKE 'Japan:%201%') OR (info LIKE 'USA:%201%')));
create or replace view aggJoin5623165812929883719 as (
with aggView1892275161821925348 as (select v59 from aggJoin2348799734882490393 group by v59)
select v9, v20, v57, v73 as v73, v72 as v72 from aggJoin4698664605484908930 join aggView1892275161821925348 using(v59));
create or replace view aggJoin4987256875745441646 as (
with aggView6403446238186800856 as (select id as v57 from role_type as rt where role= 'actress')
select v9, v20, v73, v72 from aggJoin5623165812929883719 join aggView6403446238186800856 using(v57));
create or replace view aggJoin3965035878325338134 as (
with aggView354658253842455487 as (select v9, MIN(v73) as v73, MIN(v72) as v72 from aggJoin4987256875745441646 group by v9,v73,v72)
select v10, v73, v72 from aggView997711072541188532 join aggView354658253842455487 using(v9));
select MIN(v10) as v71,MIN(v72) as v72,MIN(v73) as v73 from aggJoin3965035878325338134;
