create or replace view aggView5240591054856919634 as select name as v2, id as v1 from company_name as cn where country_code<> '[us]';
create or replace view aggJoin2439018019114364711 as (
with aggView7433072227509641580 as (select id as v10 from info_type as it1 where info= 'countries')
select movie_id as v37, info as v27 from movie_info as mi, aggView7433072227509641580 where mi.info_type_id=aggView7433072227509641580.v10 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin239883704334933418 as (
with aggView6833522765073477389 as (select id as v14 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v37 from movie_keyword as mk, aggView6833522765073477389 where mk.keyword_id=aggView6833522765073477389.v14);
create or replace view aggJoin6212789600971275576 as (
with aggView7819411676088800095 as (select v37 from aggJoin239883704334933418 group by v37)
select movie_id as v37, info_type_id as v12, info as v32 from movie_info_idx as mi_idx, aggView7819411676088800095 where mi_idx.movie_id=aggView7819411676088800095.v37);
create or replace view aggJoin6448017706334225806 as (
with aggView5627952078612071909 as (select id as v12 from info_type as it2 where info= 'rating')
select v37, v32 from aggJoin6212789600971275576 join aggView5627952078612071909 using(v12));
create or replace view aggJoin5987304975336140209 as (
with aggView2767762195099164469 as (select v37 from aggJoin2439018019114364711 group by v37)
select v37, v32 from aggJoin6448017706334225806 join aggView2767762195099164469 using(v37));
create or replace view aggJoin8946724778081187375 as (
with aggView8131988373830151777 as (select v32, v37 from aggJoin5987304975336140209 group by v32,v37)
select v37, v32 from aggView8131988373830151777 where v32<'8.5');
create or replace view aggJoin8032105050833428903 as (
with aggView7344222079953461855 as (select id as v17 from kind_type as kt where kind IN ('movie','episode'))
select id as v37, title as v38, production_year as v41 from title as t, aggView7344222079953461855 where t.kind_id=aggView7344222079953461855.v17 and production_year>2005);
create or replace view aggView5229450594451412897 as select v37, v38 from aggJoin8032105050833428903 group by v37,v38;
create or replace view aggJoin3343404539609907612 as (
with aggView2614911533768165022 as (select v1, MIN(v2) as v49 from aggView5240591054856919634 group by v1)
select movie_id as v37, company_type_id as v8, v49 from movie_companies as mc, aggView2614911533768165022 where mc.company_id=aggView2614911533768165022.v1);
create or replace view aggJoin3408720661189736137 as (
with aggView4345403701998405936 as (select v37, MIN(v38) as v51 from aggView5229450594451412897 group by v37)
select v37, v32, v51 from aggJoin8946724778081187375 join aggView4345403701998405936 using(v37));
create or replace view aggJoin384296819148569266 as (
with aggView6559344831802832147 as (select id as v8 from company_type as ct)
select v37, v49 from aggJoin3343404539609907612 join aggView6559344831802832147 using(v8));
create or replace view aggJoin5481446122214594161 as (
with aggView2245986698449107354 as (select v37, MIN(v49) as v49 from aggJoin384296819148569266 group by v37,v49)
select v32, v51 as v51, v49 from aggJoin3408720661189736137 join aggView2245986698449107354 using(v37));
select MIN(v49) as v49,MIN(v32) as v50,MIN(v51) as v51 from aggJoin5481446122214594161;
