create or replace view aggJoin5387028305282416978 as (
with aggView4065070732422723040 as (select id as v1, name as v43 from company_name as cn where country_code= '[us]')
select movie_id as v22, company_type_id as v8, v43 from movie_companies as mc, aggView4065070732422723040 where mc.company_id=aggView4065070732422723040.v1);
create or replace view aggJoin866768262389700365 as (
with aggView8777618027653824750 as (select id as v8 from company_type as ct where kind= 'production companies')
select v22, v43 from aggJoin5387028305282416978 join aggView8777618027653824750 using(v8));
create or replace view aggJoin4719173138116068535 as (
with aggView5862775001072579755 as (select id as v10 from info_type as it where info= 'rating')
select movie_id as v22, info as v29 from movie_info_idx as miidx, aggView5862775001072579755 where miidx.info_type_id=aggView5862775001072579755.v10);
create or replace view aggJoin5014410925223139690 as (
with aggView4542741264625673074 as (select v22, MIN(v29) as v44 from aggJoin4719173138116068535 group by v22)
select v22, v43 as v43, v44 from aggJoin866768262389700365 join aggView4542741264625673074 using(v22));
create or replace view aggJoin8710419860938402413 as (
with aggView7255194406441845009 as (select id as v12 from info_type as it2 where info= 'release dates')
select movie_id as v22 from movie_info as mi, aggView7255194406441845009 where mi.info_type_id=aggView7255194406441845009.v12);
create or replace view aggJoin5947813152303546494 as (
with aggView6619140794742333075 as (select id as v14 from kind_type as kt where kind= 'movie')
select id as v22, title as v32 from title as t, aggView6619140794742333075 where t.kind_id=aggView6619140794742333075.v14 and title<> '' and ((title LIKE 'Champion%') OR (title LIKE 'Loser%')));
create or replace view aggJoin8626966746943163230 as (
with aggView3424382965369258765 as (select v22, MIN(v32) as v45 from aggJoin5947813152303546494 group by v22)
select v22, v45 from aggJoin8710419860938402413 join aggView3424382965369258765 using(v22));
create or replace view aggJoin3441790453782535292 as (
with aggView7534633703284281229 as (select v22, MIN(v43) as v43, MIN(v44) as v44 from aggJoin5014410925223139690 group by v22,v44,v43)
select v45 as v45, v43, v44 from aggJoin8626966746943163230 join aggView7534633703284281229 using(v22));
select MIN(v43) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin3441790453782535292;
