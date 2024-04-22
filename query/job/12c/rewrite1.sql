create or replace view aggView8671827134431137288 as select id as v29, title as v30 from title as t where production_year>=2000 and production_year<=2010;
create or replace view aggView5127001172744892458 as select name as v2, id as v1 from company_name as cn where country_code= '[us]';
create or replace view aggJoin5850079259245252394 as (
with aggView887766976815807291 as (select id as v26 from info_type as it2 where info= 'rating')
select movie_id as v29, info as v27 from movie_info_idx as mi_idx, aggView887766976815807291 where mi_idx.info_type_id=aggView887766976815807291.v26);
create or replace view aggJoin1144955860440766116 as (
with aggView8986944569258165223 as (select id as v21 from info_type as it1 where info= 'genres')
select movie_id as v29, info as v22 from movie_info as mi, aggView8986944569258165223 where mi.info_type_id=aggView8986944569258165223.v21 and info IN ('Drama','Horror','Western','Family'));
create or replace view aggJoin8185223984932715104 as (
with aggView4581170554041500459 as (select v29 from aggJoin1144955860440766116 group by v29)
select v29, v27 from aggJoin5850079259245252394 join aggView4581170554041500459 using(v29));
create or replace view aggJoin2661717540931882795 as (
with aggView4442972760539539946 as (select v29, v27 from aggJoin8185223984932715104 group by v29,v27)
select v29, v27 from aggView4442972760539539946 where v27>'7.0');
create or replace view aggJoin7805346569206056008 as (
with aggView6788965294823925030 as (select v29, MIN(v27) as v42 from aggJoin2661717540931882795 group by v29)
select v29, v30, v42 from aggView8671827134431137288 join aggView6788965294823925030 using(v29));
create or replace view aggJoin6241436171718504936 as (
with aggView4358902981957003941 as (select v29, MIN(v42) as v42, MIN(v30) as v43 from aggJoin7805346569206056008 group by v29,v42)
select company_id as v1, company_type_id as v8, v42, v43 from movie_companies as mc, aggView4358902981957003941 where mc.movie_id=aggView4358902981957003941.v29);
create or replace view aggJoin6502291068105422799 as (
with aggView1475655556506706636 as (select id as v8 from company_type as ct where kind= 'production companies')
select v1, v42, v43 from aggJoin6241436171718504936 join aggView1475655556506706636 using(v8));
create or replace view aggJoin2363904660193415243 as (
with aggView257252468835385904 as (select v1, MIN(v42) as v42, MIN(v43) as v43 from aggJoin6502291068105422799 group by v1,v42,v43)
select v2, v42, v43 from aggView5127001172744892458 join aggView257252468835385904 using(v1));
select MIN(v2) as v41,MIN(v42) as v42,MIN(v43) as v43 from aggJoin2363904660193415243;
