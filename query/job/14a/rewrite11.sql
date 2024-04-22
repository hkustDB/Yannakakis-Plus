create or replace view aggJoin588564566271899426 as (
with aggView705283652389175353 as (select id as v3 from info_type as it2 where info= 'rating')
select movie_id as v23, info as v18 from movie_info_idx as mi_idx, aggView705283652389175353 where mi_idx.info_type_id=aggView705283652389175353.v3 and info<'8.5');
create or replace view aggJoin2142504680337567014 as (
with aggView5236663653628571021 as (select v23, MIN(v18) as v35 from aggJoin588564566271899426 group by v23)
select id as v23, title as v24, kind_id as v8, production_year as v27, v35 from title as t, aggView5236663653628571021 where t.id=aggView5236663653628571021.v23 and production_year>2010);
create or replace view aggJoin2514007001680985039 as (
with aggView7729205689223310470 as (select id as v1 from info_type as it1 where info= 'countries')
select movie_id as v23, info as v13 from movie_info as mi, aggView7729205689223310470 where mi.info_type_id=aggView7729205689223310470.v1 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American'));
create or replace view aggJoin3053905038575554428 as (
with aggView8915788475231161939 as (select id as v5 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v23 from movie_keyword as mk, aggView8915788475231161939 where mk.keyword_id=aggView8915788475231161939.v5);
create or replace view aggJoin4869590521803778715 as (
with aggView5267083412083453116 as (select id as v8 from kind_type as kt where kind= 'movie')
select v23, v24, v27, v35 from aggJoin2142504680337567014 join aggView5267083412083453116 using(v8));
create or replace view aggJoin4198529844134242102 as (
with aggView293327304084471837 as (select v23, MIN(v35) as v35, MIN(v24) as v36 from aggJoin4869590521803778715 group by v23,v35)
select v23, v13, v35, v36 from aggJoin2514007001680985039 join aggView293327304084471837 using(v23));
create or replace view aggJoin1083145392639535127 as (
with aggView3844573403193956512 as (select v23, MIN(v35) as v35, MIN(v36) as v36 from aggJoin4198529844134242102 group by v23,v36,v35)
select v35, v36 from aggJoin3053905038575554428 join aggView3844573403193956512 using(v23));
select MIN(v35) as v35,MIN(v36) as v36 from aggJoin1083145392639535127;
