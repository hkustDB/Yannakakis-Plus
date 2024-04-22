create or replace view aggView4785704240644817243 as select id as v1, name as v2 from company_name as cn where country_code<> '[us]';
create or replace view aggJoin5392608073415018052 as (
with aggView3322732524871298080 as (select id as v12 from info_type as it2 where info= 'rating')
select movie_id as v37, info as v32 from movie_info_idx as mi_idx, aggView3322732524871298080 where mi_idx.info_type_id=aggView3322732524871298080.v12 and info<'7.0');
create or replace view aggView7288711309145330467 as select v32, v37 from aggJoin5392608073415018052 group by v32,v37;
create or replace view aggJoin2886367132606869561 as (
with aggView5745774536145896033 as (select id as v17 from kind_type as kt where kind IN ('movie','episode'))
select id as v37, title as v38, production_year as v41 from title as t, aggView5745774536145896033 where t.kind_id=aggView5745774536145896033.v17 and production_year>2008);
create or replace view aggView7183022123118824648 as select v38, v37 from aggJoin2886367132606869561 group by v38,v37;
create or replace view aggJoin1865123902622674769 as (
with aggView6779554653642524376 as (select v37, MIN(v32) as v50 from aggView7288711309145330467 group by v37)
select v38, v37, v50 from aggView7183022123118824648 join aggView6779554653642524376 using(v37));
create or replace view aggJoin3434474223144422662 as (
with aggView3312947245514568424 as (select v37, MIN(v50) as v50, MIN(v38) as v51 from aggJoin1865123902622674769 group by v37,v50)
select movie_id as v37, company_id as v1, company_type_id as v8, note as v23, v50, v51 from movie_companies as mc, aggView3312947245514568424 where mc.movie_id=aggView3312947245514568424.v37 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin2131672139604530152 as (
with aggView4783156436181393502 as (select id as v8 from company_type as ct)
select v37, v1, v23, v50, v51 from aggJoin3434474223144422662 join aggView4783156436181393502 using(v8));
create or replace view aggJoin922788103924392686 as (
with aggView8403859147736733187 as (select id as v10 from info_type as it1 where info= 'countries')
select movie_id as v37, info as v27 from movie_info as mi, aggView8403859147736733187 where mi.info_type_id=aggView8403859147736733187.v10 and info IN ('Germany','German','USA','American'));
create or replace view aggJoin2589805508803676987 as (
with aggView271445192375115290 as (select v37 from aggJoin922788103924392686 group by v37)
select movie_id as v37, keyword_id as v14 from movie_keyword as mk, aggView271445192375115290 where mk.movie_id=aggView271445192375115290.v37);
create or replace view aggJoin497909202726786992 as (
with aggView6639355178278960167 as (select id as v14 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select v37 from aggJoin2589805508803676987 join aggView6639355178278960167 using(v14));
create or replace view aggJoin6385463931563689667 as (
with aggView356308090577550196 as (select v37 from aggJoin497909202726786992 group by v37)
select v1, v23, v50 as v50, v51 as v51 from aggJoin2131672139604530152 join aggView356308090577550196 using(v37));
create or replace view aggJoin5497489753991717741 as (
with aggView4062643605286907733 as (select v1, MIN(v50) as v50, MIN(v51) as v51 from aggJoin6385463931563689667 group by v1,v50,v51)
select v2, v50, v51 from aggView4785704240644817243 join aggView4062643605286907733 using(v1));
select MIN(v2) as v49,MIN(v50) as v50,MIN(v51) as v51 from aggJoin5497489753991717741;
