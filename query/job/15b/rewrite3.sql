create or replace view aggJoin7227141123228890792 as (
with aggView7030351481846887437 as (select id as v22 from info_type as it1 where info= 'release dates')
select movie_id as v40, info as v35, note as v36 from movie_info as mi, aggView7030351481846887437 where mi.info_type_id=aggView7030351481846887437.v22 and note LIKE '%internet%');
create or replace view aggJoin4232910445272635861 as (
with aggView5036434416559217317 as (select v40, v35 from aggJoin7227141123228890792 group by v40,v35)
select v40, v35 from aggView5036434416559217317 where v35 LIKE 'USA:% 200%');
create or replace view aggJoin5654989014742602515 as (
with aggView8631559383757530674 as (select id as v13 from company_name as cn where name= 'YouTube' and country_code= '[us]')
select movie_id as v40, company_type_id as v20, note as v31 from movie_companies as mc, aggView8631559383757530674 where mc.company_id=aggView8631559383757530674.v13 and note LIKE '%(200%)%' and note LIKE '%(worldwide)%');
create or replace view aggJoin878574827079420677 as (
with aggView5509948630341356113 as (select id as v20 from company_type as ct)
select v40, v31 from aggJoin5654989014742602515 join aggView5509948630341356113 using(v20));
create or replace view aggJoin247506429664945333 as (
with aggView4960147663191126791 as (select v40 from aggJoin878574827079420677 group by v40)
select movie_id as v40 from aka_title as aka_t, aggView4960147663191126791 where aka_t.movie_id=aggView4960147663191126791.v40);
create or replace view aggJoin1285557138035360388 as (
with aggView2831812583175723166 as (select v40 from aggJoin247506429664945333 group by v40)
select id as v40, title as v41, production_year as v44 from title as t, aggView2831812583175723166 where t.id=aggView2831812583175723166.v40 and production_year<=2010 and production_year>=2005);
create or replace view aggJoin8935866968065637173 as (
with aggView339291543136776240 as (select id as v24 from keyword as k)
select movie_id as v40 from movie_keyword as mk, aggView339291543136776240 where mk.keyword_id=aggView339291543136776240.v24);
create or replace view aggJoin547287539871468407 as (
with aggView2854019993907660742 as (select v40 from aggJoin8935866968065637173 group by v40)
select v40, v41, v44 from aggJoin1285557138035360388 join aggView2854019993907660742 using(v40));
create or replace view aggView4714826717064880998 as select v40, v41 from aggJoin547287539871468407 group by v40,v41;
create or replace view aggJoin1233015314496878963 as (
with aggView5071369954849481102 as (select v40, MIN(v35) as v52 from aggJoin4232910445272635861 group by v40)
select v41, v52 from aggView4714826717064880998 join aggView5071369954849481102 using(v40));
select MIN(v52) as v52,MIN(v41) as v53 from aggJoin1233015314496878963;
