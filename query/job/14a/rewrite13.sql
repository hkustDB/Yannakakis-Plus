create or replace view aggJoin4482881979221781908 as (
with aggView7054339154975978724 as (select id as v3 from info_type as it2 where info= 'rating')
select movie_id as v23, info as v18 from movie_info_idx as mi_idx, aggView7054339154975978724 where mi_idx.info_type_id=aggView7054339154975978724.v3 and info<'8.5');
create or replace view aggJoin6140492381009592643 as (
with aggView6928544336662372119 as (select id as v1 from info_type as it1 where info= 'countries')
select movie_id as v23, info as v13 from movie_info as mi, aggView6928544336662372119 where mi.info_type_id=aggView6928544336662372119.v1 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American'));
create or replace view aggJoin4463800819296887823 as (
with aggView9028506363751010206 as (select id as v5 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v23 from movie_keyword as mk, aggView9028506363751010206 where mk.keyword_id=aggView9028506363751010206.v5);
create or replace view aggJoin157031104989397514 as (
with aggView8160036814947822212 as (select id as v8 from kind_type as kt where kind= 'movie')
select id as v23, title as v24, production_year as v27 from title as t, aggView8160036814947822212 where t.kind_id=aggView8160036814947822212.v8 and production_year>2010);
create or replace view aggJoin6457330154416687749 as (
with aggView7810137755681806209 as (select v23 from aggJoin6140492381009592643 group by v23)
select v23, v24, v27 from aggJoin157031104989397514 join aggView7810137755681806209 using(v23));
create or replace view aggJoin2433452799591666596 as (
with aggView2075285520447464276 as (select v23, MIN(v24) as v36 from aggJoin6457330154416687749 group by v23)
select v23, v18, v36 from aggJoin4482881979221781908 join aggView2075285520447464276 using(v23));
create or replace view aggJoin136116966538775189 as (
with aggView616351447167415443 as (select v23, MIN(v36) as v36, MIN(v18) as v35 from aggJoin2433452799591666596 group by v23,v36)
select v36, v35 from aggJoin4463800819296887823 join aggView616351447167415443 using(v23));
select MIN(v35) as v35,MIN(v36) as v36 from aggJoin136116966538775189;
