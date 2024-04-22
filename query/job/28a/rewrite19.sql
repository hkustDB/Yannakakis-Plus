create or replace view aggView6115263092915523834 as select name as v10, id as v9 from company_name as cn where country_code<> '[us]';
create or replace view aggJoin8075430718779760365 as (
with aggView1042968750021004544 as (select id as v20 from info_type as it2 where info= 'rating')
select movie_id as v45, info as v40 from movie_info_idx as mi_idx, aggView1042968750021004544 where mi_idx.info_type_id=aggView1042968750021004544.v20 and info<'8.5');
create or replace view aggView8599750867770252384 as select v40, v45 from aggJoin8075430718779760365 group by v40,v45;
create or replace view aggJoin1260852342602840862 as (
with aggView1696947426481508521 as (select id as v25 from kind_type as kt where kind IN ('movie','episode'))
select id as v45, title as v46, production_year as v49 from title as t, aggView1696947426481508521 where t.kind_id=aggView1696947426481508521.v25 and production_year>2000);
create or replace view aggView5622809892168568463 as select v45, v46 from aggJoin1260852342602840862 group by v45,v46;
create or replace view aggJoin2834989522990237570 as (
with aggView8403466959468577837 as (select v45, MIN(v40) as v58 from aggView8599750867770252384 group by v45)
select movie_id as v45, company_id as v9, company_type_id as v16, note as v31, v58 from movie_companies as mc, aggView8403466959468577837 where mc.movie_id=aggView8403466959468577837.v45 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin2700691734218887586 as (
with aggView2921005260211639086 as (select v9, MIN(v10) as v57 from aggView6115263092915523834 group by v9)
select v45, v16, v31, v58 as v58, v57 from aggJoin2834989522990237570 join aggView2921005260211639086 using(v9));
create or replace view aggJoin273536251409865721 as (
with aggView1223299208666994556 as (select id as v22 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v45 from movie_keyword as mk, aggView1223299208666994556 where mk.keyword_id=aggView1223299208666994556.v22);
create or replace view aggJoin8851052656162707562 as (
with aggView1967431701157882919 as (select id as v18 from info_type as it1 where info= 'countries')
select movie_id as v45, info as v35 from movie_info as mi, aggView1967431701157882919 where mi.info_type_id=aggView1967431701157882919.v18 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin6111786291264327600 as (
with aggView965328497341660369 as (select v45 from aggJoin8851052656162707562 group by v45)
select v45, v16, v31, v58 as v58, v57 as v57 from aggJoin2700691734218887586 join aggView965328497341660369 using(v45));
create or replace view aggJoin8784882949059641465 as (
with aggView5678850187308962721 as (select id as v7 from comp_cast_type as cct2 where kind<> 'complete+verified')
select movie_id as v45, subject_id as v5 from complete_cast as cc, aggView5678850187308962721 where cc.status_id=aggView5678850187308962721.v7);
create or replace view aggJoin2193480918802707858 as (
with aggView7279317367942298058 as (select id as v5 from comp_cast_type as cct1 where kind= 'crew')
select v45 from aggJoin8784882949059641465 join aggView7279317367942298058 using(v5));
create or replace view aggJoin4135991022760562744 as (
with aggView5632044206079221248 as (select id as v16 from company_type as ct)
select v45, v31, v58, v57 from aggJoin6111786291264327600 join aggView5632044206079221248 using(v16));
create or replace view aggJoin5701960989194386822 as (
with aggView7601197316511445619 as (select v45 from aggJoin2193480918802707858 group by v45)
select v45, v31, v58 as v58, v57 as v57 from aggJoin4135991022760562744 join aggView7601197316511445619 using(v45));
create or replace view aggJoin1334264146215249258 as (
with aggView7481592612564187395 as (select v45 from aggJoin273536251409865721 group by v45)
select v45, v31, v58 as v58, v57 as v57 from aggJoin5701960989194386822 join aggView7481592612564187395 using(v45));
create or replace view aggJoin6241201288407124740 as (
with aggView8139804340372342592 as (select v45, MIN(v58) as v58, MIN(v57) as v57 from aggJoin1334264146215249258 group by v45,v58,v57)
select v46, v58, v57 from aggView5622809892168568463 join aggView8139804340372342592 using(v45));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v46) as v59 from aggJoin6241201288407124740;
