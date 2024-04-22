create or replace view aggView8595440258366790270 as select name as v3, person_id as v35 from aka_name as an group by name,person_id;
create or replace view aggView2036510580162046626 as select name as v10, id as v9 from char_name as chn;
create or replace view aggView1277118967692838036 as select id as v18, title as v47 from title as t where production_year>=2005 and production_year<=2015;
create or replace view aggJoin5952058211161042798 as (
with aggView5033556278905167804 as (select v9, MIN(v10) as v59 from aggView2036510580162046626 group by v9)
select person_id as v35, movie_id as v18, note as v20, role_id as v22, v59 from cast_info as ci, aggView5033556278905167804 where ci.person_role_id=aggView5033556278905167804.v9 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin5221344932293219829 as (
with aggView3269401169103565362 as (select v35, MIN(v3) as v58 from aggView8595440258366790270 group by v35)
select v35, v18, v20, v22, v59 as v59, v58 from aggJoin5952058211161042798 join aggView3269401169103565362 using(v35));
create or replace view aggJoin2558997461926125235 as (
with aggView3353964419401306997 as (select id as v35 from name as n where gender= 'f' and name LIKE '%Ang%')
select v18, v20, v22, v59, v58 from aggJoin5221344932293219829 join aggView3353964419401306997 using(v35));
create or replace view aggJoin6209429877778423187 as (
with aggView7183371165932523074 as (select id as v32 from company_name as cn where country_code= '[us]')
select movie_id as v18, note as v34 from movie_companies as mc, aggView7183371165932523074 where mc.company_id=aggView7183371165932523074.v32 and ((note LIKE '%(USA)%') OR (note LIKE '%(worldwide)%')));
create or replace view aggJoin3764359480583878775 as (
with aggView7031941779041207400 as (select id as v22 from role_type as rt where role= 'actress')
select v18, v20, v59, v58 from aggJoin2558997461926125235 join aggView7031941779041207400 using(v22));
create or replace view aggJoin3551268346038113749 as (
with aggView295549708631191143 as (select v18 from aggJoin6209429877778423187 group by v18)
select v18, v20, v59 as v59, v58 as v58 from aggJoin3764359480583878775 join aggView295549708631191143 using(v18));
create or replace view aggJoin6622166005680163582 as (
with aggView2654216011772275705 as (select v18, MIN(v59) as v59, MIN(v58) as v58 from aggJoin3551268346038113749 group by v18,v59,v58)
select v47, v59, v58 from aggView1277118967692838036 join aggView2654216011772275705 using(v18));
select MIN(v58) as v58,MIN(v59) as v59,MIN(v47) as v60 from aggJoin6622166005680163582;
