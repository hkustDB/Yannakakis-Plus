create or replace view aggView4669701385309971501 as select id as v9, name as v10 from company_name as cn where country_code<> '[us]';
create or replace view aggJoin280311828626721081 as (
with aggView1176876323993478951 as (select id as v25 from kind_type as kt where kind IN ('movie','episode'))
select id as v45, title as v46, production_year as v49 from title as t, aggView1176876323993478951 where t.kind_id=aggView1176876323993478951.v25 and production_year>2005);
create or replace view aggView6203663677276637154 as select v46, v45 from aggJoin280311828626721081 group by v46,v45;
create or replace view aggJoin2271937470627291487 as (
with aggView1999685533315690062 as (select id as v20 from info_type as it2 where info= 'rating')
select movie_id as v45, info as v40 from movie_info_idx as mi_idx, aggView1999685533315690062 where mi_idx.info_type_id=aggView1999685533315690062.v20);
create or replace view aggJoin6132586299880892579 as (
with aggView4526178571537064263 as (select v40, v45 from aggJoin2271937470627291487 group by v40,v45)
select v45, v40 from aggView4526178571537064263 where v40<'8.5');
create or replace view aggJoin6424855448546996230 as (
with aggView7489944765264255511 as (select v45, MIN(v40) as v58 from aggJoin6132586299880892579 group by v45)
select movie_id as v45, company_id as v9, company_type_id as v16, note as v31, v58 from movie_companies as mc, aggView7489944765264255511 where mc.movie_id=aggView7489944765264255511.v45 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin4135946504990758786 as (
with aggView7899968115561778845 as (select v9, MIN(v10) as v57 from aggView4669701385309971501 group by v9)
select v45, v16, v31, v58 as v58, v57 from aggJoin6424855448546996230 join aggView7899968115561778845 using(v9));
create or replace view aggJoin2478031057631004605 as (
with aggView6786274731838853981 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v45, status_id as v7 from complete_cast as cc, aggView6786274731838853981 where cc.subject_id=aggView6786274731838853981.v5);
create or replace view aggJoin3643242706501180660 as (
with aggView5586808952858874408 as (select id as v16 from company_type as ct)
select v45, v31, v58, v57 from aggJoin4135946504990758786 join aggView5586808952858874408 using(v16));
create or replace view aggJoin6429783329374291807 as (
with aggView323763234073439791 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete')
select v45 from aggJoin2478031057631004605 join aggView323763234073439791 using(v7));
create or replace view aggJoin3835446210568157290 as (
with aggView6263911250124291795 as (select v45 from aggJoin6429783329374291807 group by v45)
select v45, v31, v58 as v58, v57 as v57 from aggJoin3643242706501180660 join aggView6263911250124291795 using(v45));
create or replace view aggJoin4525233158144243945 as (
with aggView6707854826507352540 as (select id as v22 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v45 from movie_keyword as mk, aggView6707854826507352540 where mk.keyword_id=aggView6707854826507352540.v22);
create or replace view aggJoin1084779337105417927 as (
with aggView7974131753734956612 as (select v45 from aggJoin4525233158144243945 group by v45)
select v45, v31, v58 as v58, v57 as v57 from aggJoin3835446210568157290 join aggView7974131753734956612 using(v45));
create or replace view aggJoin3858313919277596632 as (
with aggView2430566361513266299 as (select id as v18 from info_type as it1 where info= 'countries')
select movie_id as v45, info as v35 from movie_info as mi, aggView2430566361513266299 where mi.info_type_id=aggView2430566361513266299.v18 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin2832833741457006998 as (
with aggView424276924129153072 as (select v45 from aggJoin3858313919277596632 group by v45)
select v45, v31, v58 as v58, v57 as v57 from aggJoin1084779337105417927 join aggView424276924129153072 using(v45));
create or replace view aggJoin3389903415096639156 as (
with aggView5037481617465913076 as (select v45, MIN(v58) as v58, MIN(v57) as v57 from aggJoin2832833741457006998 group by v45,v57,v58)
select v46, v58, v57 from aggView6203663677276637154 join aggView5037481617465913076 using(v45));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v46) as v59 from aggJoin3389903415096639156;
