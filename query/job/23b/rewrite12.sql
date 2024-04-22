create or replace view aggJoin5425546613574562795 as (
with aggView1949107368618541472 as (select id as v21, kind as v48 from kind_type as kt where kind= 'movie')
select id as v36, title as v37, production_year as v40, v48 from title as t, aggView1949107368618541472 where t.kind_id=aggView1949107368618541472.v21 and production_year>2000);
create or replace view aggJoin2320537246279483104 as (
with aggView1068194140920564252 as (select v36, MIN(v48) as v48, MIN(v37) as v49 from aggJoin5425546613574562795 group by v36,v48)
select movie_id as v36, status_id as v5, v48, v49 from complete_cast as cc, aggView1068194140920564252 where cc.movie_id=aggView1068194140920564252.v36);
create or replace view aggJoin4915519108851868875 as (
with aggView4362712516256451121 as (select id as v14 from company_type as ct)
select movie_id as v36, company_id as v7 from movie_companies as mc, aggView4362712516256451121 where mc.company_type_id=aggView4362712516256451121.v14);
create or replace view aggJoin8361158201304105624 as (
with aggView8424277196784570331 as (select id as v18 from keyword as k where keyword IN ('nerd','loner','alienation','dignity'))
select movie_id as v36 from movie_keyword as mk, aggView8424277196784570331 where mk.keyword_id=aggView8424277196784570331.v18);
create or replace view aggJoin1794428670688926835 as (
with aggView199985940364378433 as (select id as v16 from info_type as it1 where info= 'release dates')
select movie_id as v36, info as v31, note as v32 from movie_info as mi, aggView199985940364378433 where mi.info_type_id=aggView199985940364378433.v16 and info LIKE 'USA:% 200%' and note LIKE '%internet%');
create or replace view aggJoin6615091129899758948 as (
with aggView8171071098977023771 as (select id as v5 from comp_cast_type as cct1 where kind= 'complete+verified')
select v36, v48, v49 from aggJoin2320537246279483104 join aggView8171071098977023771 using(v5));
create or replace view aggJoin3003373152236509743 as (
with aggView4893587690588172932 as (select v36 from aggJoin1794428670688926835 group by v36)
select v36 from aggJoin8361158201304105624 join aggView4893587690588172932 using(v36));
create or replace view aggJoin5591520436974032834 as (
with aggView35526091053092788 as (select id as v7 from company_name as cn where country_code= '[us]')
select v36 from aggJoin4915519108851868875 join aggView35526091053092788 using(v7));
create or replace view aggJoin2063519894816156247 as (
with aggView4793640455927521058 as (select v36 from aggJoin5591520436974032834 group by v36)
select v36, v48 as v48, v49 as v49 from aggJoin6615091129899758948 join aggView4793640455927521058 using(v36));
create or replace view aggJoin1160915906748559663 as (
with aggView6312472690071693349 as (select v36, MIN(v48) as v48, MIN(v49) as v49 from aggJoin2063519894816156247 group by v36,v48,v49)
select v48, v49 from aggJoin3003373152236509743 join aggView6312472690071693349 using(v36));
select MIN(v48) as v48,MIN(v49) as v49 from aggJoin1160915906748559663;
