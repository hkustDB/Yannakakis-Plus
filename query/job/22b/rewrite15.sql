create or replace view aggJoin4511300503402842081 as (
with aggView8404840232082978198 as (select id as v1, name as v49 from company_name as cn where country_code<> '[us]')
select movie_id as v37, company_type_id as v8, note as v23, v49 from movie_companies as mc, aggView8404840232082978198 where mc.company_id=aggView8404840232082978198.v1 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin1449728745987533622 as (
with aggView7722297197454721317 as (select id as v12 from info_type as it2 where info= 'rating')
select movie_id as v37, info as v32 from movie_info_idx as mi_idx, aggView7722297197454721317 where mi_idx.info_type_id=aggView7722297197454721317.v12 and info<'7.0');
create or replace view aggJoin7555414668127188270 as (
with aggView256178322788744189 as (select v37, MIN(v32) as v50 from aggJoin1449728745987533622 group by v37)
select movie_id as v37, keyword_id as v14, v50 from movie_keyword as mk, aggView256178322788744189 where mk.movie_id=aggView256178322788744189.v37);
create or replace view aggJoin6784097924466771393 as (
with aggView7681662403270788829 as (select id as v8 from company_type as ct)
select v37, v23, v49 from aggJoin4511300503402842081 join aggView7681662403270788829 using(v8));
create or replace view aggJoin89087881500595048 as (
with aggView215415506038259636 as (select id as v17 from kind_type as kt where kind IN ('movie','episode'))
select id as v37, title as v38, production_year as v41 from title as t, aggView215415506038259636 where t.kind_id=aggView215415506038259636.v17 and production_year>2009);
create or replace view aggJoin4699780219626409754 as (
with aggView4041156164178042152 as (select v37, MIN(v38) as v51 from aggJoin89087881500595048 group by v37)
select movie_id as v37, info_type_id as v10, info as v27, v51 from movie_info as mi, aggView4041156164178042152 where mi.movie_id=aggView4041156164178042152.v37 and info IN ('Germany','German','USA','American'));
create or replace view aggJoin2823609573519246435 as (
with aggView6873130004039690542 as (select v37, MIN(v49) as v49 from aggJoin6784097924466771393 group by v37,v49)
select v37, v10, v27, v51 as v51, v49 from aggJoin4699780219626409754 join aggView6873130004039690542 using(v37));
create or replace view aggJoin304115981478183669 as (
with aggView3189966846003395700 as (select id as v10 from info_type as it1 where info= 'countries')
select v37, v27, v51, v49 from aggJoin2823609573519246435 join aggView3189966846003395700 using(v10));
create or replace view aggJoin7413881840840755763 as (
with aggView5819596889965031805 as (select v37, MIN(v51) as v51, MIN(v49) as v49 from aggJoin304115981478183669 group by v37,v49,v51)
select v14, v50 as v50, v51, v49 from aggJoin7555414668127188270 join aggView5819596889965031805 using(v37));
create or replace view aggJoin2416275217530529717 as (
with aggView5262063372233539159 as (select id as v14 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select v50, v51, v49 from aggJoin7413881840840755763 join aggView5262063372233539159 using(v14));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v51) as v51 from aggJoin2416275217530529717;
