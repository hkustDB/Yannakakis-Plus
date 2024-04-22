create or replace view aggJoin1554866503389333895 as (
with aggView1839908809485805752 as (select id as v22 from info_type as it1 where info= 'release dates')
select movie_id as v40, info as v35, note as v36 from movie_info as mi, aggView1839908809485805752 where mi.info_type_id=aggView1839908809485805752.v22 and note LIKE '%internet%' and info LIKE 'USA:% 200%');
create or replace view aggJoin3028697712855012009 as (
with aggView8289295991556190600 as (select v40, MIN(v35) as v52 from aggJoin1554866503389333895 group by v40)
select movie_id as v40, v52 from aka_title as aka_t, aggView8289295991556190600 where aka_t.movie_id=aggView8289295991556190600.v40);
create or replace view aggJoin343385613109159088 as (
with aggView6631271408615492568 as (select v40, MIN(v52) as v52 from aggJoin3028697712855012009 group by v40,v52)
select id as v40, title as v41, production_year as v44, v52 from title as t, aggView6631271408615492568 where t.id=aggView6631271408615492568.v40 and production_year<=2010 and production_year>=2005);
create or replace view aggJoin987107211165967962 as (
with aggView4282059189217558618 as (select v40, MIN(v52) as v52, MIN(v41) as v53 from aggJoin343385613109159088 group by v40,v52)
select movie_id as v40, company_id as v13, company_type_id as v20, note as v31, v52, v53 from movie_companies as mc, aggView4282059189217558618 where mc.movie_id=aggView4282059189217558618.v40 and note LIKE '%(200%)%' and note LIKE '%(worldwide)%');
create or replace view aggJoin1853512270888891817 as (
with aggView1987135384552700933 as (select id as v13 from company_name as cn where name= 'YouTube' and country_code= '[us]')
select v40, v20, v31, v52, v53 from aggJoin987107211165967962 join aggView1987135384552700933 using(v13));
create or replace view aggJoin438198159870381684 as (
with aggView4239109505100349383 as (select id as v20 from company_type as ct)
select v40, v31, v52, v53 from aggJoin1853512270888891817 join aggView4239109505100349383 using(v20));
create or replace view aggJoin363617878894725634 as (
with aggView3464683390961346693 as (select v40, MIN(v52) as v52, MIN(v53) as v53 from aggJoin438198159870381684 group by v40,v53,v52)
select keyword_id as v24, v52, v53 from movie_keyword as mk, aggView3464683390961346693 where mk.movie_id=aggView3464683390961346693.v40);
create or replace view aggJoin28638223440525949 as (
with aggView2561640226604605581 as (select id as v24 from keyword as k)
select v52, v53 from aggJoin363617878894725634 join aggView2561640226604605581 using(v24));
select MIN(v52) as v52,MIN(v53) as v53 from aggJoin28638223440525949;
