create or replace view aggView5317480404380242862 as select name as v2, id as v1 from company_name as cn where country_code<> '[us]';
create or replace view aggJoin7878670059676609126 as (
with aggView8468802575309289304 as (select id as v12 from info_type as it2 where info= 'rating')
select movie_id as v37, info as v32 from movie_info_idx as mi_idx, aggView8468802575309289304 where mi_idx.info_type_id=aggView8468802575309289304.v12);
create or replace view aggJoin2146806320954145661 as (
with aggView8280111384140834551 as (select v32, v37 from aggJoin7878670059676609126 group by v32,v37)
select v37, v32 from aggView8280111384140834551 where v32<'8.5');
create or replace view aggJoin5575033833088801762 as (
with aggView3721984071758163465 as (select id as v17 from kind_type as kt where kind IN ('movie','episode'))
select id as v37, title as v38, production_year as v41 from title as t, aggView3721984071758163465 where t.kind_id=aggView3721984071758163465.v17 and production_year>2005);
create or replace view aggView6833836001764509282 as select v37, v38 from aggJoin5575033833088801762 group by v37,v38;
create or replace view aggJoin7117052637668069608 as (
with aggView6324368381711682586 as (select v37, MIN(v32) as v50 from aggJoin2146806320954145661 group by v37)
select movie_id as v37, company_id as v1, company_type_id as v8, v50 from movie_companies as mc, aggView6324368381711682586 where mc.movie_id=aggView6324368381711682586.v37);
create or replace view aggJoin8544988232466487323 as (
with aggView1736065775812511523 as (select v1, MIN(v2) as v49 from aggView5317480404380242862 group by v1)
select v37, v8, v50 as v50, v49 from aggJoin7117052637668069608 join aggView1736065775812511523 using(v1));
create or replace view aggJoin4675644697781400546 as (
with aggView1064859212232767009 as (select id as v10 from info_type as it1 where info= 'countries')
select movie_id as v37, info as v27 from movie_info as mi, aggView1064859212232767009 where mi.info_type_id=aggView1064859212232767009.v10 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin334791169003831445 as (
with aggView3827384104984939357 as (select id as v14 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v37 from movie_keyword as mk, aggView3827384104984939357 where mk.keyword_id=aggView3827384104984939357.v14);
create or replace view aggJoin2749685002954704652 as (
with aggView2495682040078825223 as (select id as v8 from company_type as ct)
select v37, v50, v49 from aggJoin8544988232466487323 join aggView2495682040078825223 using(v8));
create or replace view aggJoin3278759445663446642 as (
with aggView3782064625000815196 as (select v37 from aggJoin334791169003831445 group by v37)
select v37, v27 from aggJoin4675644697781400546 join aggView3782064625000815196 using(v37));
create or replace view aggJoin6587687658677179454 as (
with aggView5274596669229410335 as (select v37 from aggJoin3278759445663446642 group by v37)
select v37, v50 as v50, v49 as v49 from aggJoin2749685002954704652 join aggView5274596669229410335 using(v37));
create or replace view aggJoin7456019775022010292 as (
with aggView2149291481823593639 as (select v37, MIN(v50) as v50, MIN(v49) as v49 from aggJoin6587687658677179454 group by v37,v50,v49)
select v38, v50, v49 from aggView6833836001764509282 join aggView2149291481823593639 using(v37));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v38) as v51 from aggJoin7456019775022010292;
