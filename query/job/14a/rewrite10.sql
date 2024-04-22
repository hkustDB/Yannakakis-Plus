create or replace view aggJoin5835367327841300272 as (
with aggView2756999585611971376 as (select id as v3 from info_type as it2 where info= 'rating')
select movie_id as v23, info as v18 from movie_info_idx as mi_idx, aggView2756999585611971376 where mi_idx.info_type_id=aggView2756999585611971376.v3 and info<'8.5');
create or replace view aggJoin6031374739534679489 as (
with aggView5445741952830170811 as (select id as v1 from info_type as it1 where info= 'countries')
select movie_id as v23, info as v13 from movie_info as mi, aggView5445741952830170811 where mi.info_type_id=aggView5445741952830170811.v1 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American'));
create or replace view aggJoin6563417982733580825 as (
with aggView4774250966378361700 as (select id as v5 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v23 from movie_keyword as mk, aggView4774250966378361700 where mk.keyword_id=aggView4774250966378361700.v5);
create or replace view aggJoin3911468534591641533 as (
with aggView3062687110813816573 as (select v23 from aggJoin6031374739534679489 group by v23)
select v23, v18 from aggJoin5835367327841300272 join aggView3062687110813816573 using(v23));
create or replace view aggJoin9095460317273014240 as (
with aggView427699312853290392 as (select v23, MIN(v18) as v35 from aggJoin3911468534591641533 group by v23)
select id as v23, title as v24, kind_id as v8, production_year as v27, v35 from title as t, aggView427699312853290392 where t.id=aggView427699312853290392.v23 and production_year>2010);
create or replace view aggJoin3841133057405516195 as (
with aggView6548140504314879798 as (select id as v8 from kind_type as kt where kind= 'movie')
select v23, v24, v27, v35 from aggJoin9095460317273014240 join aggView6548140504314879798 using(v8));
create or replace view aggJoin1423786438649049526 as (
with aggView5628072917357281178 as (select v23, MIN(v35) as v35, MIN(v24) as v36 from aggJoin3841133057405516195 group by v23,v35)
select v35, v36 from aggJoin6563417982733580825 join aggView5628072917357281178 using(v23));
select MIN(v35) as v35,MIN(v36) as v36 from aggJoin1423786438649049526;
