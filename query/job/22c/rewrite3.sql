create or replace view aggView7952524614813164562 as select id as v1, name as v2 from company_name as cn where country_code<> '[us]';
create or replace view aggJoin8385930891430902359 as (
with aggView4999066980812226910 as (select id as v17 from kind_type as kt where kind IN ('movie','episode'))
select id as v37, title as v38, production_year as v41 from title as t, aggView4999066980812226910 where t.kind_id=aggView4999066980812226910.v17 and production_year>2005);
create or replace view aggView2597570847569721301 as select v38, v37 from aggJoin8385930891430902359 group by v38,v37;
create or replace view aggJoin7344503718668870118 as (
with aggView758550490592755446 as (select id as v12 from info_type as it2 where info= 'rating')
select movie_id as v37, info as v32 from movie_info_idx as mi_idx, aggView758550490592755446 where mi_idx.info_type_id=aggView758550490592755446.v12 and info<'8.5');
create or replace view aggJoin4274815275457067710 as (
with aggView7397563501636719003 as (select id as v10 from info_type as it1 where info= 'countries')
select movie_id as v37, info as v27 from movie_info as mi, aggView7397563501636719003 where mi.info_type_id=aggView7397563501636719003.v10 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin8834513747167693029 as (
with aggView5391020317796971871 as (select v37 from aggJoin4274815275457067710 group by v37)
select v37, v32 from aggJoin7344503718668870118 join aggView5391020317796971871 using(v37));
create or replace view aggJoin7249732935877939134 as (
with aggView749441966687463084 as (select id as v14 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v37 from movie_keyword as mk, aggView749441966687463084 where mk.keyword_id=aggView749441966687463084.v14);
create or replace view aggJoin569816036844752662 as (
with aggView4412517265481139904 as (select v37 from aggJoin7249732935877939134 group by v37)
select v37, v32 from aggJoin8834513747167693029 join aggView4412517265481139904 using(v37));
create or replace view aggView6088523920069285064 as select v37, v32 from aggJoin569816036844752662 group by v37,v32;
create or replace view aggJoin5710965238567240989 as (
with aggView5897730288031386179 as (select v1, MIN(v2) as v49 from aggView7952524614813164562 group by v1)
select movie_id as v37, company_type_id as v8, note as v23, v49 from movie_companies as mc, aggView5897730288031386179 where mc.company_id=aggView5897730288031386179.v1 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin2465822262318187793 as (
with aggView7358236802862745793 as (select id as v8 from company_type as ct)
select v37, v23, v49 from aggJoin5710965238567240989 join aggView7358236802862745793 using(v8));
create or replace view aggJoin8101542505716071596 as (
with aggView574599367392551922 as (select v37, MIN(v49) as v49 from aggJoin2465822262318187793 group by v37,v49)
select v38, v37, v49 from aggView2597570847569721301 join aggView574599367392551922 using(v37));
create or replace view aggJoin5747302370661392689 as (
with aggView8248071121244194536 as (select v37, MIN(v49) as v49, MIN(v38) as v51 from aggJoin8101542505716071596 group by v37,v49)
select v32, v49, v51 from aggView6088523920069285064 join aggView8248071121244194536 using(v37));
select MIN(v49) as v49,MIN(v32) as v50,MIN(v51) as v51 from aggJoin5747302370661392689;
