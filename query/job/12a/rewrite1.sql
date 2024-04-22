create or replace view aggView1364069363103185614 as select name as v2, id as v1 from company_name as cn where country_code= '[us]';
create or replace view aggView7975145367700266251 as select title as v30, id as v29 from title as t where production_year<=2008 and production_year>=2005;
create or replace view aggJoin3459645276270010537 as (
with aggView2274633838796088374 as (select id as v21 from info_type as it1 where info= 'genres')
select movie_id as v29, info as v22 from movie_info as mi, aggView2274633838796088374 where mi.info_type_id=aggView2274633838796088374.v21 and info IN ('Drama','Horror'));
create or replace view aggJoin7682692031805381562 as (
with aggView833537660033824704 as (select v29 from aggJoin3459645276270010537 group by v29)
select movie_id as v29, info_type_id as v26, info as v27 from movie_info_idx as mi_idx, aggView833537660033824704 where mi_idx.movie_id=aggView833537660033824704.v29);
create or replace view aggJoin3588693314578458106 as (
with aggView2285551233191444543 as (select id as v26 from info_type as it2 where info= 'rating')
select v29, v27 from aggJoin7682692031805381562 join aggView2285551233191444543 using(v26));
create or replace view aggJoin2210047126096941999 as (
with aggView3202802405925264088 as (select v27, v29 from aggJoin3588693314578458106 group by v27,v29)
select v29, v27 from aggView3202802405925264088 where v27>'8.0');
create or replace view aggJoin1570531591172554795 as (
with aggView8228229171565196025 as (select v29, MIN(v27) as v42 from aggJoin2210047126096941999 group by v29)
select v30, v29, v42 from aggView7975145367700266251 join aggView8228229171565196025 using(v29));
create or replace view aggJoin5142934322252959907 as (
with aggView3309836897705325059 as (select v29, MIN(v42) as v42, MIN(v30) as v43 from aggJoin1570531591172554795 group by v29,v42)
select company_id as v1, company_type_id as v8, v42, v43 from movie_companies as mc, aggView3309836897705325059 where mc.movie_id=aggView3309836897705325059.v29);
create or replace view aggJoin8029794341540989028 as (
with aggView4972360360918856943 as (select id as v8 from company_type as ct where kind= 'production companies')
select v1, v42, v43 from aggJoin5142934322252959907 join aggView4972360360918856943 using(v8));
create or replace view aggJoin9009848412445150982 as (
with aggView3522200063758271050 as (select v1, MIN(v42) as v42, MIN(v43) as v43 from aggJoin8029794341540989028 group by v1,v43,v42)
select v2, v42, v43 from aggView1364069363103185614 join aggView3522200063758271050 using(v1));
select MIN(v2) as v41,MIN(v42) as v42,MIN(v43) as v43 from aggJoin9009848412445150982;
