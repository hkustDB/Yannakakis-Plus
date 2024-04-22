create or replace view aggJoin7738153827223726366 as (
with aggView1572162472789520218 as (select movie_id as v40, MIN(title) as v52 from aka_title as aka_t group by movie_id)
select movie_id as v40, keyword_id as v24, v52 from movie_keyword as mk, aggView1572162472789520218 where mk.movie_id=aggView1572162472789520218.v40);
create or replace view aggJoin7986936197979211100 as (
with aggView3188834729735169105 as (select id as v13 from company_name as cn where country_code= '[us]')
select movie_id as v40, company_type_id as v20 from movie_companies as mc, aggView3188834729735169105 where mc.company_id=aggView3188834729735169105.v13);
create or replace view aggJoin8101524347856516021 as (
with aggView8572630449684399802 as (select id as v22 from info_type as it1 where info= 'release dates')
select movie_id as v40, note as v36 from movie_info as mi, aggView8572630449684399802 where mi.info_type_id=aggView8572630449684399802.v22 and note LIKE '%internet%');
create or replace view aggJoin8754771865249375803 as (
with aggView3700911332122158918 as (select id as v20 from company_type as ct)
select v40 from aggJoin7986936197979211100 join aggView3700911332122158918 using(v20));
create or replace view aggJoin6554696798707182836 as (
with aggView2670482904258165530 as (select v40 from aggJoin8754771865249375803 group by v40)
select v40, v36 from aggJoin8101524347856516021 join aggView2670482904258165530 using(v40));
create or replace view aggJoin7932135964820532434 as (
with aggView5346973723272212703 as (select v40 from aggJoin6554696798707182836 group by v40)
select id as v40, title as v41, production_year as v44 from title as t, aggView5346973723272212703 where t.id=aggView5346973723272212703.v40 and production_year>1990);
create or replace view aggJoin264313078035819794 as (
with aggView6696755680448418570 as (select v40, MIN(v41) as v53 from aggJoin7932135964820532434 group by v40)
select v24, v52 as v52, v53 from aggJoin7738153827223726366 join aggView6696755680448418570 using(v40));
create or replace view aggJoin4729052939058734924 as (
with aggView4515992505120390637 as (select id as v24 from keyword as k)
select v52, v53 from aggJoin264313078035819794 join aggView4515992505120390637 using(v24));
select MIN(v52) as v52,MIN(v53) as v53 from aggJoin4729052939058734924;
