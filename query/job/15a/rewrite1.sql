create or replace view aggJoin4556787770719706158 as (
with aggView6069375970530844500 as (select id as v24 from keyword as k)
select movie_id as v40 from movie_keyword as mk, aggView6069375970530844500 where mk.keyword_id=aggView6069375970530844500.v24);
create or replace view aggJoin6962278272802240317 as (
with aggView8961923989618395766 as (select id as v13 from company_name as cn where country_code= '[us]')
select movie_id as v40, company_type_id as v20, note as v31 from movie_companies as mc, aggView8961923989618395766 where mc.company_id=aggView8961923989618395766.v13 and note LIKE '%(200%)%' and note LIKE '%(worldwide)%');
create or replace view aggJoin5931792226051595923 as (
with aggView472827664273699586 as (select movie_id as v40 from aka_title as aka_t group by movie_id)
select v40 from aggJoin4556787770719706158 join aggView472827664273699586 using(v40));
create or replace view aggJoin3196105071707813721 as (
with aggView3276840646554055427 as (select v40 from aggJoin5931792226051595923 group by v40)
select id as v40, title as v41, production_year as v44 from title as t, aggView3276840646554055427 where t.id=aggView3276840646554055427.v40 and production_year>2000);
create or replace view aggJoin1600934792372385541 as (
with aggView5946787444176657054 as (select id as v20 from company_type as ct)
select v40, v31 from aggJoin6962278272802240317 join aggView5946787444176657054 using(v20));
create or replace view aggJoin2485718378005037640 as (
with aggView5248872080300503762 as (select v40 from aggJoin1600934792372385541 group by v40)
select v40, v41, v44 from aggJoin3196105071707813721 join aggView5248872080300503762 using(v40));
create or replace view aggView1083277515457202306 as select v41, v40 from aggJoin2485718378005037640 group by v41,v40;
create or replace view aggJoin7765380557799980843 as (
with aggView2766999611304946695 as (select id as v22 from info_type as it1 where info= 'release dates')
select movie_id as v40, info as v35, note as v36 from movie_info as mi, aggView2766999611304946695 where mi.info_type_id=aggView2766999611304946695.v22 and note LIKE '%internet%');
create or replace view aggJoin93960297017214775 as (
with aggView8147545895382863958 as (select v35, v40 from aggJoin7765380557799980843 group by v35,v40)
select v40, v35 from aggView8147545895382863958 where v35 LIKE 'USA:% 200%');
create or replace view aggJoin7614327786889435567 as (
with aggView1880125385722727920 as (select v40, MIN(v41) as v53 from aggView1083277515457202306 group by v40)
select v35, v53 from aggJoin93960297017214775 join aggView1880125385722727920 using(v40));
select MIN(v35) as v52,MIN(v53) as v53 from aggJoin7614327786889435567;
