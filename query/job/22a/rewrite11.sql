create or replace view aggJoin7369040628386394753 as (
with aggView3824329885582020863 as (select id as v1, name as v49 from company_name as cn where country_code<> '[us]')
select movie_id as v37, company_type_id as v8, note as v23, v49 from movie_companies as mc, aggView3824329885582020863 where mc.company_id=aggView3824329885582020863.v1 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin1944248384197570538 as (
with aggView4440942971530199390 as (select id as v8 from company_type as ct)
select v37, v23, v49 from aggJoin7369040628386394753 join aggView4440942971530199390 using(v8));
create or replace view aggJoin7044426024567270650 as (
with aggView8162867635086439678 as (select id as v12 from info_type as it2 where info= 'rating')
select movie_id as v37, info as v32 from movie_info_idx as mi_idx, aggView8162867635086439678 where mi_idx.info_type_id=aggView8162867635086439678.v12 and info<'7.0');
create or replace view aggJoin6192196735940611008 as (
with aggView387669921889799796 as (select id as v17 from kind_type as kt where kind IN ('movie','episode'))
select id as v37, title as v38, production_year as v41 from title as t, aggView387669921889799796 where t.kind_id=aggView387669921889799796.v17 and production_year>2008);
create or replace view aggJoin4636449561206209124 as (
with aggView3370983642031687416 as (select id as v10 from info_type as it1 where info= 'countries')
select movie_id as v37, info as v27 from movie_info as mi, aggView3370983642031687416 where mi.info_type_id=aggView3370983642031687416.v10 and info IN ('Germany','German','USA','American'));
create or replace view aggJoin2627693712020271599 as (
with aggView2630761762628223443 as (select v37 from aggJoin4636449561206209124 group by v37)
select v37, v38, v41 from aggJoin6192196735940611008 join aggView2630761762628223443 using(v37));
create or replace view aggJoin3478335586937490582 as (
with aggView1002506921286023264 as (select v37, MIN(v38) as v51 from aggJoin2627693712020271599 group by v37)
select v37, v32, v51 from aggJoin7044426024567270650 join aggView1002506921286023264 using(v37));
create or replace view aggJoin3437025547029111739 as (
with aggView6779663913214495643 as (select v37, MIN(v51) as v51, MIN(v32) as v50 from aggJoin3478335586937490582 group by v37,v51)
select v37, v23, v49 as v49, v51, v50 from aggJoin1944248384197570538 join aggView6779663913214495643 using(v37));
create or replace view aggJoin6732111037931986980 as (
with aggView8004015920776820814 as (select v37, MIN(v49) as v49, MIN(v51) as v51, MIN(v50) as v50 from aggJoin3437025547029111739 group by v37,v49,v50,v51)
select keyword_id as v14, v49, v51, v50 from movie_keyword as mk, aggView8004015920776820814 where mk.movie_id=aggView8004015920776820814.v37);
create or replace view aggJoin8678081576388426695 as (
with aggView5461014719810564579 as (select id as v14 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select v49, v51, v50 from aggJoin6732111037931986980 join aggView5461014719810564579 using(v14));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v51) as v51 from aggJoin8678081576388426695;
