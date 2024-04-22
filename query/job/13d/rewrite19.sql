create or replace view aggJoin7315408727968829541 as (
with aggView4015145304661500327 as (select id as v1, name as v43 from company_name as cn where country_code= '[us]')
select movie_id as v22, company_type_id as v8, v43 from movie_companies as mc, aggView4015145304661500327 where mc.company_id=aggView4015145304661500327.v1);
create or replace view aggJoin9187468623802568478 as (
with aggView4409782563093457171 as (select id as v8 from company_type as ct where kind= 'production companies')
select v22, v43 from aggJoin7315408727968829541 join aggView4409782563093457171 using(v8));
create or replace view aggJoin5502571622430724514 as (
with aggView4339208671373242680 as (select id as v14 from kind_type as kt where kind= 'movie')
select id as v22, title as v32 from title as t, aggView4339208671373242680 where t.kind_id=aggView4339208671373242680.v14);
create or replace view aggJoin7176875382374112405 as (
with aggView5316859803439617449 as (select v22, MIN(v32) as v45 from aggJoin5502571622430724514 group by v22)
select movie_id as v22, info_type_id as v12, v45 from movie_info as mi, aggView5316859803439617449 where mi.movie_id=aggView5316859803439617449.v22);
create or replace view aggJoin1655615803529648996 as (
with aggView3876881241548694531 as (select id as v12 from info_type as it2 where info= 'release dates')
select v22, v45 from aggJoin7176875382374112405 join aggView3876881241548694531 using(v12));
create or replace view aggJoin2906251836412355355 as (
with aggView2159299966941480835 as (select id as v10 from info_type as it where info= 'rating')
select movie_id as v22, info as v29 from movie_info_idx as miidx, aggView2159299966941480835 where miidx.info_type_id=aggView2159299966941480835.v10);
create or replace view aggJoin1325303544878793194 as (
with aggView4847991216687725704 as (select v22, MIN(v29) as v44 from aggJoin2906251836412355355 group by v22)
select v22, v43 as v43, v44 from aggJoin9187468623802568478 join aggView4847991216687725704 using(v22));
create or replace view aggJoin3935291347201847760 as (
with aggView115229004899912470 as (select v22, MIN(v43) as v43, MIN(v44) as v44 from aggJoin1325303544878793194 group by v22,v43,v44)
select v45 as v45, v43, v44 from aggJoin1655615803529648996 join aggView115229004899912470 using(v22));
select MIN(v43) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin3935291347201847760;
