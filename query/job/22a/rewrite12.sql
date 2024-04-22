create or replace view aggJoin4216779307050171576 as (
with aggView2623003218140674031 as (select id as v1, name as v49 from company_name as cn where country_code<> '[us]')
select movie_id as v37, company_type_id as v8, note as v23, v49 from movie_companies as mc, aggView2623003218140674031 where mc.company_id=aggView2623003218140674031.v1 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin5590232887301078943 as (
with aggView4020507557235358685 as (select id as v8 from company_type as ct)
select v37, v23, v49 from aggJoin4216779307050171576 join aggView4020507557235358685 using(v8));
create or replace view aggJoin5565264798536885141 as (
with aggView6558623413114690987 as (select id as v12 from info_type as it2 where info= 'rating')
select movie_id as v37, info as v32 from movie_info_idx as mi_idx, aggView6558623413114690987 where mi_idx.info_type_id=aggView6558623413114690987.v12 and info<'7.0');
create or replace view aggJoin8973493013697450841 as (
with aggView6596059187676813834 as (select v37, MIN(v32) as v50 from aggJoin5565264798536885141 group by v37)
select v37, v23, v49 as v49, v50 from aggJoin5590232887301078943 join aggView6596059187676813834 using(v37));
create or replace view aggJoin2365238434663136693 as (
with aggView3741266338446241021 as (select id as v17 from kind_type as kt where kind IN ('movie','episode'))
select id as v37, title as v38, production_year as v41 from title as t, aggView3741266338446241021 where t.kind_id=aggView3741266338446241021.v17 and production_year>2008);
create or replace view aggJoin5110206169955507328 as (
with aggView2511716182563960857 as (select v37, MIN(v38) as v51 from aggJoin2365238434663136693 group by v37)
select movie_id as v37, keyword_id as v14, v51 from movie_keyword as mk, aggView2511716182563960857 where mk.movie_id=aggView2511716182563960857.v37);
create or replace view aggJoin62989093282662478 as (
with aggView6885920255958143206 as (select id as v10 from info_type as it1 where info= 'countries')
select movie_id as v37, info as v27 from movie_info as mi, aggView6885920255958143206 where mi.info_type_id=aggView6885920255958143206.v10 and info IN ('Germany','German','USA','American'));
create or replace view aggJoin5388656764555635579 as (
with aggView2463130119989957698 as (select v37, MIN(v49) as v49, MIN(v50) as v50 from aggJoin8973493013697450841 group by v37,v49,v50)
select v37, v27, v49, v50 from aggJoin62989093282662478 join aggView2463130119989957698 using(v37));
create or replace view aggJoin6981392894611312191 as (
with aggView1424798903812248228 as (select v37, MIN(v49) as v49, MIN(v50) as v50 from aggJoin5388656764555635579 group by v37,v49,v50)
select v14, v51 as v51, v49, v50 from aggJoin5110206169955507328 join aggView1424798903812248228 using(v37));
create or replace view aggJoin6461920390374407772 as (
with aggView521512924764762179 as (select id as v14 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select v51, v49, v50 from aggJoin6981392894611312191 join aggView521512924764762179 using(v14));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v51) as v51 from aggJoin6461920390374407772;
