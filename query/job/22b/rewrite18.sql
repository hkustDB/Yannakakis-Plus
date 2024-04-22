create or replace view aggJoin1708413938100940405 as (
with aggView1974326260973740406 as (select id as v1, name as v49 from company_name as cn where country_code<> '[us]')
select movie_id as v37, company_type_id as v8, note as v23, v49 from movie_companies as mc, aggView1974326260973740406 where mc.company_id=aggView1974326260973740406.v1 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin3207244162060981877 as (
with aggView3919033123610241465 as (select id as v12 from info_type as it2 where info= 'rating')
select movie_id as v37, info as v32 from movie_info_idx as mi_idx, aggView3919033123610241465 where mi_idx.info_type_id=aggView3919033123610241465.v12 and info<'7.0');
create or replace view aggJoin1396975060946483324 as (
with aggView6578657553831536353 as (select id as v8 from company_type as ct)
select v37, v23, v49 from aggJoin1708413938100940405 join aggView6578657553831536353 using(v8));
create or replace view aggJoin5031267911221429022 as (
with aggView1234619329070750954 as (select v37, MIN(v49) as v49 from aggJoin1396975060946483324 group by v37,v49)
select movie_id as v37, keyword_id as v14, v49 from movie_keyword as mk, aggView1234619329070750954 where mk.movie_id=aggView1234619329070750954.v37);
create or replace view aggJoin3233208630086394316 as (
with aggView3538573239699131267 as (select id as v17 from kind_type as kt where kind IN ('movie','episode'))
select id as v37, title as v38, production_year as v41 from title as t, aggView3538573239699131267 where t.kind_id=aggView3538573239699131267.v17 and production_year>2009);
create or replace view aggJoin4406837322708788089 as (
with aggView3814010278350095318 as (select v37, MIN(v38) as v51 from aggJoin3233208630086394316 group by v37)
select v37, v14, v49 as v49, v51 from aggJoin5031267911221429022 join aggView3814010278350095318 using(v37));
create or replace view aggJoin3129565130862938937 as (
with aggView633846143777405325 as (select id as v10 from info_type as it1 where info= 'countries')
select movie_id as v37, info as v27 from movie_info as mi, aggView633846143777405325 where mi.info_type_id=aggView633846143777405325.v10 and info IN ('Germany','German','USA','American'));
create or replace view aggJoin2363455335435122759 as (
with aggView1472956488048133669 as (select v37 from aggJoin3129565130862938937 group by v37)
select v37, v32 from aggJoin3207244162060981877 join aggView1472956488048133669 using(v37));
create or replace view aggJoin630352143527367496 as (
with aggView6484455216588170286 as (select v37, MIN(v32) as v50 from aggJoin2363455335435122759 group by v37)
select v14, v49 as v49, v51 as v51, v50 from aggJoin4406837322708788089 join aggView6484455216588170286 using(v37));
create or replace view aggJoin1128330336637105268 as (
with aggView5673422723775076741 as (select id as v14 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select v49, v51, v50 from aggJoin630352143527367496 join aggView5673422723775076741 using(v14));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v51) as v51 from aggJoin1128330336637105268;
