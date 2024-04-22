create or replace view aggView4016196509601420318 as select name as v2, id as v17 from company_name as cn where country_code<> '[pl]' and ((name LIKE '20th Century Fox%') OR (name LIKE 'Twentieth Century Fox%'));
create or replace view aggJoin6066304465348217360 as (
with aggView9022339473821458009 as (select id as v22 from keyword as k where keyword IN ('sequel','revenge','based-on-novel'))
select movie_id as v24 from movie_keyword as mk, aggView9022339473821458009 where mk.keyword_id=aggView9022339473821458009.v22);
create or replace view aggJoin2200846662775000377 as (
with aggView2656235591485298539 as (select id as v18 from company_type as ct where kind<> 'production companies')
select movie_id as v24, company_id as v17, note as v19 from movie_companies as mc, aggView2656235591485298539 where mc.company_type_id=aggView2656235591485298539.v18);
create or replace view aggView8752065699995143707 as select v19, v24, v17 from aggJoin2200846662775000377 group by v19,v24,v17;
create or replace view aggJoin5960338778837562730 as (
with aggView3974311209221293337 as (select v24 from aggJoin6066304465348217360 group by v24)
select id as v24, title as v28, production_year as v31 from title as t, aggView3974311209221293337 where t.id=aggView3974311209221293337.v24 and production_year>1950);
create or replace view aggJoin4574361945523971748 as (
with aggView5664327520815942517 as (select id as v13 from link_type as lt)
select movie_id as v24 from movie_link as ml, aggView5664327520815942517 where ml.link_type_id=aggView5664327520815942517.v13);
create or replace view aggJoin820081049170352335 as (
with aggView3207029057120849793 as (select v24 from aggJoin4574361945523971748 group by v24)
select v24, v28, v31 from aggJoin5960338778837562730 join aggView3207029057120849793 using(v24));
create or replace view aggView833913831892334268 as select v28, v24 from aggJoin820081049170352335 group by v28,v24;
create or replace view aggJoin9004679085277326281 as (
with aggView8788495017377570994 as (select v17, MIN(v2) as v39 from aggView4016196509601420318 group by v17)
select v19, v24, v39 from aggView8752065699995143707 join aggView8788495017377570994 using(v17));
create or replace view aggJoin8482715400549238332 as (
with aggView5871553879227349392 as (select v24, MIN(v39) as v39, MIN(v19) as v40 from aggJoin9004679085277326281 group by v24,v39)
select v28, v39, v40 from aggView833913831892334268 join aggView5871553879227349392 using(v24));
select MIN(v39) as v39,MIN(v40) as v40,MIN(v28) as v41 from aggJoin8482715400549238332;
