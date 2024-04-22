create or replace view aggView2143101561574407424 as select name as v10, id as v9 from company_name as cn where country_code<> '[us]';
create or replace view aggJoin4401055656106459437 as (
with aggView1566025699248555657 as (select id as v20 from info_type as it2 where info= 'rating')
select movie_id as v45, info as v40 from movie_info_idx as mi_idx, aggView1566025699248555657 where mi_idx.info_type_id=aggView1566025699248555657.v20 and info<'8.5');
create or replace view aggView4998355223864449512 as select v40, v45 from aggJoin4401055656106459437 group by v40,v45;
create or replace view aggJoin4406987514514170742 as (
with aggView4208901654766384825 as (select id as v25 from kind_type as kt where kind IN ('movie','episode'))
select id as v45, title as v46, production_year as v49 from title as t, aggView4208901654766384825 where t.kind_id=aggView4208901654766384825.v25 and production_year>2000);
create or replace view aggView4938489571588545114 as select v45, v46 from aggJoin4406987514514170742 group by v45,v46;
create or replace view aggJoin6358595745165856689 as (
with aggView5206807713051885598 as (select v45, MIN(v40) as v58 from aggView4998355223864449512 group by v45)
select v45, v46, v58 from aggView4938489571588545114 join aggView5206807713051885598 using(v45));
create or replace view aggJoin4714590324410020540 as (
with aggView3399383686087283699 as (select v9, MIN(v10) as v57 from aggView2143101561574407424 group by v9)
select movie_id as v45, company_type_id as v16, note as v31, v57 from movie_companies as mc, aggView3399383686087283699 where mc.company_id=aggView3399383686087283699.v9 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin804217647240730123 as (
with aggView1633103879115393632 as (select id as v22 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v45 from movie_keyword as mk, aggView1633103879115393632 where mk.keyword_id=aggView1633103879115393632.v22);
create or replace view aggJoin4537452215363804961 as (
with aggView129254211001485938 as (select id as v18 from info_type as it1 where info= 'countries')
select movie_id as v45, info as v35 from movie_info as mi, aggView129254211001485938 where mi.info_type_id=aggView129254211001485938.v18 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin3849269592780536579 as (
with aggView6602787395092365783 as (select v45 from aggJoin4537452215363804961 group by v45)
select v45 from aggJoin804217647240730123 join aggView6602787395092365783 using(v45));
create or replace view aggJoin4281133405820556022 as (
with aggView1860392795321912376 as (select id as v7 from comp_cast_type as cct2 where kind<> 'complete+verified')
select movie_id as v45, subject_id as v5 from complete_cast as cc, aggView1860392795321912376 where cc.status_id=aggView1860392795321912376.v7);
create or replace view aggJoin6461632571781305584 as (
with aggView5513967693822873324 as (select id as v5 from comp_cast_type as cct1 where kind= 'crew')
select v45 from aggJoin4281133405820556022 join aggView5513967693822873324 using(v5));
create or replace view aggJoin7131707885816863419 as (
with aggView4137680539411888077 as (select v45 from aggJoin6461632571781305584 group by v45)
select v45 from aggJoin3849269592780536579 join aggView4137680539411888077 using(v45));
create or replace view aggJoin802872321426380370 as (
with aggView7248531847367054 as (select id as v16 from company_type as ct)
select v45, v31, v57 from aggJoin4714590324410020540 join aggView7248531847367054 using(v16));
create or replace view aggJoin5465307968948765293 as (
with aggView5928177665768935111 as (select v45 from aggJoin7131707885816863419 group by v45)
select v45, v31, v57 as v57 from aggJoin802872321426380370 join aggView5928177665768935111 using(v45));
create or replace view aggJoin67720828717900465 as (
with aggView8026249755534043436 as (select v45, MIN(v57) as v57 from aggJoin5465307968948765293 group by v45,v57)
select v46, v58 as v58, v57 from aggJoin6358595745165856689 join aggView8026249755534043436 using(v45));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v46) as v59 from aggJoin67720828717900465;
