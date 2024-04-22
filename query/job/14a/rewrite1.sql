create or replace view aggJoin6127006412610220655 as (
with aggView672613871043863476 as (select id as v1 from info_type as it1 where info= 'countries')
select movie_id as v23, info as v13 from movie_info as mi, aggView672613871043863476 where mi.info_type_id=aggView672613871043863476.v1 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American'));
create or replace view aggJoin8227600680796216232 as (
with aggView2445522507533577356 as (select id as v3 from info_type as it2 where info= 'rating')
select movie_id as v23, info as v18 from movie_info_idx as mi_idx, aggView2445522507533577356 where mi_idx.info_type_id=aggView2445522507533577356.v3);
create or replace view aggJoin315067561452316897 as (
with aggView8109372465772145190 as (select id as v5 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v23 from movie_keyword as mk, aggView8109372465772145190 where mk.keyword_id=aggView8109372465772145190.v5);
create or replace view aggJoin7446080670432738411 as (
with aggView3120444050740169276 as (select id as v8 from kind_type as kt where kind= 'movie')
select id as v23, title as v24, production_year as v27 from title as t, aggView3120444050740169276 where t.kind_id=aggView3120444050740169276.v8 and production_year>2010);
create or replace view aggJoin6953110307724140836 as (
with aggView3061262340526137515 as (select v23 from aggJoin315067561452316897 group by v23)
select v23, v18 from aggJoin8227600680796216232 join aggView3061262340526137515 using(v23));
create or replace view aggJoin221522104359808600 as (
with aggView2563130839087525213 as (select v23, v18 from aggJoin6953110307724140836 group by v23,v18)
select v23, v18 from aggView2563130839087525213 where v18<'8.5');
create or replace view aggJoin2139901431854994929 as (
with aggView1399796263204717761 as (select v23 from aggJoin6127006412610220655 group by v23)
select v23, v24, v27 from aggJoin7446080670432738411 join aggView1399796263204717761 using(v23));
create or replace view aggView846937532806165255 as select v23, v24 from aggJoin2139901431854994929 group by v23,v24;
create or replace view aggJoin9055868165775184658 as (
with aggView8678884666778367367 as (select v23, MIN(v24) as v36 from aggView846937532806165255 group by v23)
select v18, v36 from aggJoin221522104359808600 join aggView8678884666778367367 using(v23));
select MIN(v18) as v35,MIN(v36) as v36 from aggJoin9055868165775184658;
