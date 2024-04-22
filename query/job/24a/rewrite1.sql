create or replace view aggJoin4901277360031385660 as (
with aggView7516911471315231509 as (select id as v48, name as v72 from name as n where name LIKE '%An%' and gender= 'f')
select person_id as v48, v72 from aka_name as an, aggView7516911471315231509 where an.person_id=aggView7516911471315231509.v48);
create or replace view aggJoin6009269108938688112 as (
with aggView1810255417847934991 as (select id as v9, name as v71 from char_name as chn)
select person_id as v48, movie_id as v59, note as v20, role_id as v57, v71 from cast_info as ci, aggView1810255417847934991 where ci.person_role_id=aggView1810255417847934991.v9 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin722902613739860282 as (
with aggView2303947500100411166 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v59, info as v43 from movie_info as mi, aggView2303947500100411166 where mi.info_type_id=aggView2303947500100411166.v30 and ((info LIKE 'Japan:%201%') OR (info LIKE 'USA:%201%')));
create or replace view aggJoin7381148738351915794 as (
with aggView8546215833956772478 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v59 from movie_companies as mc, aggView8546215833956772478 where mc.company_id=aggView8546215833956772478.v23);
create or replace view aggJoin2139123811616093194 as (
with aggView3141111851733959630 as (select v48, MIN(v72) as v72 from aggJoin4901277360031385660 group by v48,v72)
select v59, v20, v57, v71 as v71, v72 from aggJoin6009269108938688112 join aggView3141111851733959630 using(v48));
create or replace view aggJoin5281528301052349403 as (
with aggView5372897681868480702 as (select id as v57 from role_type as rt where role= 'actress')
select v59, v20, v71, v72 from aggJoin2139123811616093194 join aggView5372897681868480702 using(v57));
create or replace view aggJoin5984223121727942356 as (
with aggView4018699084791616744 as (select v59, MIN(v71) as v71, MIN(v72) as v72 from aggJoin5281528301052349403 group by v59,v72,v71)
select id as v59, title as v60, production_year as v63, v71, v72 from title as t, aggView4018699084791616744 where t.id=aggView4018699084791616744.v59 and production_year>2010);
create or replace view aggJoin6900284719769564239 as (
with aggView7270354411223511058 as (select id as v32 from keyword as k where keyword IN ('hero','martial-arts','hand-to-hand-combat'))
select movie_id as v59 from movie_keyword as mk, aggView7270354411223511058 where mk.keyword_id=aggView7270354411223511058.v32);
create or replace view aggJoin2649598164159279255 as (
with aggView6235710569989323768 as (select v59 from aggJoin6900284719769564239 group by v59)
select v59, v60, v63, v71 as v71, v72 as v72 from aggJoin5984223121727942356 join aggView6235710569989323768 using(v59));
create or replace view aggJoin614286655794414155 as (
with aggView9125259534029203410 as (select v59 from aggJoin7381148738351915794 group by v59)
select v59, v60, v63, v71 as v71, v72 as v72 from aggJoin2649598164159279255 join aggView9125259534029203410 using(v59));
create or replace view aggJoin3100728211879694264 as (
with aggView6583396022732427665 as (select v59, MIN(v71) as v71, MIN(v72) as v72, MIN(v60) as v73 from aggJoin614286655794414155 group by v59,v72,v71)
select v71, v72, v73 from aggJoin722902613739860282 join aggView6583396022732427665 using(v59));
select MIN(v71) as v71,MIN(v72) as v72,MIN(v73) as v73 from aggJoin3100728211879694264;
