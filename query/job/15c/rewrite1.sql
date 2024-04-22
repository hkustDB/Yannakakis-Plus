create or replace view aggJoin3351579530492221044 as (
with aggView5897653910836985838 as (select id as v13 from company_name as cn where country_code= '[us]')
select movie_id as v40, company_type_id as v20 from movie_companies as mc, aggView5897653910836985838 where mc.company_id=aggView5897653910836985838.v13);
create or replace view aggJoin164017037854255058 as (
with aggView3664402077133368678 as (select id as v24 from keyword as k)
select movie_id as v40 from movie_keyword as mk, aggView3664402077133368678 where mk.keyword_id=aggView3664402077133368678.v24);
create or replace view aggJoin2092735716376673187 as (
with aggView5519977551444075973 as (select id as v20 from company_type as ct)
select v40 from aggJoin3351579530492221044 join aggView5519977551444075973 using(v20));
create or replace view aggJoin7844820736073426061 as (
with aggView3759961955806207163 as (select v40 from aggJoin164017037854255058 group by v40)
select movie_id as v40 from aka_title as aka_t, aggView3759961955806207163 where aka_t.movie_id=aggView3759961955806207163.v40);
create or replace view aggJoin1695610042811499814 as (
with aggView6989380977227204653 as (select v40 from aggJoin7844820736073426061 group by v40)
select id as v40, title as v41, production_year as v44 from title as t, aggView6989380977227204653 where t.id=aggView6989380977227204653.v40 and production_year>1990);
create or replace view aggJoin619067081752875162 as (
with aggView2405366657373462550 as (select v40 from aggJoin2092735716376673187 group by v40)
select v40, v41, v44 from aggJoin1695610042811499814 join aggView2405366657373462550 using(v40));
create or replace view aggView2984155368799392306 as select v41, v40 from aggJoin619067081752875162 group by v41,v40;
create or replace view aggJoin1427730578038595195 as (
with aggView1168644107840895184 as (select id as v22 from info_type as it1 where info= 'release dates')
select movie_id as v40, info as v35, note as v36 from movie_info as mi, aggView1168644107840895184 where mi.info_type_id=aggView1168644107840895184.v22 and note LIKE '%internet%' and ((info LIKE 'USA:% 199%') OR (info LIKE 'USA:% 200%')));
create or replace view aggView1390976084116429589 as select v40, v35 from aggJoin1427730578038595195 group by v40,v35;
create or replace view aggJoin4262727464678086040 as (
with aggView5841077337107930090 as (select v40, MIN(v41) as v53 from aggView2984155368799392306 group by v40)
select v35, v53 from aggView1390976084116429589 join aggView5841077337107930090 using(v40));
select MIN(v35) as v52,MIN(v53) as v53 from aggJoin4262727464678086040;
