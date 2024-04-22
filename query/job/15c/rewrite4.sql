create or replace view aggJoin6771162276054550190 as (
with aggView3001153058597885275 as (select id as v13 from company_name as cn where country_code= '[us]')
select movie_id as v40, company_type_id as v20 from movie_companies as mc, aggView3001153058597885275 where mc.company_id=aggView3001153058597885275.v13);
create or replace view aggJoin8510562162099148921 as (
with aggView5403372413324161955 as (select id as v24 from keyword as k)
select movie_id as v40 from movie_keyword as mk, aggView5403372413324161955 where mk.keyword_id=aggView5403372413324161955.v24);
create or replace view aggJoin8546477138634049192 as (
with aggView2892606998802626681 as (select id as v20 from company_type as ct)
select v40 from aggJoin6771162276054550190 join aggView2892606998802626681 using(v20));
create or replace view aggJoin5087391873290995789 as (
with aggView8277940787460030864 as (select v40 from aggJoin8546477138634049192 group by v40)
select id as v40, title as v41, production_year as v44 from title as t, aggView8277940787460030864 where t.id=aggView8277940787460030864.v40 and production_year>1990);
create or replace view aggJoin8822469667054062284 as (
with aggView8460690340753854526 as (select id as v22 from info_type as it1 where info= 'release dates')
select movie_id as v40, info as v35, note as v36 from movie_info as mi, aggView8460690340753854526 where mi.info_type_id=aggView8460690340753854526.v22 and note LIKE '%internet%' and ((info LIKE 'USA:% 199%') OR (info LIKE 'USA:% 200%')));
create or replace view aggJoin8428856936214307453 as (
with aggView7333907153918611345 as (select v40, MIN(v35) as v52 from aggJoin8822469667054062284 group by v40)
select v40, v41, v44, v52 from aggJoin5087391873290995789 join aggView7333907153918611345 using(v40));
create or replace view aggJoin9052532127026192363 as (
with aggView2793056272323502137 as (select v40, MIN(v52) as v52, MIN(v41) as v53 from aggJoin8428856936214307453 group by v40,v52)
select movie_id as v40, v52, v53 from aka_title as aka_t, aggView2793056272323502137 where aka_t.movie_id=aggView2793056272323502137.v40);
create or replace view aggJoin1054598063486324430 as (
with aggView3029348957717977705 as (select v40, MIN(v52) as v52, MIN(v53) as v53 from aggJoin9052532127026192363 group by v40,v52,v53)
select v52, v53 from aggJoin8510562162099148921 join aggView3029348957717977705 using(v40));
select MIN(v52) as v52,MIN(v53) as v53 from aggJoin1054598063486324430;
