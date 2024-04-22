create or replace view aggJoin4977942544406750032 as (
with aggView903102923917926604 as (select id as v21, link as v53 from link_type as lt where link LIKE '%follow%')
select movie_id as v37, v53 from movie_link as ml, aggView903102923917926604 where ml.link_type_id=aggView903102923917926604.v21);
create or replace view aggJoin4086951265815245964 as (
with aggView1241636143609956671 as (select id as v25, name as v52 from company_name as cn where ((name LIKE '%Film%') OR (name LIKE '%Warner%')) and country_code<> '[pl]')
select movie_id as v37, company_type_id as v26, v52 from movie_companies as mc, aggView1241636143609956671 where mc.company_id=aggView1241636143609956671.v25);
create or replace view aggJoin272893210987563710 as (
with aggView7059196240435438910 as (select id as v5 from comp_cast_type as cct1 where kind IN ('cast','crew'))
select movie_id as v37, status_id as v7 from complete_cast as cc, aggView7059196240435438910 where cc.subject_id=aggView7059196240435438910.v5);
create or replace view aggJoin4782658911640141705 as (
with aggView8312400861355147478 as (select v37, MIN(v53) as v53 from aggJoin4977942544406750032 group by v37,v53)
select id as v37, title as v41, production_year as v44, v53 from title as t, aggView8312400861355147478 where t.id=aggView8312400861355147478.v37 and production_year= 1998);
create or replace view aggJoin2404128020847058867 as (
with aggView6156047784261701553 as (select v37, MIN(v53) as v53, MIN(v41) as v54 from aggJoin4782658911640141705 group by v37,v53)
select v37, v26, v52 as v52, v53, v54 from aggJoin4086951265815245964 join aggView6156047784261701553 using(v37));
create or replace view aggJoin76419836632674425 as (
with aggView5169657248400615088 as (select id as v35 from keyword as k where keyword= 'sequel')
select movie_id as v37 from movie_keyword as mk, aggView5169657248400615088 where mk.keyword_id=aggView5169657248400615088.v35);
create or replace view aggJoin9062764012379503299 as (
with aggView9012761931411004191 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete')
select v37 from aggJoin272893210987563710 join aggView9012761931411004191 using(v7));
create or replace view aggJoin7564604357933696026 as (
with aggView1473164620660385800 as (select v37 from aggJoin9062764012379503299 group by v37)
select movie_id as v37, info as v31 from movie_info as mi, aggView1473164620660385800 where mi.movie_id=aggView1473164620660385800.v37 and info IN ('Sweden','Germany','Swedish','German'));
create or replace view aggJoin4026600751722735972 as (
with aggView2446306092059802435 as (select id as v26 from company_type as ct where kind= 'production companies')
select v37, v52, v53, v54 from aggJoin2404128020847058867 join aggView2446306092059802435 using(v26));
create or replace view aggJoin1186792115189703159 as (
with aggView1060805478161484371 as (select v37, MIN(v52) as v52, MIN(v53) as v53, MIN(v54) as v54 from aggJoin4026600751722735972 group by v37,v53,v52,v54)
select v37, v31, v52, v53, v54 from aggJoin7564604357933696026 join aggView1060805478161484371 using(v37));
create or replace view aggJoin5728329138835737234 as (
with aggView3386848207330619571 as (select v37, MIN(v52) as v52, MIN(v53) as v53, MIN(v54) as v54 from aggJoin1186792115189703159 group by v37,v53,v52,v54)
select v52, v53, v54 from aggJoin76419836632674425 join aggView3386848207330619571 using(v37));
select MIN(v52) as v52,MIN(v53) as v53,MIN(v54) as v54 from aggJoin5728329138835737234;
