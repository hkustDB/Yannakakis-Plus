create or replace view aggJoin1924710541544652484 as (
with aggView363200722902190022 as (select id as v5 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v23 from movie_keyword as mk, aggView363200722902190022 where mk.keyword_id=aggView363200722902190022.v5);
create or replace view aggJoin2247888987703696813 as (
with aggView3422107952199460826 as (select id as v1 from info_type as it1 where info= 'countries')
select movie_id as v23, info as v13 from movie_info as mi, aggView3422107952199460826 where mi.info_type_id=aggView3422107952199460826.v1 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American'));
create or replace view aggJoin4625510278427440407 as (
with aggView8728147749440710892 as (select id as v3 from info_type as it2 where info= 'rating')
select movie_id as v23, info as v18 from movie_info_idx as mi_idx, aggView8728147749440710892 where mi_idx.info_type_id=aggView8728147749440710892.v3);
create or replace view aggJoin2585048255405115379 as (
with aggView6153000663263965581 as (select v23, v18 from aggJoin4625510278427440407 group by v23,v18)
select v23, v18 from aggView6153000663263965581 where v18<'8.5');
create or replace view aggJoin8767103755824844986 as (
with aggView4898556613753425944 as (select v23 from aggJoin1924710541544652484 group by v23)
select v23, v13 from aggJoin2247888987703696813 join aggView4898556613753425944 using(v23));
create or replace view aggJoin1353186257835682061 as (
with aggView4449912661397079179 as (select id as v8 from kind_type as kt where kind= 'movie')
select id as v23, title as v24, production_year as v27 from title as t, aggView4449912661397079179 where t.kind_id=aggView4449912661397079179.v8 and production_year>2010);
create or replace view aggJoin4508083867586310183 as (
with aggView3270803175689739611 as (select v23 from aggJoin8767103755824844986 group by v23)
select v23, v24, v27 from aggJoin1353186257835682061 join aggView3270803175689739611 using(v23));
create or replace view aggView6691277475498937654 as select v23, v24 from aggJoin4508083867586310183 group by v23,v24;
create or replace view aggJoin8083725426924201523 as (
with aggView6158984808709325080 as (select v23, MIN(v24) as v36 from aggView6691277475498937654 group by v23)
select v18, v36 from aggJoin2585048255405115379 join aggView6158984808709325080 using(v23));
select MIN(v18) as v35,MIN(v36) as v36 from aggJoin8083725426924201523;
