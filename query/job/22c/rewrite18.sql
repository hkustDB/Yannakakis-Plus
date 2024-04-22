create or replace view aggJoin3291953716817636219 as (
with aggView8918810077981331681 as (select id as v1, name as v49 from company_name as cn where country_code<> '[us]')
select movie_id as v37, company_type_id as v8, note as v23, v49 from movie_companies as mc, aggView8918810077981331681 where mc.company_id=aggView8918810077981331681.v1 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin8164235423310495444 as (
with aggView3616089966199426710 as (select id as v8 from company_type as ct)
select v37, v23, v49 from aggJoin3291953716817636219 join aggView3616089966199426710 using(v8));
create or replace view aggJoin818992431514302609 as (
with aggView1107706028725408319 as (select id as v17 from kind_type as kt where kind IN ('movie','episode'))
select id as v37, title as v38, production_year as v41 from title as t, aggView1107706028725408319 where t.kind_id=aggView1107706028725408319.v17 and production_year>2005);
create or replace view aggJoin3777576476038109443 as (
with aggView6160044042643552742 as (select v37, MIN(v38) as v51 from aggJoin818992431514302609 group by v37)
select movie_id as v37, keyword_id as v14, v51 from movie_keyword as mk, aggView6160044042643552742 where mk.movie_id=aggView6160044042643552742.v37);
create or replace view aggJoin6213928622265135043 as (
with aggView610164502464289587 as (select id as v12 from info_type as it2 where info= 'rating')
select movie_id as v37, info as v32 from movie_info_idx as mi_idx, aggView610164502464289587 where mi_idx.info_type_id=aggView610164502464289587.v12 and info<'8.5');
create or replace view aggJoin6855051926120565709 as (
with aggView3634409026114040766 as (select v37, MIN(v32) as v50 from aggJoin6213928622265135043 group by v37)
select v37, v23, v49 as v49, v50 from aggJoin8164235423310495444 join aggView3634409026114040766 using(v37));
create or replace view aggJoin1382067219111177419 as (
with aggView1356368691006745917 as (select id as v10 from info_type as it1 where info= 'countries')
select movie_id as v37, info as v27 from movie_info as mi, aggView1356368691006745917 where mi.info_type_id=aggView1356368691006745917.v10 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin223902727712583296 as (
with aggView1121627217781009243 as (select v37 from aggJoin1382067219111177419 group by v37)
select v37, v23, v49 as v49, v50 as v50 from aggJoin6855051926120565709 join aggView1121627217781009243 using(v37));
create or replace view aggJoin8142794885108509218 as (
with aggView7447455432122720087 as (select v37, MIN(v49) as v49, MIN(v50) as v50 from aggJoin223902727712583296 group by v37,v49,v50)
select v14, v51 as v51, v49, v50 from aggJoin3777576476038109443 join aggView7447455432122720087 using(v37));
create or replace view aggJoin1597694778949306881 as (
with aggView5192926563614826468 as (select id as v14 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select v51, v49, v50 from aggJoin8142794885108509218 join aggView5192926563614826468 using(v14));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v51) as v51 from aggJoin1597694778949306881;
