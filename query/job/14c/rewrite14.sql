create or replace view aggJoin1877506373962092226 as (
with aggView564963811697599187 as (select id as v8 from kind_type as kt where kind IN ('movie','episode'))
select id as v23, title as v24, production_year as v27 from title as t, aggView564963811697599187 where t.kind_id=aggView564963811697599187.v8 and production_year>2005);
create or replace view aggJoin9169402610998548475 as (
with aggView3890072335697370947 as (select v23, MIN(v24) as v36 from aggJoin1877506373962092226 group by v23)
select movie_id as v23, info_type_id as v1, info as v13, v36 from movie_info as mi, aggView3890072335697370947 where mi.movie_id=aggView3890072335697370947.v23 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin8219375511543889977 as (
with aggView4228064990166081417 as (select id as v3 from info_type as it2 where info= 'rating')
select movie_id as v23, info as v18 from movie_info_idx as mi_idx, aggView4228064990166081417 where mi_idx.info_type_id=aggView4228064990166081417.v3 and info<'8.5');
create or replace view aggJoin6283771509440257026 as (
with aggView1288440108008213781 as (select id as v5 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v23 from movie_keyword as mk, aggView1288440108008213781 where mk.keyword_id=aggView1288440108008213781.v5);
create or replace view aggJoin7187989995389141840 as (
with aggView2606599867120664887 as (select id as v1 from info_type as it1 where info= 'countries')
select v23, v13, v36 from aggJoin9169402610998548475 join aggView2606599867120664887 using(v1));
create or replace view aggJoin9146151508378552940 as (
with aggView6582184976860902374 as (select v23, MIN(v36) as v36 from aggJoin7187989995389141840 group by v23,v36)
select v23, v18, v36 from aggJoin8219375511543889977 join aggView6582184976860902374 using(v23));
create or replace view aggJoin7477226666132633213 as (
with aggView1318944079583087220 as (select v23, MIN(v36) as v36, MIN(v18) as v35 from aggJoin9146151508378552940 group by v23,v36)
select v36, v35 from aggJoin6283771509440257026 join aggView1318944079583087220 using(v23));
select MIN(v35) as v35,MIN(v36) as v36 from aggJoin7477226666132633213;
