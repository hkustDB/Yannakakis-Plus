create or replace view aggJoin4044268956984862717 as (
with aggView5684334372518595165 as (select id as v21, kind as v48 from kind_type as kt where kind= 'movie')
select id as v36, title as v37, production_year as v40, v48 from title as t, aggView5684334372518595165 where t.kind_id=aggView5684334372518595165.v21 and production_year>2000);
create or replace view aggJoin5035201194140368079 as (
with aggView8710530379667014777 as (select v36, MIN(v48) as v48, MIN(v37) as v49 from aggJoin4044268956984862717 group by v36,v48)
select movie_id as v36, info_type_id as v16, info as v31, note as v32, v48, v49 from movie_info as mi, aggView8710530379667014777 where mi.movie_id=aggView8710530379667014777.v36 and ((info LIKE 'USA:% 199%') OR (info LIKE 'USA:% 200%')) and note LIKE '%internet%');
create or replace view aggJoin4102374106498301488 as (
with aggView3724806021018937462 as (select id as v14 from company_type as ct)
select movie_id as v36, company_id as v7 from movie_companies as mc, aggView3724806021018937462 where mc.company_type_id=aggView3724806021018937462.v14);
create or replace view aggJoin5352867270032421884 as (
with aggView7843488840771481487 as (select id as v16 from info_type as it1 where info= 'release dates')
select v36, v31, v32, v48, v49 from aggJoin5035201194140368079 join aggView7843488840771481487 using(v16));
create or replace view aggJoin7792014109044227997 as (
with aggView900796042068492773 as (select id as v18 from keyword as k)
select movie_id as v36 from movie_keyword as mk, aggView900796042068492773 where mk.keyword_id=aggView900796042068492773.v18);
create or replace view aggJoin7594604343172595628 as (
with aggView4059103714863479086 as (select id as v5 from comp_cast_type as cct1 where kind= 'complete+verified')
select movie_id as v36 from complete_cast as cc, aggView4059103714863479086 where cc.status_id=aggView4059103714863479086.v5);
create or replace view aggJoin6305118218228905536 as (
with aggView5352564475580054897 as (select id as v7 from company_name as cn where country_code= '[us]')
select v36 from aggJoin4102374106498301488 join aggView5352564475580054897 using(v7));
create or replace view aggJoin6932638456397013198 as (
with aggView6384357796716768934 as (select v36 from aggJoin6305118218228905536 group by v36)
select v36 from aggJoin7594604343172595628 join aggView6384357796716768934 using(v36));
create or replace view aggJoin859363820135159330 as (
with aggView4857709486336194439 as (select v36 from aggJoin6932638456397013198 group by v36)
select v36, v31, v32, v48 as v48, v49 as v49 from aggJoin5352867270032421884 join aggView4857709486336194439 using(v36));
create or replace view aggJoin6369607077257942717 as (
with aggView928869067833086074 as (select v36, MIN(v48) as v48, MIN(v49) as v49 from aggJoin859363820135159330 group by v36,v49,v48)
select v48, v49 from aggJoin7792014109044227997 join aggView928869067833086074 using(v36));
select MIN(v48) as v48,MIN(v49) as v49 from aggJoin6369607077257942717;
