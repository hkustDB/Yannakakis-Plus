create or replace view aggView149677650953417220 as select id as v9, name as v10 from company_name as cn where country_code<> '[us]';
create or replace view aggJoin241580959399794756 as (
with aggView6155945957346554386 as (select id as v25 from kind_type as kt where kind IN ('movie','episode'))
select id as v45, title as v46, production_year as v49 from title as t, aggView6155945957346554386 where t.kind_id=aggView6155945957346554386.v25 and production_year>2005);
create or replace view aggView2074306946417009947 as select v46, v45 from aggJoin241580959399794756 group by v46,v45;
create or replace view aggJoin6242302892819203762 as (
with aggView9168329017778174419 as (select id as v20 from info_type as it2 where info= 'rating')
select movie_id as v45, info as v40 from movie_info_idx as mi_idx, aggView9168329017778174419 where mi_idx.info_type_id=aggView9168329017778174419.v20);
create or replace view aggJoin2016737415355151603 as (
with aggView6172775621998892638 as (select id as v22 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v45 from movie_keyword as mk, aggView6172775621998892638 where mk.keyword_id=aggView6172775621998892638.v22);
create or replace view aggJoin3516481766362759267 as (
with aggView3259025797785891499 as (select v45 from aggJoin2016737415355151603 group by v45)
select v45, v40 from aggJoin6242302892819203762 join aggView3259025797785891499 using(v45));
create or replace view aggJoin5973903955731954548 as (
with aggView6731837026855107166 as (select v40, v45 from aggJoin3516481766362759267 group by v40,v45)
select v45, v40 from aggView6731837026855107166 where v40<'8.5');
create or replace view aggJoin949803340948596988 as (
with aggView5870558569200239219 as (select v45, MIN(v46) as v59 from aggView2074306946417009947 group by v45)
select v45, v40, v59 from aggJoin5973903955731954548 join aggView5870558569200239219 using(v45));
create or replace view aggJoin8124530963311293613 as (
with aggView4537835656392866398 as (select v45, MIN(v59) as v59, MIN(v40) as v58 from aggJoin949803340948596988 group by v45,v59)
select movie_id as v45, company_id as v9, company_type_id as v16, note as v31, v59, v58 from movie_companies as mc, aggView4537835656392866398 where mc.movie_id=aggView4537835656392866398.v45 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin5050953775144934787 as (
with aggView9019866942110967797 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v45, status_id as v7 from complete_cast as cc, aggView9019866942110967797 where cc.subject_id=aggView9019866942110967797.v5);
create or replace view aggJoin9205643842389319374 as (
with aggView6261322272781837963 as (select id as v16 from company_type as ct)
select v45, v9, v31, v59, v58 from aggJoin8124530963311293613 join aggView6261322272781837963 using(v16));
create or replace view aggJoin3160590813596361676 as (
with aggView2091892845312702124 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete')
select v45 from aggJoin5050953775144934787 join aggView2091892845312702124 using(v7));
create or replace view aggJoin5030033722777639181 as (
with aggView3807868879607625870 as (select id as v18 from info_type as it1 where info= 'countries')
select movie_id as v45, info as v35 from movie_info as mi, aggView3807868879607625870 where mi.info_type_id=aggView3807868879607625870.v18 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin5169529008249365247 as (
with aggView1434701862375591887 as (select v45 from aggJoin5030033722777639181 group by v45)
select v45 from aggJoin3160590813596361676 join aggView1434701862375591887 using(v45));
create or replace view aggJoin8598140371066392320 as (
with aggView6786109732377612354 as (select v45 from aggJoin5169529008249365247 group by v45)
select v9, v31, v59 as v59, v58 as v58 from aggJoin9205643842389319374 join aggView6786109732377612354 using(v45));
create or replace view aggJoin5749805484670488824 as (
with aggView5102964367683409918 as (select v9, MIN(v59) as v59, MIN(v58) as v58 from aggJoin8598140371066392320 group by v9,v58,v59)
select v10, v59, v58 from aggView149677650953417220 join aggView5102964367683409918 using(v9));
select MIN(v10) as v57,MIN(v58) as v58,MIN(v59) as v59 from aggJoin5749805484670488824;
