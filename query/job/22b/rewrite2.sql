create or replace view aggView1222074857900887351 as select id as v1, name as v2 from company_name as cn where country_code<> '[us]';
create or replace view aggJoin6966680843072868878 as (
with aggView6256736906190201338 as (select id as v12 from info_type as it2 where info= 'rating')
select movie_id as v37, info as v32 from movie_info_idx as mi_idx, aggView6256736906190201338 where mi_idx.info_type_id=aggView6256736906190201338.v12);
create or replace view aggJoin154666905628291212 as (
with aggView2162806206194190734 as (select v37, v32 from aggJoin6966680843072868878 group by v37,v32)
select v37, v32 from aggView2162806206194190734 where v32<'7.0');
create or replace view aggJoin1817058907359236204 as (
with aggView5811419599805700964 as (select id as v17 from kind_type as kt where kind IN ('movie','episode'))
select id as v37, title as v38, production_year as v41 from title as t, aggView5811419599805700964 where t.kind_id=aggView5811419599805700964.v17 and production_year>2009);
create or replace view aggJoin7674050883121326222 as (
with aggView1923988525949281850 as (select id as v10 from info_type as it1 where info= 'countries')
select movie_id as v37, info as v27 from movie_info as mi, aggView1923988525949281850 where mi.info_type_id=aggView1923988525949281850.v10 and info IN ('Germany','German','USA','American'));
create or replace view aggJoin1000412994138821487 as (
with aggView6553770848303010042 as (select id as v14 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v37 from movie_keyword as mk, aggView6553770848303010042 where mk.keyword_id=aggView6553770848303010042.v14);
create or replace view aggJoin1346135816577734286 as (
with aggView1767297926186804691 as (select v37 from aggJoin1000412994138821487 group by v37)
select v37, v38, v41 from aggJoin1817058907359236204 join aggView1767297926186804691 using(v37));
create or replace view aggJoin1176461296451090251 as (
with aggView6624879124495055498 as (select v37 from aggJoin7674050883121326222 group by v37)
select v37, v38, v41 from aggJoin1346135816577734286 join aggView6624879124495055498 using(v37));
create or replace view aggView5836991150178176418 as select v38, v37 from aggJoin1176461296451090251 group by v38,v37;
create or replace view aggJoin8861987315425561087 as (
with aggView5475731765431083606 as (select v37, MIN(v38) as v51 from aggView5836991150178176418 group by v37)
select v37, v32, v51 from aggJoin154666905628291212 join aggView5475731765431083606 using(v37));
create or replace view aggJoin3356563915662546835 as (
with aggView3342996307199563573 as (select v37, MIN(v51) as v51, MIN(v32) as v50 from aggJoin8861987315425561087 group by v37,v51)
select company_id as v1, company_type_id as v8, note as v23, v51, v50 from movie_companies as mc, aggView3342996307199563573 where mc.movie_id=aggView3342996307199563573.v37 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin3301464644840672408 as (
with aggView6961952620197325247 as (select id as v8 from company_type as ct)
select v1, v23, v51, v50 from aggJoin3356563915662546835 join aggView6961952620197325247 using(v8));
create or replace view aggJoin4174533955811176648 as (
with aggView8286383852826220184 as (select v1, MIN(v51) as v51, MIN(v50) as v50 from aggJoin3301464644840672408 group by v1,v50,v51)
select v2, v51, v50 from aggView1222074857900887351 join aggView8286383852826220184 using(v1));
select MIN(v2) as v49,MIN(v50) as v50,MIN(v51) as v51 from aggJoin4174533955811176648;
