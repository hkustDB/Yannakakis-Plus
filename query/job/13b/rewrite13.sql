create or replace view aggJoin2535900391296064057 as (
with aggView7562657718943159449 as (select id as v1, name as v43 from company_name as cn where country_code= '[us]')
select movie_id as v22, company_type_id as v8, v43 from movie_companies as mc, aggView7562657718943159449 where mc.company_id=aggView7562657718943159449.v1);
create or replace view aggJoin3217975029599170608 as (
with aggView1185217215229182604 as (select id as v8 from company_type as ct where kind= 'production companies')
select v22, v43 from aggJoin2535900391296064057 join aggView1185217215229182604 using(v8));
create or replace view aggJoin9203721568440099408 as (
with aggView7185139690771480845 as (select id as v12 from info_type as it2 where info= 'release dates')
select movie_id as v22 from movie_info as mi, aggView7185139690771480845 where mi.info_type_id=aggView7185139690771480845.v12);
create or replace view aggJoin1241190702703329413 as (
with aggView5518812248582860167 as (select id as v10 from info_type as it where info= 'rating')
select movie_id as v22, info as v29 from movie_info_idx as miidx, aggView5518812248582860167 where miidx.info_type_id=aggView5518812248582860167.v10);
create or replace view aggJoin3004682054353227767 as (
with aggView8355440251541095823 as (select v22, MIN(v29) as v44 from aggJoin1241190702703329413 group by v22)
select id as v22, title as v32, kind_id as v14, v44 from title as t, aggView8355440251541095823 where t.id=aggView8355440251541095823.v22 and title<> '' and ((title LIKE '%Champion%') OR (title LIKE '%Loser%')));
create or replace view aggJoin8328889380581890202 as (
with aggView2136106461316091925 as (select id as v14 from kind_type as kt where kind= 'movie')
select v22, v32, v44 from aggJoin3004682054353227767 join aggView2136106461316091925 using(v14));
create or replace view aggJoin6394910759689981389 as (
with aggView249781619716025868 as (select v22, MIN(v44) as v44, MIN(v32) as v45 from aggJoin8328889380581890202 group by v22,v44)
select v22, v43 as v43, v44, v45 from aggJoin3217975029599170608 join aggView249781619716025868 using(v22));
create or replace view aggJoin1108140122762021637 as (
with aggView8490703526379294031 as (select v22, MIN(v43) as v43, MIN(v44) as v44, MIN(v45) as v45 from aggJoin6394910759689981389 group by v22,v43,v44,v45)
select v43, v44, v45 from aggJoin9203721568440099408 join aggView8490703526379294031 using(v22));
select MIN(v43) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin1108140122762021637;
