create or replace view aggView2785546453594842096 as select name as v10, id as v9 from char_name as chn;
create or replace view aggJoin1039114754943505274 as (
with aggView9073657419075578357 as (select person_id as v48 from aka_name as an group by person_id)
select id as v48, name as v49, gender as v52 from name as n, aggView9073657419075578357 where n.id=aggView9073657419075578357.v48 and gender= 'f');
create or replace view aggJoin73773718703062243 as (
with aggView977728430045786819 as (select v48, v49 from aggJoin1039114754943505274 group by v48,v49)
select v48, v49 from aggView977728430045786819 where v49 LIKE '%An%');
create or replace view aggJoin8248441955285529505 as (
with aggView4419576263378994123 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v59 from movie_companies as mc, aggView4419576263378994123 where mc.company_id=aggView4419576263378994123.v23);
create or replace view aggJoin3092987283145992301 as (
with aggView8568746868843306509 as (select v59 from aggJoin8248441955285529505 group by v59)
select id as v59, title as v60, production_year as v63 from title as t, aggView8568746868843306509 where t.id=aggView8568746868843306509.v59 and production_year>2010);
create or replace view aggView303790006848316086 as select v59, v60 from aggJoin3092987283145992301 group by v59,v60;
create or replace view aggJoin5039479631198050566 as (
with aggView5788796813384513426 as (select v48, MIN(v49) as v72 from aggJoin73773718703062243 group by v48)
select movie_id as v59, person_role_id as v9, note as v20, role_id as v57, v72 from cast_info as ci, aggView5788796813384513426 where ci.person_id=aggView5788796813384513426.v48 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin6898777970189328004 as (
with aggView8293006920680521200 as (select v9, MIN(v10) as v71 from aggView2785546453594842096 group by v9)
select v59, v20, v57, v72 as v72, v71 from aggJoin5039479631198050566 join aggView8293006920680521200 using(v9));
create or replace view aggJoin1976570322921148163 as (
with aggView2725573341201097571 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v59, info as v43 from movie_info as mi, aggView2725573341201097571 where mi.info_type_id=aggView2725573341201097571.v30 and ((info LIKE 'Japan:%201%') OR (info LIKE 'USA:%201%')));
create or replace view aggJoin8300027311536402778 as (
with aggView4639989107578864811 as (select v59 from aggJoin1976570322921148163 group by v59)
select v59, v20, v57, v72 as v72, v71 as v71 from aggJoin6898777970189328004 join aggView4639989107578864811 using(v59));
create or replace view aggJoin409528578646717165 as (
with aggView127815467521128388 as (select id as v57 from role_type as rt where role= 'actress')
select v59, v20, v72, v71 from aggJoin8300027311536402778 join aggView127815467521128388 using(v57));
create or replace view aggJoin6818787667198106162 as (
with aggView2430751684859008051 as (select id as v32 from keyword as k where keyword IN ('hero','martial-arts','hand-to-hand-combat'))
select movie_id as v59 from movie_keyword as mk, aggView2430751684859008051 where mk.keyword_id=aggView2430751684859008051.v32);
create or replace view aggJoin7395984239695302927 as (
with aggView8737760212770196373 as (select v59 from aggJoin6818787667198106162 group by v59)
select v59, v20, v72 as v72, v71 as v71 from aggJoin409528578646717165 join aggView8737760212770196373 using(v59));
create or replace view aggJoin3836165815451860508 as (
with aggView1659782260333631284 as (select v59, MIN(v72) as v72, MIN(v71) as v71 from aggJoin7395984239695302927 group by v59,v72,v71)
select v60, v72, v71 from aggView303790006848316086 join aggView1659782260333631284 using(v59));
select MIN(v71) as v71,MIN(v72) as v72,MIN(v60) as v73 from aggJoin3836165815451860508;
