create or replace view aggView3627212387267866661 as select title as v41, id as v40 from title as t where production_year>1990;
create or replace view aggJoin9081501368725509966 as (
with aggView1421053965695531753 as (select id as v13 from company_name as cn where country_code= '[us]')
select movie_id as v40, company_type_id as v20 from movie_companies as mc, aggView1421053965695531753 where mc.company_id=aggView1421053965695531753.v13);
create or replace view aggJoin5258456439160372047 as (
with aggView5077059926840176628 as (select id as v24 from keyword as k)
select movie_id as v40 from movie_keyword as mk, aggView5077059926840176628 where mk.keyword_id=aggView5077059926840176628.v24);
create or replace view aggJoin6160136507916223253 as (
with aggView5525076736547204453 as (select id as v20 from company_type as ct)
select v40 from aggJoin9081501368725509966 join aggView5525076736547204453 using(v20));
create or replace view aggJoin1057769283641800384 as (
with aggView1537177310661567760 as (select v40 from aggJoin6160136507916223253 group by v40)
select movie_id as v40, info_type_id as v22, info as v35, note as v36 from movie_info as mi, aggView1537177310661567760 where mi.movie_id=aggView1537177310661567760.v40 and note LIKE '%internet%' and ((info LIKE 'USA:% 199%') OR (info LIKE 'USA:% 200%')));
create or replace view aggJoin4265927084652823509 as (
with aggView2492647429983085564 as (select movie_id as v40 from aka_title as aka_t group by movie_id)
select v40 from aggJoin5258456439160372047 join aggView2492647429983085564 using(v40));
create or replace view aggJoin3811183324500523770 as (
with aggView4479535802893564098 as (select v40 from aggJoin4265927084652823509 group by v40)
select v40, v22, v35, v36 from aggJoin1057769283641800384 join aggView4479535802893564098 using(v40));
create or replace view aggJoin5597138540632273194 as (
with aggView6387762372696453354 as (select id as v22 from info_type as it1 where info= 'release dates')
select v40, v35, v36 from aggJoin3811183324500523770 join aggView6387762372696453354 using(v22));
create or replace view aggView6002886601077662602 as select v40, v35 from aggJoin5597138540632273194 group by v40,v35;
create or replace view aggJoin3019411568820642102 as (
with aggView7149472546145787673 as (select v40, MIN(v35) as v52 from aggView6002886601077662602 group by v40)
select v41, v52 from aggView3627212387267866661 join aggView7149472546145787673 using(v40));
select MIN(v52) as v52,MIN(v41) as v53 from aggJoin3019411568820642102;
