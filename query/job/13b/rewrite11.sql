create or replace view aggView8183138544363370433 as select id as v1, name as v2 from company_name as cn where country_code= '[us]';
create or replace view aggJoin1388841567249874323 as (
with aggView1031635182653578903 as (select id as v10 from info_type as it where info= 'rating')
select movie_id as v22, info as v29 from movie_info_idx as miidx, aggView1031635182653578903 where miidx.info_type_id=aggView1031635182653578903.v10);
create or replace view aggView204676011638906278 as select v22, v29 from aggJoin1388841567249874323 group by v22,v29;
create or replace view aggJoin5875169719060418988 as (
with aggView4458441153210443059 as (select id as v14 from kind_type as kt where kind= 'movie')
select id as v22, title as v32 from title as t, aggView4458441153210443059 where t.kind_id=aggView4458441153210443059.v14 and title<> '' and ((title LIKE '%Champion%') OR (title LIKE '%Loser%')));
create or replace view aggView3183252661206353498 as select v22, v32 from aggJoin5875169719060418988 group by v22,v32;
create or replace view aggJoin3957938674554572097 as (
with aggView9041009268228774937 as (select v1, MIN(v2) as v43 from aggView8183138544363370433 group by v1)
select movie_id as v22, company_type_id as v8, v43 from movie_companies as mc, aggView9041009268228774937 where mc.company_id=aggView9041009268228774937.v1);
create or replace view aggJoin2623058708874799182 as (
with aggView2563308459894963947 as (select v22, MIN(v29) as v44 from aggView204676011638906278 group by v22)
select v22, v32, v44 from aggView3183252661206353498 join aggView2563308459894963947 using(v22));
create or replace view aggJoin2237704693233976813 as (
with aggView62425438935743623 as (select id as v8 from company_type as ct where kind= 'production companies')
select v22, v43 from aggJoin3957938674554572097 join aggView62425438935743623 using(v8));
create or replace view aggJoin3129348503240676878 as (
with aggView618690880477749826 as (select id as v12 from info_type as it2 where info= 'release dates')
select movie_id as v22 from movie_info as mi, aggView618690880477749826 where mi.info_type_id=aggView618690880477749826.v12);
create or replace view aggJoin4933897790229664440 as (
with aggView3184310601008433747 as (select v22 from aggJoin3129348503240676878 group by v22)
select v22, v43 as v43 from aggJoin2237704693233976813 join aggView3184310601008433747 using(v22));
create or replace view aggJoin268197704857298322 as (
with aggView3842633763585832208 as (select v22, MIN(v43) as v43 from aggJoin4933897790229664440 group by v22,v43)
select v32, v44 as v44, v43 from aggJoin2623058708874799182 join aggView3842633763585832208 using(v22));
select MIN(v43) as v43,MIN(v44) as v44,MIN(v32) as v45 from aggJoin268197704857298322;
