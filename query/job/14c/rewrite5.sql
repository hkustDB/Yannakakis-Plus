create or replace view aggJoin4725145344084879624 as (
with aggView2531401712755624568 as (select id as v3 from info_type as it2 where info= 'rating')
select movie_id as v23, info as v18 from movie_info_idx as mi_idx, aggView2531401712755624568 where mi_idx.info_type_id=aggView2531401712755624568.v3 and info<'8.5');
create or replace view aggView9153849522465771689 as select v18, v23 from aggJoin4725145344084879624 group by v18,v23;
create or replace view aggJoin3076525312273099736 as (
with aggView3117012473040849395 as (select id as v5 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v23 from movie_keyword as mk, aggView3117012473040849395 where mk.keyword_id=aggView3117012473040849395.v5);
create or replace view aggJoin7061305392500352890 as (
with aggView1361474679428088043 as (select id as v8 from kind_type as kt where kind IN ('movie','episode'))
select id as v23, title as v24, production_year as v27 from title as t, aggView1361474679428088043 where t.kind_id=aggView1361474679428088043.v8 and production_year>2005);
create or replace view aggJoin7276766912894106906 as (
with aggView432803896262336331 as (select id as v1 from info_type as it1 where info= 'countries')
select movie_id as v23, info as v13 from movie_info as mi, aggView432803896262336331 where mi.info_type_id=aggView432803896262336331.v1 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin8607321520669962738 as (
with aggView1839916382183287841 as (select v23 from aggJoin3076525312273099736 group by v23)
select v23, v13 from aggJoin7276766912894106906 join aggView1839916382183287841 using(v23));
create or replace view aggJoin2539266371101512395 as (
with aggView6669465209324166292 as (select v23 from aggJoin8607321520669962738 group by v23)
select v23, v24, v27 from aggJoin7061305392500352890 join aggView6669465209324166292 using(v23));
create or replace view aggView6818302105301715342 as select v24, v23 from aggJoin2539266371101512395 group by v24,v23;
create or replace view aggJoin4962639852540073208 as (
with aggView2833121221700230911 as (select v23, MIN(v18) as v35 from aggView9153849522465771689 group by v23)
select v24, v35 from aggView6818302105301715342 join aggView2833121221700230911 using(v23));
select MIN(v35) as v35,MIN(v24) as v36 from aggJoin4962639852540073208;
