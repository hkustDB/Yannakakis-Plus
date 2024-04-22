create or replace view aggJoin1193737704085822317 as (
with aggView7470307684104334360 as (select id as v8 from company_type as ct where kind= 'production companies')
select movie_id as v22, company_id as v1 from movie_companies as mc, aggView7470307684104334360 where mc.company_type_id=aggView7470307684104334360.v8);
create or replace view aggJoin4581471929726467652 as (
with aggView681582532197605307 as (select id as v10 from info_type as it where info= 'rating')
select movie_id as v22, info as v29 from movie_info_idx as miidx, aggView681582532197605307 where miidx.info_type_id=aggView681582532197605307.v10);
create or replace view aggJoin4502954672577202535 as (
with aggView4729864248124186232 as (select id as v12 from info_type as it2 where info= 'release dates')
select movie_id as v22, info as v24 from movie_info as mi, aggView4729864248124186232 where mi.info_type_id=aggView4729864248124186232.v12);
create or replace view aggJoin2363018023540828258 as (
with aggView7784417552888280693 as (select id as v1 from company_name as cn where country_code= '[de]')
select v22 from aggJoin1193737704085822317 join aggView7784417552888280693 using(v1));
create or replace view aggJoin9218991654677689369 as (
with aggView3693484619117261229 as (select id as v14 from kind_type as kt where kind= 'movie')
select id as v22, title as v32 from title as t, aggView3693484619117261229 where t.kind_id=aggView3693484619117261229.v14);
create or replace view aggJoin8951933748469468566 as (
with aggView8700645046613819605 as (select v22 from aggJoin2363018023540828258 group by v22)
select v22, v29 from aggJoin4581471929726467652 join aggView8700645046613819605 using(v22));
create or replace view aggJoin8217481676911534575 as (
with aggView5355556163232255332 as (select v22, MIN(v29) as v44 from aggJoin8951933748469468566 group by v22)
select v22, v32, v44 from aggJoin9218991654677689369 join aggView5355556163232255332 using(v22));
create or replace view aggJoin8014287379370346936 as (
with aggView7074616394757271522 as (select v22, MIN(v44) as v44, MIN(v32) as v45 from aggJoin8217481676911534575 group by v22,v44)
select v24, v44, v45 from aggJoin4502954672577202535 join aggView7074616394757271522 using(v22));
select MIN(v24) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin8014287379370346936;
