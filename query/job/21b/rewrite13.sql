create or replace view aggJoin6810364273867189538 as (
with aggView7244083275784807520 as (select id as v13, link as v45 from link_type as lt where link LIKE '%follow%')
select movie_id as v29, v45 from movie_link as ml, aggView7244083275784807520 where ml.link_type_id=aggView7244083275784807520.v13);
create or replace view aggJoin8131379325299699149 as (
with aggView771876613615271262 as (select id as v17, name as v44 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%')))
select movie_id as v29, company_type_id as v18, v44 from movie_companies as mc, aggView771876613615271262 where mc.company_id=aggView771876613615271262.v17);
create or replace view aggJoin3807118955749022928 as (
with aggView734254012505371214 as (select id as v27 from keyword as k where keyword= 'sequel')
select movie_id as v29 from movie_keyword as mk, aggView734254012505371214 where mk.keyword_id=aggView734254012505371214.v27);
create or replace view aggJoin4071806361652479727 as (
with aggView763291330467245115 as (select id as v18 from company_type as ct where kind= 'production companies')
select v29, v44 from aggJoin8131379325299699149 join aggView763291330467245115 using(v18));
create or replace view aggJoin8405396319357656566 as (
with aggView543069368906879339 as (select v29, MIN(v45) as v45 from aggJoin6810364273867189538 group by v29,v45)
select v29, v44 as v44, v45 from aggJoin4071806361652479727 join aggView543069368906879339 using(v29));
create or replace view aggJoin1678480751882883965 as (
with aggView3211514613745038165 as (select v29, MIN(v44) as v44, MIN(v45) as v45 from aggJoin8405396319357656566 group by v29,v45,v44)
select id as v29, title as v33, production_year as v36, v44, v45 from title as t, aggView3211514613745038165 where t.id=aggView3211514613745038165.v29 and production_year<=2010 and production_year>=2000);
create or replace view aggJoin4990287913203655852 as (
with aggView3673067626666794028 as (select v29, MIN(v44) as v44, MIN(v45) as v45, MIN(v33) as v46 from aggJoin1678480751882883965 group by v29,v45,v44)
select movie_id as v29, info as v23, v44, v45, v46 from movie_info as mi, aggView3673067626666794028 where mi.movie_id=aggView3673067626666794028.v29 and info IN ('Germany','German'));
create or replace view aggJoin4068477130894131608 as (
with aggView2178039304282861656 as (select v29, MIN(v44) as v44, MIN(v45) as v45, MIN(v46) as v46 from aggJoin4990287913203655852 group by v29,v46,v45,v44)
select v44, v45, v46 from aggJoin3807118955749022928 join aggView2178039304282861656 using(v29));
select MIN(v44) as v44,MIN(v45) as v45,MIN(v46) as v46 from aggJoin4068477130894131608;
