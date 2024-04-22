create or replace view aggView2014400260251687177 as select id as v1, name as v2 from company_name as cn where country_code<> '[us]';
create or replace view aggJoin7934036078858756306 as (
with aggView37373370308280665 as (select id as v12 from info_type as it2 where info= 'rating')
select movie_id as v37, info as v32 from movie_info_idx as mi_idx, aggView37373370308280665 where mi_idx.info_type_id=aggView37373370308280665.v12 and info<'7.0');
create or replace view aggView1923539640803019900 as select v37, v32 from aggJoin7934036078858756306 group by v37,v32;
create or replace view aggJoin8128298847358073495 as (
with aggView223990688305447674 as (select id as v17 from kind_type as kt where kind IN ('movie','episode'))
select id as v37, title as v38, production_year as v41 from title as t, aggView223990688305447674 where t.kind_id=aggView223990688305447674.v17 and production_year>2009);
create or replace view aggView2366718984583621388 as select v38, v37 from aggJoin8128298847358073495 group by v38,v37;
create or replace view aggJoin836443293431517685 as (
with aggView2367443276553635335 as (select v37, MIN(v38) as v51 from aggView2366718984583621388 group by v37)
select v37, v32, v51 from aggView1923539640803019900 join aggView2367443276553635335 using(v37));
create or replace view aggJoin9087545820745121729 as (
with aggView2529411106273312337 as (select v37, MIN(v51) as v51, MIN(v32) as v50 from aggJoin836443293431517685 group by v37,v51)
select movie_id as v37, company_id as v1, company_type_id as v8, note as v23, v51, v50 from movie_companies as mc, aggView2529411106273312337 where mc.movie_id=aggView2529411106273312337.v37 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin4784691672627507865 as (
with aggView2139049910423131764 as (select id as v8 from company_type as ct)
select v37, v1, v23, v51, v50 from aggJoin9087545820745121729 join aggView2139049910423131764 using(v8));
create or replace view aggJoin960001223080065469 as (
with aggView4496164471427684241 as (select id as v10 from info_type as it1 where info= 'countries')
select movie_id as v37, info as v27 from movie_info as mi, aggView4496164471427684241 where mi.info_type_id=aggView4496164471427684241.v10 and info IN ('Germany','German','USA','American'));
create or replace view aggJoin3977923751653204053 as (
with aggView8116914356742889973 as (select id as v14 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v37 from movie_keyword as mk, aggView8116914356742889973 where mk.keyword_id=aggView8116914356742889973.v14);
create or replace view aggJoin6130840939560863271 as (
with aggView1796063913768435976 as (select v37 from aggJoin3977923751653204053 group by v37)
select v37, v27 from aggJoin960001223080065469 join aggView1796063913768435976 using(v37));
create or replace view aggJoin4856866351922041082 as (
with aggView340963176152837093 as (select v37 from aggJoin6130840939560863271 group by v37)
select v1, v23, v51 as v51, v50 as v50 from aggJoin4784691672627507865 join aggView340963176152837093 using(v37));
create or replace view aggJoin4097235971832163003 as (
with aggView8476111808360880757 as (select v1, MIN(v51) as v51, MIN(v50) as v50 from aggJoin4856866351922041082 group by v1,v50,v51)
select v2, v51, v50 from aggView2014400260251687177 join aggView8476111808360880757 using(v1));
select MIN(v2) as v49,MIN(v50) as v50,MIN(v51) as v51 from aggJoin4097235971832163003;
