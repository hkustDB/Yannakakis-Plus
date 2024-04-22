create or replace view aggJoin8384222826882270857 as (
with aggView7337689425535763099 as (select id as v1, name as v49 from company_name as cn where country_code<> '[us]')
select movie_id as v37, company_type_id as v8, note as v23, v49 from movie_companies as mc, aggView7337689425535763099 where mc.company_id=aggView7337689425535763099.v1 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin7153953524054315906 as (
with aggView2984048289387141767 as (select id as v12 from info_type as it2 where info= 'rating')
select movie_id as v37, info as v32 from movie_info_idx as mi_idx, aggView2984048289387141767 where mi_idx.info_type_id=aggView2984048289387141767.v12 and info<'7.0');
create or replace view aggJoin7605102141846099628 as (
with aggView2098962318427760948 as (select id as v8 from company_type as ct)
select v37, v23, v49 from aggJoin8384222826882270857 join aggView2098962318427760948 using(v8));
create or replace view aggJoin6394297272345328174 as (
with aggView2842581210856360426 as (select v37, MIN(v49) as v49 from aggJoin7605102141846099628 group by v37,v49)
select id as v37, title as v38, kind_id as v17, production_year as v41, v49 from title as t, aggView2842581210856360426 where t.id=aggView2842581210856360426.v37 and production_year>2009);
create or replace view aggJoin3445205576824086650 as (
with aggView6095135815615062475 as (select id as v17 from kind_type as kt where kind IN ('movie','episode'))
select v37, v38, v41, v49 from aggJoin6394297272345328174 join aggView6095135815615062475 using(v17));
create or replace view aggJoin4712512092875518429 as (
with aggView4477811983179603003 as (select id as v10 from info_type as it1 where info= 'countries')
select movie_id as v37, info as v27 from movie_info as mi, aggView4477811983179603003 where mi.info_type_id=aggView4477811983179603003.v10 and info IN ('Germany','German','USA','American'));
create or replace view aggJoin1871732052011198806 as (
with aggView3869446170593078393 as (select id as v14 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v37 from movie_keyword as mk, aggView3869446170593078393 where mk.keyword_id=aggView3869446170593078393.v14);
create or replace view aggJoin8877152504349112846 as (
with aggView5818423251051785022 as (select v37 from aggJoin4712512092875518429 group by v37)
select v37, v38, v41, v49 as v49 from aggJoin3445205576824086650 join aggView5818423251051785022 using(v37));
create or replace view aggJoin6154628837396770599 as (
with aggView2955010832227111741 as (select v37, MIN(v49) as v49, MIN(v38) as v51 from aggJoin8877152504349112846 group by v37,v49)
select v37, v32, v49, v51 from aggJoin7153953524054315906 join aggView2955010832227111741 using(v37));
create or replace view aggJoin7773603986119795166 as (
with aggView7569679980964791873 as (select v37, MIN(v49) as v49, MIN(v51) as v51, MIN(v32) as v50 from aggJoin6154628837396770599 group by v37,v49,v51)
select v49, v51, v50 from aggJoin1871732052011198806 join aggView7569679980964791873 using(v37));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v51) as v51 from aggJoin7773603986119795166;
