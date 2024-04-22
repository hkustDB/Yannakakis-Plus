create or replace view aggView2769186009868965763 as select name as v10, id as v9 from company_name as cn where country_code<> '[us]';
create or replace view aggJoin4161369543887591619 as (
with aggView6771072832746018543 as (select id as v22 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v45 from movie_keyword as mk, aggView6771072832746018543 where mk.keyword_id=aggView6771072832746018543.v22);
create or replace view aggJoin7514053202678971708 as (
with aggView7922563100029624833 as (select id as v18 from info_type as it1 where info= 'countries')
select movie_id as v45, info as v35 from movie_info as mi, aggView7922563100029624833 where mi.info_type_id=aggView7922563100029624833.v18 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin1964066926047097977 as (
with aggView5502945482054337077 as (select v45 from aggJoin4161369543887591619 group by v45)
select v45, v35 from aggJoin7514053202678971708 join aggView5502945482054337077 using(v45));
create or replace view aggJoin21000177335641338 as (
with aggView271961334831978550 as (select id as v7 from comp_cast_type as cct2 where kind<> 'complete+verified')
select movie_id as v45, subject_id as v5 from complete_cast as cc, aggView271961334831978550 where cc.status_id=aggView271961334831978550.v7);
create or replace view aggJoin4963642605865605951 as (
with aggView3175994982105711094 as (select id as v5 from comp_cast_type as cct1 where kind= 'crew')
select v45 from aggJoin21000177335641338 join aggView3175994982105711094 using(v5));
create or replace view aggJoin7305567866811188158 as (
with aggView5968249400169855376 as (select v45 from aggJoin4963642605865605951 group by v45)
select v45, v35 from aggJoin1964066926047097977 join aggView5968249400169855376 using(v45));
create or replace view aggJoin2298423724532843749 as (
with aggView6238983974980966344 as (select v45 from aggJoin7305567866811188158 group by v45)
select id as v45, title as v46, kind_id as v25, production_year as v49 from title as t, aggView6238983974980966344 where t.id=aggView6238983974980966344.v45 and production_year>2000);
create or replace view aggJoin3875899613769821328 as (
with aggView8962883231280759427 as (select id as v20 from info_type as it2 where info= 'rating')
select movie_id as v45, info as v40 from movie_info_idx as mi_idx, aggView8962883231280759427 where mi_idx.info_type_id=aggView8962883231280759427.v20 and info<'8.5');
create or replace view aggView6628622440057316965 as select v40, v45 from aggJoin3875899613769821328 group by v40,v45;
create or replace view aggJoin5306069547494282962 as (
with aggView6538307369003097295 as (select id as v25 from kind_type as kt where kind IN ('movie','episode'))
select v45, v46, v49 from aggJoin2298423724532843749 join aggView6538307369003097295 using(v25));
create or replace view aggView8609848239139719543 as select v45, v46 from aggJoin5306069547494282962 group by v45,v46;
create or replace view aggJoin4720626216899856372 as (
with aggView4385212593257020017 as (select v9, MIN(v10) as v57 from aggView2769186009868965763 group by v9)
select movie_id as v45, company_type_id as v16, note as v31, v57 from movie_companies as mc, aggView4385212593257020017 where mc.company_id=aggView4385212593257020017.v9 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin822101968184744674 as (
with aggView7483086187035745581 as (select id as v16 from company_type as ct)
select v45, v31, v57 from aggJoin4720626216899856372 join aggView7483086187035745581 using(v16));
create or replace view aggJoin8112493362542455497 as (
with aggView8672072558991753285 as (select v45, MIN(v57) as v57 from aggJoin822101968184744674 group by v45,v57)
select v40, v45, v57 from aggView6628622440057316965 join aggView8672072558991753285 using(v45));
create or replace view aggJoin7993590486293898333 as (
with aggView6928938689815874290 as (select v45, MIN(v57) as v57, MIN(v40) as v58 from aggJoin8112493362542455497 group by v45,v57)
select v46, v57, v58 from aggView8609848239139719543 join aggView6928938689815874290 using(v45));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v46) as v59 from aggJoin7993590486293898333;
