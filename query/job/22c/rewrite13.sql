create or replace view aggJoin2974641877605362150 as (
with aggView4939257562737308698 as (select id as v1, name as v49 from company_name as cn where country_code<> '[us]')
select movie_id as v37, company_type_id as v8, note as v23, v49 from movie_companies as mc, aggView4939257562737308698 where mc.company_id=aggView4939257562737308698.v1 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin7202459952998802564 as (
with aggView3568025355231472733 as (select id as v8 from company_type as ct)
select v37, v23, v49 from aggJoin2974641877605362150 join aggView3568025355231472733 using(v8));
create or replace view aggJoin2355910391934770704 as (
with aggView3371478188004460009 as (select id as v17 from kind_type as kt where kind IN ('movie','episode'))
select id as v37, title as v38, production_year as v41 from title as t, aggView3371478188004460009 where t.kind_id=aggView3371478188004460009.v17 and production_year>2005);
create or replace view aggJoin3107391550156548671 as (
with aggView5526950006829026839 as (select v37, MIN(v38) as v51 from aggJoin2355910391934770704 group by v37)
select movie_id as v37, info_type_id as v10, info as v27, v51 from movie_info as mi, aggView5526950006829026839 where mi.movie_id=aggView5526950006829026839.v37 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin1884465700295698975 as (
with aggView3682562772525369383 as (select id as v12 from info_type as it2 where info= 'rating')
select movie_id as v37, info as v32 from movie_info_idx as mi_idx, aggView3682562772525369383 where mi_idx.info_type_id=aggView3682562772525369383.v12 and info<'8.5');
create or replace view aggJoin2488005974990216549 as (
with aggView994534950855698336 as (select id as v10 from info_type as it1 where info= 'countries')
select v37, v27, v51 from aggJoin3107391550156548671 join aggView994534950855698336 using(v10));
create or replace view aggJoin1381978157419180943 as (
with aggView5488873247291004033 as (select v37, MIN(v51) as v51 from aggJoin2488005974990216549 group by v37,v51)
select v37, v32, v51 from aggJoin1884465700295698975 join aggView5488873247291004033 using(v37));
create or replace view aggJoin4631882398717179108 as (
with aggView5347499247167538408 as (select v37, MIN(v51) as v51, MIN(v32) as v50 from aggJoin1381978157419180943 group by v37,v51)
select v37, v23, v49 as v49, v51, v50 from aggJoin7202459952998802564 join aggView5347499247167538408 using(v37));
create or replace view aggJoin4691837464685327362 as (
with aggView4493708399303445375 as (select v37, MIN(v49) as v49, MIN(v51) as v51, MIN(v50) as v50 from aggJoin4631882398717179108 group by v37,v49,v51,v50)
select keyword_id as v14, v49, v51, v50 from movie_keyword as mk, aggView4493708399303445375 where mk.movie_id=aggView4493708399303445375.v37);
create or replace view aggJoin4058835966819217757 as (
with aggView8703436365954665015 as (select id as v14 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select v49, v51, v50 from aggJoin4691837464685327362 join aggView8703436365954665015 using(v14));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v51) as v51 from aggJoin4058835966819217757;
