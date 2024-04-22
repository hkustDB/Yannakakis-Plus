create or replace view aggJoin350150840861423867 as (
with aggView1642095025127573918 as (select id as v24 from keyword as k)
select movie_id as v40 from movie_keyword as mk, aggView1642095025127573918 where mk.keyword_id=aggView1642095025127573918.v24);
create or replace view aggJoin7467089264010972218 as (
with aggView1341419709973724397 as (select id as v13 from company_name as cn where country_code= '[us]')
select movie_id as v40, company_type_id as v20, note as v31 from movie_companies as mc, aggView1341419709973724397 where mc.company_id=aggView1341419709973724397.v13 and note LIKE '%(200%)%' and note LIKE '%(worldwide)%');
create or replace view aggJoin4616162078641404242 as (
with aggView3890292381490920585 as (select id as v20 from company_type as ct)
select v40, v31 from aggJoin7467089264010972218 join aggView3890292381490920585 using(v20));
create or replace view aggJoin6718633127190825341 as (
with aggView1860027533098930487 as (select v40 from aggJoin350150840861423867 group by v40)
select id as v40, title as v41, production_year as v44 from title as t, aggView1860027533098930487 where t.id=aggView1860027533098930487.v40 and production_year>2000);
create or replace view aggJoin5845366014122401758 as (
with aggView7042814552721360757 as (select id as v22 from info_type as it1 where info= 'release dates')
select movie_id as v40, info as v35, note as v36 from movie_info as mi, aggView7042814552721360757 where mi.info_type_id=aggView7042814552721360757.v22 and note LIKE '%internet%');
create or replace view aggJoin6183261006971916788 as (
with aggView5620239150257147419 as (select v35, v40 from aggJoin5845366014122401758 group by v35,v40)
select v40, v35 from aggView5620239150257147419 where v35 LIKE 'USA:% 200%');
create or replace view aggJoin7969664874706113480 as (
with aggView6905826191535881419 as (select movie_id as v40 from aka_title as aka_t group by movie_id)
select v40, v31 from aggJoin4616162078641404242 join aggView6905826191535881419 using(v40));
create or replace view aggJoin3486163424709083560 as (
with aggView4244229915913793789 as (select v40 from aggJoin7969664874706113480 group by v40)
select v40, v41, v44 from aggJoin6718633127190825341 join aggView4244229915913793789 using(v40));
create or replace view aggView6120144343201011347 as select v41, v40 from aggJoin3486163424709083560 group by v41,v40;
create or replace view aggJoin7317780739421457698 as (
with aggView2333320203598782505 as (select v40, MIN(v35) as v52 from aggJoin6183261006971916788 group by v40)
select v41, v52 from aggView6120144343201011347 join aggView2333320203598782505 using(v40));
select MIN(v52) as v52,MIN(v41) as v53 from aggJoin7317780739421457698;
