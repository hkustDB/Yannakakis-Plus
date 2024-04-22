create or replace view aggView5257627052415561674 as select id as v40, title as v41 from title as t where production_year>1990;
create or replace view aggJoin5007261815738331663 as (
with aggView7001950483739231885 as (select id as v13 from company_name as cn where country_code= '[us]')
select movie_id as v40, company_type_id as v20 from movie_companies as mc, aggView7001950483739231885 where mc.company_id=aggView7001950483739231885.v13);
create or replace view aggJoin6579144286442393917 as (
with aggView2196541947689236909 as (select id as v22 from info_type as it1 where info= 'release dates')
select movie_id as v40, note as v36 from movie_info as mi, aggView2196541947689236909 where mi.info_type_id=aggView2196541947689236909.v22 and note LIKE '%internet%');
create or replace view aggJoin5650849754781400547 as (
with aggView6552545563913070604 as (select v40 from aggJoin6579144286442393917 group by v40)
select v40, v20 from aggJoin5007261815738331663 join aggView6552545563913070604 using(v40));
create or replace view aggJoin8859113490704364229 as (
with aggView4661716269267457262 as (select id as v20 from company_type as ct)
select v40 from aggJoin5650849754781400547 join aggView4661716269267457262 using(v20));
create or replace view aggJoin2240046599593897444 as (
with aggView5061724790759899722 as (select v40 from aggJoin8859113490704364229 group by v40)
select movie_id as v40, title as v3 from aka_title as aka_t, aggView5061724790759899722 where aka_t.movie_id=aggView5061724790759899722.v40);
create or replace view aggJoin7617318307052453579 as (
with aggView6581567149823133402 as (select id as v24 from keyword as k)
select movie_id as v40 from movie_keyword as mk, aggView6581567149823133402 where mk.keyword_id=aggView6581567149823133402.v24);
create or replace view aggJoin8560185340262615521 as (
with aggView5890336774513315052 as (select v40 from aggJoin7617318307052453579 group by v40)
select v40, v3 from aggJoin2240046599593897444 join aggView5890336774513315052 using(v40));
create or replace view aggView6531873796940300499 as select v40, v3 from aggJoin8560185340262615521 group by v40,v3;
create or replace view aggJoin2831424818377852264 as (
with aggView5700992481392588754 as (select v40, MIN(v3) as v52 from aggView6531873796940300499 group by v40)
select v41, v52 from aggView5257627052415561674 join aggView5700992481392588754 using(v40));
select MIN(v52) as v52,MIN(v41) as v53 from aggJoin2831424818377852264;
