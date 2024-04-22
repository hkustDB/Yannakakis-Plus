create or replace view aggJoin6377278689974578888 as (
with aggView6298539349582606048 as (select id as v5 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v23 from movie_keyword as mk, aggView6298539349582606048 where mk.keyword_id=aggView6298539349582606048.v5);
create or replace view aggJoin6520598471354488930 as (
with aggView5854905906978034766 as (select id as v8 from kind_type as kt where kind IN ('movie','episode'))
select id as v23, title as v24, production_year as v27 from title as t, aggView5854905906978034766 where t.kind_id=aggView5854905906978034766.v8 and production_year>2005);
create or replace view aggJoin3991291427124496981 as (
with aggView6911769375050184892 as (select id as v3 from info_type as it2 where info= 'rating')
select movie_id as v23, info as v18 from movie_info_idx as mi_idx, aggView6911769375050184892 where mi_idx.info_type_id=aggView6911769375050184892.v3 and info<'8.5');
create or replace view aggView5367186425731124154 as select v18, v23 from aggJoin3991291427124496981 group by v18,v23;
create or replace view aggJoin6650608990379707256 as (
with aggView2763319359616145205 as (select id as v1 from info_type as it1 where info= 'countries')
select movie_id as v23, info as v13 from movie_info as mi, aggView2763319359616145205 where mi.info_type_id=aggView2763319359616145205.v1 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin2390538017500794706 as (
with aggView2599777432791173030 as (select v23 from aggJoin6650608990379707256 group by v23)
select v23 from aggJoin6377278689974578888 join aggView2599777432791173030 using(v23));
create or replace view aggJoin3097090384834002643 as (
with aggView3699387273661894001 as (select v23 from aggJoin2390538017500794706 group by v23)
select v23, v24, v27 from aggJoin6520598471354488930 join aggView3699387273661894001 using(v23));
create or replace view aggView1569978942862974489 as select v24, v23 from aggJoin3097090384834002643 group by v24,v23;
create or replace view aggJoin6945959216793944358 as (
with aggView3139326163739720362 as (select v23, MIN(v24) as v36 from aggView1569978942862974489 group by v23)
select v18, v36 from aggView5367186425731124154 join aggView3139326163739720362 using(v23));
select MIN(v18) as v35,MIN(v36) as v36 from aggJoin6945959216793944358;
