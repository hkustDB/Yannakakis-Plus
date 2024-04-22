create or replace view aggJoin7748819149903363845 as (
with aggView847527293803989411 as (select id as v1, name as v43 from company_name as cn where country_code= '[us]')
select movie_id as v22, company_type_id as v8, v43 from movie_companies as mc, aggView847527293803989411 where mc.company_id=aggView847527293803989411.v1);
create or replace view aggJoin2795580894948621459 as (
with aggView8977571265149508739 as (select id as v8 from company_type as ct where kind= 'production companies')
select v22, v43 from aggJoin7748819149903363845 join aggView8977571265149508739 using(v8));
create or replace view aggJoin1121318140951446280 as (
with aggView1964858293965349594 as (select v22, MIN(v43) as v43 from aggJoin2795580894948621459 group by v22,v43)
select movie_id as v22, info_type_id as v10, info as v29, v43 from movie_info_idx as miidx, aggView1964858293965349594 where miidx.movie_id=aggView1964858293965349594.v22);
create or replace view aggJoin8998845532414405712 as (
with aggView2569455785910055059 as (select id as v14 from kind_type as kt where kind= 'movie')
select id as v22, title as v32 from title as t, aggView2569455785910055059 where t.kind_id=aggView2569455785910055059.v14);
create or replace view aggJoin2559610211176960307 as (
with aggView5918979376283525225 as (select id as v10 from info_type as it where info= 'rating')
select v22, v29, v43 from aggJoin1121318140951446280 join aggView5918979376283525225 using(v10));
create or replace view aggJoin1702277448298440276 as (
with aggView8591673292303226731 as (select v22, MIN(v43) as v43, MIN(v29) as v44 from aggJoin2559610211176960307 group by v22,v43)
select v22, v32, v43, v44 from aggJoin8998845532414405712 join aggView8591673292303226731 using(v22));
create or replace view aggJoin7556950476362166222 as (
with aggView3931847270608691539 as (select v22, MIN(v43) as v43, MIN(v44) as v44, MIN(v32) as v45 from aggJoin1702277448298440276 group by v22,v43,v44)
select info_type_id as v12, v43, v44, v45 from movie_info as mi, aggView3931847270608691539 where mi.movie_id=aggView3931847270608691539.v22);
create or replace view aggJoin2130129717768863543 as (
with aggView5707509839221836388 as (select id as v12 from info_type as it2 where info= 'release dates')
select v43, v44, v45 from aggJoin7556950476362166222 join aggView5707509839221836388 using(v12));
select MIN(v43) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin2130129717768863543;
