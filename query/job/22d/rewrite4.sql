create or replace view aggView7350079378717744723 as select name as v2, id as v1 from company_name as cn where country_code<> '[us]';
create or replace view aggJoin3848147531563997695 as (
with aggView9221487633820631065 as (select id as v10 from info_type as it1 where info= 'countries')
select movie_id as v37, info as v27 from movie_info as mi, aggView9221487633820631065 where mi.info_type_id=aggView9221487633820631065.v10 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin8230728366051366882 as (
with aggView7201637467063205736 as (select id as v14 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v37 from movie_keyword as mk, aggView7201637467063205736 where mk.keyword_id=aggView7201637467063205736.v14);
create or replace view aggJoin5593172445813658168 as (
with aggView1050092598548890259 as (select v37 from aggJoin8230728366051366882 group by v37)
select movie_id as v37, info_type_id as v12, info as v32 from movie_info_idx as mi_idx, aggView1050092598548890259 where mi_idx.movie_id=aggView1050092598548890259.v37);
create or replace view aggJoin5716543358916569796 as (
with aggView2781934141285187988 as (select id as v12 from info_type as it2 where info= 'rating')
select v37, v32 from aggJoin5593172445813658168 join aggView2781934141285187988 using(v12));
create or replace view aggJoin1534565867495465469 as (
with aggView8299942768303578727 as (select v37 from aggJoin3848147531563997695 group by v37)
select v37, v32 from aggJoin5716543358916569796 join aggView8299942768303578727 using(v37));
create or replace view aggJoin7578667955731886604 as (
with aggView2679813800486462228 as (select v32, v37 from aggJoin1534565867495465469 group by v32,v37)
select v37, v32 from aggView2679813800486462228 where v32<'8.5');
create or replace view aggJoin7179369368464652201 as (
with aggView2477526591582489550 as (select id as v17 from kind_type as kt where kind IN ('movie','episode'))
select id as v37, title as v38, production_year as v41 from title as t, aggView2477526591582489550 where t.kind_id=aggView2477526591582489550.v17 and production_year>2005);
create or replace view aggView1093109791744823010 as select v37, v38 from aggJoin7179369368464652201 group by v37,v38;
create or replace view aggJoin3080240463999331142 as (
with aggView6431249867567429399 as (select v37, MIN(v32) as v50 from aggJoin7578667955731886604 group by v37)
select v37, v38, v50 from aggView1093109791744823010 join aggView6431249867567429399 using(v37));
create or replace view aggJoin2218665671457058421 as (
with aggView468702005575648282 as (select v37, MIN(v50) as v50, MIN(v38) as v51 from aggJoin3080240463999331142 group by v37,v50)
select company_id as v1, company_type_id as v8, v50, v51 from movie_companies as mc, aggView468702005575648282 where mc.movie_id=aggView468702005575648282.v37);
create or replace view aggJoin8186169473592499639 as (
with aggView5540854397989399073 as (select id as v8 from company_type as ct)
select v1, v50, v51 from aggJoin2218665671457058421 join aggView5540854397989399073 using(v8));
create or replace view aggJoin3939438126188123076 as (
with aggView1199724042381752044 as (select v1, MIN(v50) as v50, MIN(v51) as v51 from aggJoin8186169473592499639 group by v1,v51,v50)
select v2, v50, v51 from aggView7350079378717744723 join aggView1199724042381752044 using(v1));
select MIN(v2) as v49,MIN(v50) as v50,MIN(v51) as v51 from aggJoin3939438126188123076;
